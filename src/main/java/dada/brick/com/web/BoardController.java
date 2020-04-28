package dada.brick.com.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/board")
@Controller
public class BoardController {
	
	@RequestMapping(value= {"/notice/", "/notice/{id}"}, method = RequestMethod.GET)
	public ModelAndView getNoticeView(ModelAndView mv) {
		mv.setViewName("/board/list");
		return mv;
	}
	
	@RequestMapping(value= {"/faq/", "/faq/{id}"}, method = RequestMethod.GET)
	public ModelAndView getFaqView(ModelAndView mv) {
		mv.setViewName("/board/list");
		return mv;
	}
	
	@RequestMapping(value= {"/data/", "/data/{id}"}, method = RequestMethod.GET)
	public ModelAndView getDataView(ModelAndView mv) {
		mv.setViewName("/board/list");
		return mv;
	}
}
