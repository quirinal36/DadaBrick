package dada.brick.com.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/products")
public class ProductsController {
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public ModelAndView getListView(ModelAndView mv) {
		mv.setViewName("/products/list");
		return mv;
	}
	
	@RequestMapping(value="/detail", method = RequestMethod.GET)
	public ModelAndView getDetailView(ModelAndView mv) {
		mv.setViewName("/products/detail");
		return mv;
	}
	
	@RequestMapping(value="/add", method = RequestMethod.GET)
	public ModelAndView getAddView(ModelAndView mv) {
		mv.setViewName("/products/add");
		return mv;
	}
	
	@RequestMapping(value="/edit", method = RequestMethod.GET)
	public ModelAndView getEditView(ModelAndView mv) {
		mv.setViewName("/products/edit");
		return mv;
	}
}
