package com.example.demo.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class BeforeActionInterceptor implements HandlerInterceptor{
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		Rq rq = new Rq(request, response);

		request.setAttribute("rq", rq);
		
		return HandlerInterceptor.super.preHandle(request, response, handler);
		// true 라면 정상작동, false라면 controller로 넘어가지 못함
	}
}
