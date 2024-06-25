package com.example.demo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.vo.Rq;
import com.example.demo.util.Util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class NeedLogoutInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println(request.getRequestURL()); 
		
		Rq rq = (Rq) request.getAttribute("rq");
		
		if (rq.getLoginMemberNumber() == 0) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().append(Util.jsReplace("해당 기능은 로그인 후 이용해주세요.", "/"));
			return false;
		}
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
	}
}
