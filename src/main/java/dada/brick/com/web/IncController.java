package dada.brick.com.web;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dada.brick.com.vo.Menus;

@RequestMapping("/inc")
@Controller
public class IncController extends DadaController{
	
	@RequestMapping(value = "/header", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeaderView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		
		mv.setViewName("/inc/header");
		return mv;
	}
	@RequestMapping(value = "/header_admin", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeaderAdminView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/header_admin");
		return mv;
	}
	@RequestMapping(value = "/footer", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getFooterView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/footer");
		return mv;
	}
	@RequestMapping(value = "/head", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeadView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/head");
		return mv;
	}
	@RequestMapping(value = "/lnb_wrap", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getLnbWrapView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication,
			Menus menus) {
		
		mv.addObject("locale", locale);
		mv.setViewName("/inc/lnb_wrap");
		return mv;
	}
	
	@RequestMapping(value="/term")
	public ModelAndView getTermView(ModelAndView mv) {
		
		return mv;
	}

	@RequestMapping(value="/privacy")
	public ModelAndView getPrivacyView(ModelAndView mv) {
		
		return mv;
	}
}
