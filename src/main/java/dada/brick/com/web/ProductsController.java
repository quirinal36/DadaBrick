package dada.brick.com.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dada.brick.com.service.ProductsService;
import dada.brick.com.service.SlidePhotoService;
import dada.brick.com.vo.Menus;
import dada.brick.com.vo.ProductsVO;
import dada.brick.com.vo.SlidePhotoInfo;

@Controller
@RequestMapping("/products")
public class ProductsController extends DadaController{
	@Autowired
	ProductsService productsService;
	
	@Autowired
	SlidePhotoService slidePhotoService;
	
	@RequestMapping(value= {"/", "/list", "/list/{id}", "/list/{id}/{page}"},method = RequestMethod.GET)
	public ModelAndView getListView(ModelAndView mv,
			HttpServletRequest request,
			@PathVariable(value="id")Optional<Integer>menuId,
			@PathVariable(value="page")Optional<Integer>pageNum,
			ProductsVO product,
			@RequestHeader(value="referer", required=false)String referer) {
		// 헤더부분 메뉴명
		Menus current = new Menus();
		if(menuId.isPresent()) {
			current.setId(menuId.get());
		}else {
			current.setId(10);
		}
		current = menuService.selectOne(current);
		mv.addObject("current", current);
		
		// 중간 탭메뉴
		List<Menus> children = getChildrenMenus(current.getId() / 10);
		mv.addObject("tabs", children);
		
		// 현재 메뉴의 검색결과
		product.setMenuId(current.getId());
		product.setTotalCount(productsService.count(product));
		if(pageNum.isPresent()) {
			product.setPageNo(pageNum.get());
		}else {
			product.setPageNo(1);
		}
		
		SlidePhotoInfo photoTitle = slidePhotoService.selectOne(SlidePhotoInfo.newInstance(SlidePhotoInfo.MENUS_TITLE, product.getMenuId()));
		if(photoTitle != null) {
			logger.info(photoTitle.toString());
			product.setSlideInfo(photoTitle);
		}
		List<ProductsVO> products = productsService.select(product);
		mv.addObject("products", products);
		
		// 현재 URL
		mv.addObject("listUrl", request.getRequestURL().toString());
		
		// paging
		mv.addObject("paging", product);
		
		mv.setViewName("/products/list");
		return mv;
	}
	private List<Menus> getChildrenMenus(int parentId){
		List<Menus> parent = new ArrayList<Menus>();
		parent.add(Menus.newInstance(parentId));
		return menuService.select(parent);
	}
	@RequestMapping(value= {"/detail","/detail/{id}"}, method = RequestMethod.GET)
	public ModelAndView getDetailView(ModelAndView mv,
			@PathVariable(value="id")Optional<Integer>productId,
			ProductsVO product) {
		if(productId.isPresent()) {
			product.setId(productId.get());
		}
		
		mv.addObject("product", productsService.selectOne(product));
		mv.setViewName("/products/detail");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/add", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String postProduct(ModelAndView mv, ProductsVO product,
			HttpServletRequest request) {
		JSONObject json = new JSONObject();
		int result = productsService.insert(product);
		json.put("result", result);
		json.put("category", product.getMenuId());
		return json.toString();
	}
	
	@RequestMapping(value="/add", method = RequestMethod.GET)
	public ModelAndView getAddView(ModelAndView mv,
			HttpServletRequest request, RedirectAttributes redirectAttr) {
		if(request.isUserInRole("ADMIN")) {
			// 상단에 표시될 메뉴들
			Menus parent = new Menus();
			parent.setParentId(0);
			List<Menus> parents = menuService.select(parent);
			
			// 자식메뉴들
			List<Menus> children = menuService.select(parents);
			Map<Integer, Menus> map = children.stream().collect(Collectors.toMap(Menus::getMenuNum, menus->menus, (p1,p2)->p1));
			TreeMap<Integer, Menus> sortedMap = new TreeMap<Integer, Menus>(map);
			Iterator<Integer> iterKey = sortedMap.keySet().iterator();
			
			mv.addObject("category", sortedMap);
			mv.setViewName("/products/add");
		}else {
			redirectAttr.addAttribute("loginRedirect", "/products/add");
			mv.setViewName("redirect:/member/login");
			// redirect to login
		}
		return mv;
	}
	
	@RequestMapping(value="/edit", method = RequestMethod.GET)
	public ModelAndView getEditView(ModelAndView mv) {
		mv.setViewName("/products/edit");
		return mv;
	}
}
