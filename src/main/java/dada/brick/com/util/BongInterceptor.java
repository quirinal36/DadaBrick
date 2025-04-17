package dada.brick.com.util;

import java.util.Iterator;
import java.util.Map;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class BongInterceptor implements HandlerInterceptor{
	Logger logger = Logger.getLogger(getClass().getSimpleName());
	@Autowired
	SqlSessionTemplate sqlSession;
	
	@Override
	public boolean preHandle(
				HttpServletRequest request, 
			HttpServletResponse response, Object handler)
			throws Exception {
		
//		if(request.isUserInRole("ROLE_USER") || request.isUserInRole("ROLE_ADMIN"))
//		{
//			logger.info("preHandle : isUserInRole_True");
//			return true;
//		} else {
//			logger.info("preHandle : isUserInRole_False");
//			response.sendRedirect(request.getContextPath() + "/login");
//			
//		}
		return true;
	}

	@Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, 
            Object handler, ModelAndView modelAndView) throws Exception {
        
        if (modelAndView != null) {
            String requestUri = request.getRequestURI();
            String queryString = request.getQueryString();
            
            // 현재 URL 생성
            String currentUrl = requestUri;
            if (queryString != null && !queryString.isEmpty()) {
                currentUrl += "?" + queryString;
            }
            
            if (!currentUrl.endsWith(".jsp")) {
            	//logger.info("interceptor currentUrl: "+currentUrl);
            	modelAndView.addObject("currentUrl", currentUrl);
//            	request.getSession().setAttribute("lastPageUrl", currentUrl);
            }            
        }
    }

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}

}
