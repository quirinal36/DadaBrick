package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/admin")
@Controller
public class AdminController {
	
	/**
	 * 관리자 첫화면
	 * @param mv
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView getAdminIndex(ModelAndView mv) {
		mv.addObject("title", "관리자페이지");
		//mv.setViewName("/admin/index");
		mv.setViewName("redirect:/admin/members/");
		return mv;
	}
	
	/**
	 * 팝업관리
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/popup")
	public ModelAndView getAdminPopup(ModelAndView mv) {
		mv.addObject("title", "팝업관리");
		mv.addObject("menu", 3);
		mv.setViewName("/admin/popup");
		return mv;
	}
	
	/**
	 * 사이드메뉴
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/sidebar")
	public ModelAndView getAdminSidebar(ModelAndView mv) {
		mv.setViewName("/admin/sidebar");
		return mv;
	}
}
