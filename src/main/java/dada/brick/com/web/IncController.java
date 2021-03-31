package dada.brick.com.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dada.brick.com.Config;
import dada.brick.com.service.MenuService;
import dada.brick.com.vo.Menus;

@RequestMapping("/inc")
@Controller
public class IncController extends DadaController{
	
	@RequestMapping(value = "/header", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeaderView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		// 상단에 표시될 메뉴들
		Menus parent = new Menus();
		parent.setParentId(0);
		List<Menus> parents = menuService.select(parent);
		
		// 자식메뉴들
		Map<Integer, List<Menus>> map = new HashMap<Integer, List<Menus>>();
		List<Menus> children = menuService.select(parents);
		Iterator<Menus> iter = children.iterator();
		while(iter.hasNext()) {
			Menus menu = iter.next();
			if(!map.containsKey(menu.getParentId())) {
				map.put(menu.getParentId(), new ArrayList<Menus>());
			}
			map.get(menu.getParentId()).add(menu);
		}
		
		for(Menus menu : parents) {
			menu.setChildren(map.get(menu.getId()));
		}
		mv.addObject("parents", parents);
		mv.addObject("locale", locale);
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
			HttpServletRequest req, Authentication authentication) throws IOException {
		File file = ResourceUtils.getFile("classpath:kakao.env");
		String apiKey = FileUtils.readFileToString(file, Config.ENCODING);
		mv.addObject("apiKey", apiKey);
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
	@RequestMapping(value="/contentsTitle")
	public ModelAndView getContentsTitleView(ModelAndView mv) {
		
		return mv;
	}
}
