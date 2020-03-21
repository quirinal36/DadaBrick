package dada.brick.com.web;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/community")
@Controller
public class CommunityController extends DadaController{
	
	@RequestMapping(value= "/")
	public ModelAndView getFreeBoardView(ModelAndView mv) {
		mv.setViewName("redirect:/group/free");
		return mv;
	}
	
}
