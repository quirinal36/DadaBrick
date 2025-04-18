package dada.brick.com.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;
import org.springframework.stereotype.Component;

@Component("customLogoutSuccessHandler")
public class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {
	private Logger logger = LoggerFactory.getLogger(this.getClass());

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	public CustomLogoutSuccessHandler() {
	}

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		
		String redirectUrl = request.getParameter("logoutRedirect");
		logger.debug("onLogoutSuccess:" + redirectUrl);
//		String refererUrl = (String) request.getSession().getAttribute("lastPageUrl");
	    if (redirectUrl == null || redirectUrl.isEmpty()) {
	        redirectUrl = "/";  // 기본 URL 설정
	    }
	    		
		redirectStrategy.sendRedirect(request, response, redirectUrl);
		
	}
}
