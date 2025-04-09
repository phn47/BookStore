package vn.fs.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

import vn.fs.service.UserDetailService;

/**
 * @author KnowSphere
 *
 */
@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {

	private final UserDetailService userDetailService;
	private final BCryptPasswordEncoder passwordEncoder;

	@Autowired
	public WebSecurityConfig(UserDetailService userDetailService) {
		this.userDetailService = userDetailService;
		this.passwordEncoder = new BCryptPasswordEncoder();
	}

	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
		return this.passwordEncoder;
	}

	@Bean
	public DaoAuthenticationProvider authenticationProvider() {
		DaoAuthenticationProvider auth = new DaoAuthenticationProvider();
		auth.setUserDetailsService(userDetailService);
		auth.setPasswordEncoder(passwordEncoder);
		return auth;
	}

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.authenticationProvider(authenticationProvider());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();

		// Admin page
		http.authorizeRequests()
				.antMatchers("/admin/**", "/admin/editProduct/**").hasRole("ADMIN")
				.antMatchers("/checkout").hasRole("USER")
				.antMatchers("/**").permitAll()
				.anyRequest().authenticated()
				.and()
				.formLogin()
				.loginProcessingUrl("/doLogin")
				.loginPage("/login")
				.defaultSuccessUrl("/?login_success")
				.successHandler(new SuccessHandler())
				.failureUrl("/login?error=true")
				.permitAll()
				.and()
				.logout()
				.invalidateHttpSession(true)
				.clearAuthentication(true)
				.logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
				.logoutSuccessUrl("/?logout_success")
				.permitAll()
				.and()
				.rememberMe()
				.rememberMeParameter("remember");
	}

}
