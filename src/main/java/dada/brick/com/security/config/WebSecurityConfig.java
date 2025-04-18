package dada.brick.com.security.config;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.BeanIds;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

import dada.brick.com.security.CustomAuthenticationFailureHandler;
import dada.brick.com.security.CustomAuthenticationSuccessHandler;
import dada.brick.com.security.CustomLogoutSuccessHandler;


/**
 * security 설정 클래스 
 * 
 * @author Lee
 *
 */
@ComponentScan("dada")
@Configuration
@EnableWebSecurity // 웹 보안설정
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
	private static final String[] IGNORED_RESOURCE_LIST = new String[] {"/resources/**", "/robots.txt", "/sitemap.xml"};
	@Autowired
	private CustomAuthenticationSuccessHandler loginSuccessHandler;
	
	@Autowired
	private CustomAuthenticationFailureHandler loginFailureHandler;
	
	@Autowired
	private CustomLogoutSuccessHandler logoutSuccessHandler;
	
	@Autowired
	private CustomAuthenticationProvider authProvider;

	/**
	 * security 를 지정하지 않을 경로
	 */
	@Override
	public void configure(WebSecurity web) throws Exception {
		web.ignoring().antMatchers(IGNORED_RESOURCE_LIST);
		
	}
	
	/**
	 * http 의 모든 요청에 인증절차를 받는것
	 * 로그인페이지를 별도로 설정 가능
	 * 로그인처리를 담당하는 경로와 실패를 처리하는 경로 정의 가능
	 * 로그아웃 후 쿠키 제거하는 기능도 들어가있음
	 * 
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
//		http.sessionManagement().invalidSessionUrl("/login")
//			.sessionFixation().migrateSession()
//			.maximumSessions(1);
		http
			.headers().contentTypeOptions().disable().and()
			.formLogin()
			.loginPage("/member/login")
			.loginProcessingUrl("/member/loginProcess")
			.usernameParameter("loginid")
			.passwordParameter("loginpwd")
			.successHandler(loginSuccessHandler)
			.failureHandler(loginFailureHandler)
			.permitAll()
			.and()
			.exceptionHandling().accessDeniedPage("/403")
			.and()
			.headers().frameOptions().disable()
			.and()
			.logout()
				.logoutUrl("/logout")
				.logoutSuccessHandler(logoutSuccessHandler)
				.invalidateHttpSession(true)
				.clearAuthentication(true)
				.deleteCookies("JSESSIONID")
			
			//.logoutSuccessUrl("/")
			.and()
			.authorizeRequests()
			.antMatchers("/admin/**").hasRole("ADMIN")
			.antMatchers("/member/login", "/**").permitAll()
			.anyRequest().authenticated()
			.and()
			.httpBasic()
			.and()
			.csrf().disable();
	}
	@Autowired
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception{
		auth.authenticationProvider(authProvider);
	}
	
	@Bean
	@Override
	public AuthenticationManager authenticationManagerBean() throws Exception {
		return super.authenticationManagerBean();
	}
}
