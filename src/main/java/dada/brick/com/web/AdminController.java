package dada.brick.com.web;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dada.brick.com.service.ProductsService;
import dada.brick.com.vo.Menus;
import dada.brick.com.vo.ProductsVO;

@Controller
@RequestMapping("/admin")
public class AdminController extends DadaController{
	@Autowired
	ProductsService productsService;
	
	
}
