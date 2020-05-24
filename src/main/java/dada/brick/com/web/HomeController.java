package dada.brick.com.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dada.brick.com.Config;
import dada.brick.com.service.SlidePhotoService;
import dada.brick.com.vo.Board;
import dada.brick.com.vo.SlidePhotoInfo;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends DadaController {
	@Autowired
	SlidePhotoService slidePhotoService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		List<SlidePhotoInfo> slideList = slidePhotoService.select(SlidePhotoInfo.newInstance(SlidePhotoInfo.INDEX_MAIN));
		List<SlidePhotoInfo> productList = slidePhotoService.select(SlidePhotoInfo.newInstance(SlidePhotoInfo.INDEX_MENU));
		
		mv.addObject("slideList", slideList);
		mv.addObject("productList", productList);
		
		mv.setViewName("index");
		return mv;
	}
	@RequestMapping(value="/search")
	public ModelAndView getCompanyView(Locale locale, ModelAndView mv) {
		
		mv.setViewName("/contents/search");
		return mv;
	}
	@RequestMapping(value = {"/company","/company/{id}"}, method = RequestMethod.GET)
	public ModelAndView getCompanyView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/contents/company");
		return mv;
	}
	@RequestMapping(value = "/information", method = RequestMethod.GET)
	public ModelAndView getInformationView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("information");
		return mv;
	}
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public ModelAndView getNoticeView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("notice");
		return mv;
	}
	@RequestMapping(value = "/picture", method = RequestMethod.GET)
	public ModelAndView getPictureView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("picture");
		return mv;
	}
	
	@RequestMapping(value="/links")
	public ModelAndView getLinksView(ModelAndView mv) {
		mv.setViewName("/links");
		return mv;
	}
	@RequestMapping(value="/error_400")
	public ModelAndView getError404View(ModelAndView mv) {
		mv.setViewName("/error/404");
		return mv;
	}
	@RequestMapping(value="/error_500")
	public ModelAndView getError503View(ModelAndView mv) {
		mv.setViewName("/error/503");
		return mv;
	}
	@RequestMapping(value="/inc/head_admin")
	public ModelAndView getAdminHeadView(ModelAndView mv) {
		mv.setViewName("/inc/head_admin");
		return mv;
	}
	
	@RequestMapping(value="/term/privacy")
	public ModelAndView getPrivacyView(ModelAndView mv) {
		mv.setViewName("/term/privacy");
		return mv;
	}
	@RequestMapping(value="/term/email")
	public ModelAndView getEmailTermView(ModelAndView mv) {
		mv.setViewName("/term/email");
		return mv;
	}
	/**
	 * JAVASCRIPT i18n 을 위함
	 * properties 파일을 읽어와 List 형태로 돌려준다.
	 * 
	 * @param propertiesName
	 * @param response
	 * @param locale
	 */
	@RequestMapping(value="/properties/{propertiesName}")
	public void getProperties(@PathVariable("propertiesName")Optional<String> propertiesName, 
			HttpServletResponse response, Locale locale) {
		response.setCharacterEncoding(Config.ENCODING);
		
		if(propertiesName.isPresent()) {
			try {
				List<String> readLines = FileUtils.readLines(ResourceUtils.getFile("classpath:messages/" + propertiesName.get() + ".properties"), Config.ENCODING);
				OutputStream outputStream = response.getOutputStream();
				IOUtils.writeLines(readLines, null, outputStream, Config.ENCODING);
			} catch (FileNotFoundException e) {
				logger.info(e.getLocalizedMessage());
			} catch (IOException e) {
				logger.info(e.getLocalizedMessage());
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/upload/slide", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String uploadIndexSlide(SlidePhotoInfo info) {
		JSONObject json = new JSONObject();
		if(info.getDisplay() == SlidePhotoInfo.MENUS_TITLE) {
			slidePhotoService.delete(SlidePhotoInfo.newInstance(SlidePhotoInfo.MENUS_TITLE, info.getMenuId()));
			json.put("result", slidePhotoService.insert(info));
		}else if(info.getDisplay() == SlidePhotoInfo.INDEX_MENU) {
			SlidePhotoInfo selectedInfo = slidePhotoService.selectOne(info);
			if(selectedInfo != null) {
				selectedInfo.setPhotoId(info.getPhotoId());
				slidePhotoService.update(selectedInfo);
			}
		}else if(info.getDisplay() == SlidePhotoInfo.INDEX_MAIN) {
			json.put("result", slidePhotoService.insert(info));
		}
		
		
		
		return json.toString();
	}
}
