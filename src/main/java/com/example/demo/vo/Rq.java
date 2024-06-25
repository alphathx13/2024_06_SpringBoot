package com.example.demo.vo;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;

public class Rq {

	@Getter
	private int loginMemberNumber;

	public Rq(HttpServletRequest req) {
		HttpSession session = req.getSession();

		int loginMemberNumber = 0;

		if (session.getAttribute("loginedMemberId") != null) {
			loginMemberNumber = (int) session.getAttribute("loginedMemberId");
		}

	}
}