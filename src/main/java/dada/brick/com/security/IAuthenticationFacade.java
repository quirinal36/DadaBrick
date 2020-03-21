package dada.brick.com.security;

import org.springframework.security.core.Authentication;

public interface IAuthenticationFacade {
	Authentication getAuthentication();
}
