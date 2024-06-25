package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Util;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

import jakarta.servlet.http.HttpSession;

@Controller
public class UsrMemberController {

	private MemberService memberService;

	public UsrMemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> join(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		if (Util.isEmpty(loginId))
			return ResultData.from("F-1", "아이디는 필수입력 정보입니다.");
		if (Util.isEmpty(loginPw)) 
			return ResultData.from("F-2", "비밀번호는 필수입력 정보입니다.");
		if (Util.isEmpty(name)) 
			return ResultData.from("F-3", "이름은 필수입력 정보입니다.");
		if (Util.isEmpty(nickname)) 
			return ResultData.from("F-4", "닉네임은 필수입력 정보입니다.");
		if (Util.isEmpty(cellphone)) 
			return ResultData.from("F-5", "핸드폰 번호는 필수입력 정보입니다.");
		if (Util.isEmpty(email)) 
			return ResultData.from("F-6", "이메일은 필수입력 정보입니다.");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) 
			return ResultData.from("F-7", String.format("입력하신 [ %s ] 아이디는 이미 사용중입니다.", loginId));
		
		memberService.memberJoin(loginId, loginPw, name, nickname, cellphone, email);

		int id = memberService.getLastInsertId();
		
		return ResultData.from("S-1", String.format("회원가입을 환영합니다."), memberService.getMemberById(id));
	}

	@GetMapping("/usr/member/doLogin")
	@ResponseBody
	public ResultData login(HttpSession session, String loginId, String loginPw) {
		
		if(session.getAttribute("loginMemberNumber") != null) 
			return ResultData.from("L-1", "로그아웃하고 사용해주세요.");
		
		if(Util.isEmpty(loginId))
			return ResultData.from("F-1", "제목을 입력해주세요.");
		
		if(Util.isEmpty(loginPw))
			return ResultData.from("F-2", "내용을 입력해주세요.");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null)
			return ResultData.from("F-3", String.format("%s 아이디는 존재하지 않습니다.", loginId));
		
		if (!member.getLoginPw().equals(loginPw))
			return ResultData.from("F-4", "비밀번호가 일치하지 않습니다.");
		
		session.setAttribute("loginMemberNumber", member.getId());
		session.setAttribute("loginMemberNn", member.getNickname());
		
		return ResultData.from("S-1", String.format("%s 님 환영합니다.", member.getNickname()));
	}
	
	@GetMapping("/usr/member/doLogout")
	@ResponseBody
	public ResultData logout(HttpSession session, String loginId, String loginPw) {
	
		if(session.getAttribute("loginMemberNumber") == null) 
			return ResultData.from("L-1", "로그인 후 사용해주세요.");
		
		session.removeAttribute("loginMemberNumber");
		session.removeAttribute("loginMemberNn");
		
		return ResultData.from("S-1", String.format("정상적으로 로그아웃되었습니다."));
	}

}