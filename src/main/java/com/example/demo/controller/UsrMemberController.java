package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Util;
import com.example.demo.vo.Member;

@Controller
public class UsrMemberController {

	private MemberService memberService;

	public UsrMemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		if (Util.isEmpty(loginId)) {
			return "아이디는 필수입력 정보입니다.";
		} else if (Util.isEmpty(loginPw)) {
			return "비밀번호는 필수입력 정보입니다.";
		} else if (Util.isEmpty(name)) {
			return "이름은 필수입력 정보입니다.";
		} else if (Util.isEmpty(nickname)) {
			return "닉네임은 필수입력 정보입니다.";
		} else if (Util.isEmpty(cellphone)) {
			return "핸드폰 번호는 필수입력 정보입니다.";
		} else if (Util.isEmpty(email)) {
			return "이메일은 필수입력 정보입니다.";
		}
		
		return memberService.memberJoin(loginId, loginPw, name, nickname, cellphone, email);
	}

	@GetMapping("/usr/member/memberList")
	@ResponseBody
	public List<Member> showList() {
		return memberService.memberList();
	}

}