package dada.brick.com.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dada.brick.com.service.ProductsService;
import dada.brick.com.service.SlidePhotoService;
import dada.brick.com.vo.Menus;
import dada.brick.com.vo.PhotoInfo;
import dada.brick.com.vo.ProductsVO;
import dada.brick.com.vo.SlidePhotoInfo;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/products")
public class ProductsController extends DadaController{
	@Autowired
	ProductsService productsService;
	
	@Autowired
	SlidePhotoService slidePhotoService;
	
	@ResponseBody
	@RequestMapping(value="/get/{menuId}/{page}", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public JSONObject getProductsList(@PathVariable(value="menuId")Optional<Integer>menuId,
			@PathVariable(value="page")Optional<Integer>pageNum,
			ProductsVO product) {
		JSONObject json = new JSONObject();
		JSONArray jsonArr = new JSONArray();
		
		Menus current = new Menus();
		if(menuId.isPresent()) {
			current.setId(menuId.get());
		}else {
			current.setId(10);
		}
		current = menuService.selectOne(current);
		
		// 현재 메뉴의 검색결과
		product.setMenuId(current.getId());
		product.setTotalCount(productsService.count(product));
		if(pageNum.isPresent()) {
			product.setPageNo(pageNum.get());
		}else {
			product.setPageNo(1);
		}
		List<ProductsVO> products = productsService.select(product);
		for(ProductsVO item: products) {
			jsonArr.put(new JSONObject(item.toString()));
		}
		json.put("list", jsonArr);
		
		return json;
	}
	
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
		if(pageNum.isPresent()) {
			product.setPageNo(pageNum.get());
		}else {
			product.setPageNo(1);
		}
		product.setTotalCount(productsService.count(product));
		
		SlidePhotoInfo photoTitle = slidePhotoService.selectOne(SlidePhotoInfo.newInstance(SlidePhotoInfo.MENUS_TITLE, product.getMenuId()));
		if(photoTitle != null) {
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
		PhotoInfo photoInfo = PhotoInfo.newInstance(productId.get(), 0);
		List<PhotoInfo> detailPhotoList = photoInfoService.select(photoInfo);
		
		mv.addObject("product", productsService.selectOne(product));
		mv.addObject("detailPhotoList", detailPhotoList);
		
		mv.setViewName("/products/detail");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/edit", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String postEditProduct(ProductsVO product, 
			@RequestParam(value="detImage", required = false)Optional<int[]> detImages,
			HttpServletRequest request, RedirectAttributes redirectAttr) {
		JSONObject json = new JSONObject();
		if(request.isUserInRole("ADMIN")) {
			// 1. detImages 적어졌는지 검사해서 빼거나 추가하기
			List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(product.getId(), 0));
			
			Map<Integer, PhotoInfo> photoInfoMap = photoList.stream().collect(Collectors.toMap(PhotoInfo::getId, photoInfo->photoInfo));
			
			List<PhotoInfo> appendPhotos = new ArrayList<>();
			
			// photoInfoMap 에는 없지만, detImages에는 있다면 추가해야한다.
			if(detImages.isPresent()) {
				for(Integer detImg : detImages.get()) {
					if(!photoInfoMap.containsKey(detImg)) {
						appendPhotos.add(PhotoInfo.newInstance(product.getId(), detImg));
					}
				}
				if(appendPhotos.size() > 0) {
					photoInfoService.updateProducts(appendPhotos);
				}
			}
			json.put("category", product.getMenuId());
			json.put("result", productsService.update(product));
			json.put("productId", product.getId());
		}else {
			json.put("result", -1);
		}
		// 2. product 객체 update 하기
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/add", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String postProduct(ModelAndView mv, ProductsVO product,
			HttpServletRequest request, @RequestParam(value="detImage", required=false)Optional<int[]> detImages) {
		JSONObject json = new JSONObject();
		int result = productsService.insert(product);
		
		if(detImages.isPresent()) {
			if(detImages.get().length > 0) {
				List<PhotoInfo> photoInfoList = new ArrayList<>();
				for(int detImg : detImages.get()) {
					photoInfoList.add(PhotoInfo.newInstance(product.getId(), detImg));
				}
				photoInfoService.updateProducts(photoInfoList);
			}
		}
		json.put("result", result);
		json.put("category", product.getMenuId());
		json.put("productId", product.getId());
		return json.toString();
	}
	
	@RequestMapping(value= {"/add","/add/{menuId}"}, method = RequestMethod.GET)
	public ModelAndView getAddView(ModelAndView mv,
			@PathVariable(value="menuId")Optional<Integer>menuId,
			HttpServletRequest request, RedirectAttributes redirectAttr) {
		if(request.isUserInRole("ADMIN")) {
			// 상단에 표시될 메뉴들
			Menus parent = new Menus();
			parent.setParentId(0);
			List<Menus> parents = menuService.select(parent);
			
			// 자식메뉴들
			List<Menus> children = menuService.select(parents);
			Map<Integer, Menus> map = children.stream().collect(Collectors.toMap(Menus::getMenuNum, menus->menus, (p1,p2)->p2));
			TreeMap<Integer, Menus> sortedMap = new TreeMap<Integer, Menus>(map);
			/*
			Iterator<Integer> iterKey = sortedMap.keySet().iterator();
			while(iterKey.hasNext()) {
				Menus menu = sortedMap.get(iterKey.next());
				logger.info(menu.toString());
			}
			*/
			if(menuId.isPresent()) {
				mv.addObject("currentMenuId", menuId.get());
			}
			mv.addObject("category", sortedMap);
			mv.setViewName("/products/add");
		}else {
			redirectAttr.addAttribute("loginRedirect", "/products/add");
			mv.setViewName("redirect:/member/login");
			// redirect to login
		}
		return mv;
	}
	
	@RequestMapping(value="/edit/{id}", method = RequestMethod.GET)
	public ModelAndView getEditView(ModelAndView mv, HttpServletRequest request,
			@PathVariable(value="id", required=true)Optional<Integer> productId, RedirectAttributes redirectAttr) {
		
		if(productId.isPresent()) {
			if(request.isUserInRole("ADMIN")) {
				// 상단에 표시될 메뉴들
				Menus parent = new Menus();
				parent.setParentId(0);
				List<Menus> parents = menuService.select(parent);
				
				// 자식메뉴들
				List<Menus> children = menuService.select(parents);
				Map<Integer, Menus> map = children.stream().collect(Collectors.toMap(Menus::getMenuNum, menus->menus, (p1,p2)->p2));
				TreeMap<Integer, Menus> sortedMap = new TreeMap<Integer, Menus>(map);
				Iterator<Integer> iterKey = sortedMap.keySet().iterator();
				
				mv.addObject("category", sortedMap);
				ProductsVO product = productsService.selectOne(ProductsVO.newInstance(productId.get()));
				mv.addObject("product", product);
				mv.addObject("currentMenuId", product.getMenuId());
				
				PhotoInfo photoInfo = PhotoInfo.newInstance(productId.get(), 0);
				List<PhotoInfo> detailPhotoList = photoInfoService.select(photoInfo);
				mv.addObject("detailPhotoList", detailPhotoList);
				mv.setViewName("/products/add");
			}else {
				redirectAttr.addAttribute("loginRedirect", "/products/add");
				mv.setViewName("redirect:/member/login");
			}
		}
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/move/{dest}", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String moveOrder(ProductsVO product,
			@PathVariable(value="dest", required = true)String dest) {
		JSONObject json = new JSONObject();
		
		if(dest.equals("prev")) {
			ProductsVO prevProduct = productsService.selectPrev(product);
			if(prevProduct != null) {
				int temp = product.getOrderNum();
				product.setOrderNum(prevProduct.getOrderNum());
				prevProduct.setOrderNum(temp);
				List<ProductsVO> editList = new ArrayList<ProductsVO>();
				editList.add(product);
				editList.add(prevProduct);
				json.put("result", productsService.update(editList));
			}
		}else if(dest.equals("next")) {
			ProductsVO nextProduct = productsService.selectNext(product);
			if(nextProduct != null) {
				int temp = product.getOrderNum();
				product.setOrderNum(nextProduct.getOrderNum());
				nextProduct.setOrderNum(temp);
				List<ProductsVO> editList = new ArrayList<ProductsVO>();
				editList.add(product);
				editList.add(nextProduct);
				json.put("result", productsService.update(editList));
			}
		}
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String deleteProduct(ProductsVO product) {
		product = productsService.selectOne(product);
		
		JSONObject json = new JSONObject();
		product.setOrderNum(ProductsVO.STATUS_CLOSE);
		
		int deleteResult = productsService.update(product);
		json.put("result", deleteResult);
		
		if(!(deleteResult > 0)) {
			json.put("msg", "삭제가 되지 않습니다.");
		}else {
			json.put("dest", "/products/list/"+product.getMenuId());
		}
		return json.toString();
	}
	
	public String initOrderNum() {
		JSONObject json = new JSONObject();
		List<PhotoInfo> products = photoInfoService.selectProducts();
		for(int j=0; j<products.size(); j++) {
			PhotoInfo photoInfo = products.get(j);
			List<PhotoInfo> detailPhotoList = photoInfoService.select(photoInfo);
			for(int i=0; i<detailPhotoList.size(); i++) {
				PhotoInfo item = detailPhotoList.get(i);
				item.setOrderNum(i+1);
			}
			photoInfoService.updateOrder(detailPhotoList);
		}
		return json.toString();
	}

	@ResponseBody
	@RequestMapping(value="/edit/sort", method=RequestMethod.POST, produces = "application/json; charset=utf8")
	public String detatilImageSort(@RequestParam(value="ids", required = true)String ids) {
		JSONObject json = new JSONObject();
		String [] idArr = ids.split(";");
		List<PhotoInfo> orderList = new ArrayList<>();
		int odr = 1;
		for(String id : idArr) {
			try {
				PhotoInfo photo = new PhotoInfo();
				photo.setId(Integer.parseInt(id));
				photo.setOrderNum(odr++);
				orderList.add(photo);
			}catch(NullPointerException e) {
				logger.info(e.getMessage());
			}
		}
		int result = photoInfoService.updateOrder(orderList);
		json.put("result", result);
		
		return json.toString();
	}
	
}
