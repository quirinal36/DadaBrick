package dada.brick.com.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.sendgrid.SendGridException;

import dada.brick.com.Config;
import dada.brick.com.util.RestUtil;
import dada.brick.com.vo.EmailToken;
import dada.brick.com.vo.KakaoLogin;
import dada.brick.com.vo.UserVO;

@RequestMapping("/member")
@Controller
public class MemberController extends DadaController{
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView getLoginView(ModelAndView mv,
			HttpServletRequest request,
			@RequestParam(value = "loginRedirect", required = false) String redirectUrl,
			HttpSession session) throws IOException {
		String accessToken = (String)session.getAttribute("access_token");
		
		if(accessToken != null && accessToken.length()>0) {
			RestUtil util = new RestUtil();
			JSONObject response = util.post("v2/user/me", accessToken);
			if(response != null) {
				JSONObject accountObj = response.getJSONObject("kakao_account");
				UserVO user = new UserVO();
				user.setKakaoId(String.valueOf(response.getInt("id")));
				
				if(accountObj.has("email")) {
					user.setEmail(accountObj.getString("email"));
				}
				
				mv.setViewName("redirect:"+redirectUrl);
			}
		}else {
			File file = ResourceUtils.getFile("classpath:kakao.env");
			String apiKey = FileUtils.readFileToString(file, Config.ENCODING);
			mv.addObject("loginRedirect", redirectUrl);
			mv.addObject("apiKey", apiKey);
			mv.setViewName("/member/login");
		}
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/login/complete", method=RequestMethod.POST)
	public String postSignupView(@RequestBody KakaoLogin kakao, HttpServletRequest request,
			HttpSession session) throws IOException {
		session.setAttribute("access_token", kakao.getAccess_token());
		
		RestUtil util = new RestUtil();
		
		JSONObject response = util.post("v2/user/me", kakao.getAccess_token());
		JSONObject accountObj = response.getJSONObject("kakao_account");
		
		JSONObject profileObj = accountObj.getJSONObject("profile");
		UserVO user = new UserVO();
		user.setKakaoId(String.valueOf(response.getInt("id")));
		if(accountObj.has("email")) {
			user.setEmail(accountObj.getString("email"));
		}
		user.setNickname(profileObj.getString("nickname"));
		if(profileObj.has("thumbnail_image_url")) {
			user.setThumbnail_image_url(profileObj.getString("thumbnail_image_url"));
		}
		if(profileObj.has("profile_image_url")) {
			user.setProfile_image_url(profileObj.getString("profile_image_url"));
		}

		UserVO selectUser = userService.selectOne(user);
		if(selectUser != null) {
			login(selectUser.getKakaoId(), "", request);
			return selectUser.toString();
		}else {
			int insertResult = userService.insert(user);
			if(insertResult > 0) {
				login(user.getKakaoId(), "", request);
			}
			return user.toString();
		}
	}
	
	private void login(String login, String inputPwd, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(login, inputPwd);
		authToken.setDetails(new WebAuthenticationDetails(request));
		Authentication authentication = authenticationManager.authenticate(authToken);
		SecurityContextHolder.getContext().setAuthentication(authentication);
	}
	
	@RequestMapping(value= {"/signup", "/signup/{complete}"}, method = RequestMethod.GET)
	public ModelAndView getSignupView(ModelAndView mv,
			HttpServletRequest request, @PathVariable(value="complete")Optional<String> complete) {
		if(isLoginedUser(request)) {
			mv.setViewName("redirect:/");
		}else {
			final String currentUrl = "/member/signup";
			mv.addObject("curMenu", getCurMenus(currentUrl));
			mv.addObject("title", "회원가입");
			
			if(isLoginedUser(request) && complete.isPresent()) {
				logger.info("afterSignup present");
				mv.addObject("afterSignup", complete.get());
			}
			
			mv.setViewName("/member/signup");
		}
		return mv;
	}
	
	/**
	 * 회원가입 결과
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/signup", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String saveUser(UserVO user,
			HttpServletRequest request) {
		final String inputPwd = user.getPassword();
		int result = userService.insert(user);
		
		// 회원가입 직후 로그인
		login(user.getLogin(), inputPwd, request);

		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	/**
	 * 중복 아이디가 존재하는지 
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/get", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public String getUser(UserVO user, Locale locale) {
		List<UserVO> findUsers = userService.select(user);
		
		JSONObject json = new JSONObject();
		if(findUsers != null && findUsers.size()>0) {
			json.put("result", findUsers.size());
			json.put("message", messageSource.getMessage("member.signup.exist", null, locale));
		}else if(userService.isValid(user)==false) {
			json.put("result", -1);
			json.put("message", messageSource.getMessage("member.signup.login.length", null, locale));
		}else {
			json.put("result", 0);
			json.put("message", messageSource.getMessage("member.signup.login.enable", null, locale));
		}
		
		return json.toString();
	}
	
	@RequestMapping(value="/findId", method = RequestMethod.GET)
	public ModelAndView getFindIdView(ModelAndView mv) {
		mv.setViewName("/member/findId");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/findId", method = RequestMethod.POST, produces = "application/json; charset=utf8;")
	public String postFindIdView(ModelAndView mv, UserVO user) {
		JSONObject json = new JSONObject();
		user = userService.selectFindId(user);
		if(user != null && user.getId()>0) {
			json.put("result", user.getId());
			json.put("login", user.getLogin());
		}else {
			json.put("result", 0);
		}
		return json.toString();
	}
	/**
	 * 비밀번호 찾기 화면
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/findPwd", method = RequestMethod.GET)
	public ModelAndView getFindPwdView(ModelAndView mv, HttpServletRequest request) {
		if(isLoginedUser(request)) {
			mv.setViewName("redirect:/");
			return mv;
		}
		final String currentUrl = "/member/findPwd";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.setViewName("/member/findPwd");
		return mv;
	}
	private String fullEmail(UserVO input) {
		return new StringBuilder().append(input.getEmail()).append("@").append(input.getDomain()).toString();
	}
	@ResponseBody
	@RequestMapping(value="/findPwd/submit", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String sendEmailForFindPwd(UserVO user, HttpServletRequest request,
			Locale locale) {
		
		JSONObject json = new JSONObject();
		UserVO selectedUser = userService.selectOne(user);
		if(selectedUser == null) {
			json.put("result", -1);
			json.put("msg", messageSource.getMessage("member.find_pwd.not_exist", null, locale));
		}else {
			if(fullEmail(selectedUser).equals(user.getEmail())) {
				EmailToken resetToken = EmailToken.newInstance(selectedUser.getId(), UUID.randomUUID().toString());
				resetToken.setIsPwd(EmailToken.IS_PWD);
				resetToken.setUserId(selectedUser.getId());
				int result = tokenService.insert(resetToken);
				if(result > 0) {
					final String baseUrl = getBaseUrl(request);
					final String subject = messageSource.getMessage("member.find.email_title", null, locale);
					try {
						resetToken.sendEmail(baseUrl, subject, selectedUser, resetToken, locale);
						json.put("result", result);
					} catch (IOException e) {
						e.printStackTrace();
					} catch (SendGridException e) {
						e.printStackTrace();
					}
				}
		
				String msg = messageSource.getMessage("member.find.password.submit", null, locale);
				
				final String regex = "\\{(email)\\}";
				Pattern pattern = Pattern.compile(regex);
				Matcher matcher = pattern.matcher(msg);
				if (matcher.find()) {
					// 사용자 email
					msg = msg.replace(matcher.group(0), user.getEmail());
				}
				json.put("msg", msg);
				json.put("result", 1);
			}else {
				json.put("result", 0);
				json.put("msg", messageSource.getMessage("member.find_pwd.email_not_matched", null, locale));
			}
		}
		return json.toString();
	}
	@RequestMapping(value="/validate/token")
	public ModelAndView getValidateTokenView(ModelAndView mv, 
			EmailToken emailToken, HttpServletRequest request) {
		final String currentUrl = "/member/newPwd";
		
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "비밀번호변경");
		
		EmailToken selectedToken = tokenService.selectOne(emailToken);
		if(selectedToken.getId() > 0) {
			boolean isValid = selectedToken.isValidToken(emailToken.getToken());
			
			if(isValid) {
				UserVO user = userService.selectOne(UserVO.newInstanse(emailToken.getUserId()));
				mv.addObject("user", user);
			}
		}
		return mv;
	}
	/**
	 * 새 비밀번호 입력화면
	 * @param mv
	 * @return
	 */
	@RequestMapping("/newPwd")
	public ModelAndView getNewPwdView(ModelAndView mv, HttpServletRequest request) {
		final String currentUrl = "/member/newPwd";
		mv.addObject("curMenu", getCurMenus(currentUrl));
	
		UserVO user = getUser();
		mv.addObject("user", user);
		mv.setViewName("/member/newPwd");
		return mv;
	}
	
	/**
	 * 새 비밀번호 적용
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value= {"/newPwd/send", "/newPwd/send/{userId}"}, method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String sendNewPwd(Locale locale, UserVO user, HttpServletRequest request,
			HttpServletResponse response, @PathVariable("userId")Optional<Integer>userId) {
		JSONObject json = new JSONObject();
		
		if(userId.isPresent()) {
			UserVO cUser = UserVO.newInstanse(userId.get());
			cUser.setPassword(user.getPassword());
			int result = userService.update(cUser);
			json.put("result", result);
			if(result > 0) {
				tokenService.delete(EmailToken.newInstance(user.getId()));
			}
		}else if(isLoginedUser(request)) {
			UserVO loginedUser = getUser();
			loginedUser.setPassword(user.getPassword());
			json.put("result", userService.update(loginedUser));
		}else {
			json.put("result", 0);
			json.put("message", messageSource.getMessage("member.please_login", null, locale));
		}
		
		return json.toString();
	}
	
	@RequestMapping("/myinfo")
	public ModelAndView getMyinfoView(ModelAndView mv, 
			HttpServletRequest request) {
		if(!isLoginedUser(request)) {
			mv.setViewName("redirect:/member/login");
			return mv;
		}
		
		final String currentUrl = "/member/myinfo";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		UserVO user = getUser();
		
		mv.addObject("user", user);
		mv.setViewName("/member/myinfo");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/edit", method = RequestMethod.POST)
	public String postEditInfo(UserVO user) {
		JSONObject json = new JSONObject();
		int result = userService.update(user);
		json.put("result", result);
		return json.toString();
	}
	/**
	 * 회원정보 수정창
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/edit", method = RequestMethod.GET)
	public ModelAndView getEditView(ModelAndView mv,
			HttpServletRequest request) {
		if(!isLoginedUser(request)) {
			mv.setViewName("redirect:/member/login");
			return mv;
		}
		
		final String currentUrl = "/member/myinfo";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		UserVO user = getUser();
		
		mv.addObject("user", user);
		mv.setViewName("/member/edit");
		return mv;
	}
	/**
	 * 회원탈퇴
	 * @param mv
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/delete", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String deleteUser(Locale locale, @RequestParam(value="password")String password) {
		UserVO user = getUser();
		JSONObject json = new JSONObject();
		if(user != null) {
			boolean passwordMatches = userService.isPasswordValid(user, password);
			
			if(passwordMatches) {
				json.put("result", userService.delete(user));
				json.put("logout", "/j_spring_security_logout");
			}else {
				json.put("result", 0);
				json.put("msg", messageSource.getMessage("member.signup.not_matched_pwd", null, locale));
			}
		}
		return json.toString();
	}
	@RequestMapping(value="/delete", method = RequestMethod.GET)
	public ModelAndView getDeleteView(ModelAndView mv) {
		mv.setViewName("/member/delete");
		return mv;
	}
	
	@RequestMapping(value="/loginProcess", method= RequestMethod.POST)
	public ModelAndView getLoginProcessPostView(ModelAndView mv) {
		mv.setViewName("/member/login");
		return mv;
	}
	
	/**
	 * 로그인 한 유저인지 판별
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/isLogin")
	public String isLoginedUserView(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		json.put("result", isLoginedUser(request));
		
		return json.toString();
	}
	
	/**
	 * 관리자 유저인지 판별
	 * 
	 * @param request
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/isAdmin")
	public String isAdminUser(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		json.put("result", request.isUserInRole(UserVO.ADMIN));
		return json.toString();
	}
}
