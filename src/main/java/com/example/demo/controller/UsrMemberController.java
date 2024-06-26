package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Util;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrMemberController {

	private MemberService memberService;
	private Rq rq;

	public UsrMemberController(MemberService memberService, Rq rq) {
		this.memberService = memberService;
		this.rq = rq;
	}
	
	@GetMapping("/usr/member/join")
	public String join() {
		return "/usr/member/join";
	}
	
	@PostMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> join(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
//		if (Util.isEmpty(loginId))
//			return ResultData.from("F-1", "아이디는 필수입력 정보입니다.");
//		if (Util.isEmpty(loginPw)) 
//			return ResultData.from("F-2", "비밀번호는 필수입력 정보입니다.");
//		if (Util.isEmpty(name)) 
//			return ResultData.from("F-3", "이름은 필수입력 정보입니다.");
//		if (Util.isEmpty(nickname)) 
//			return ResultData.from("F-4", "닉네임은 필수입력 정보입니다.");
//		if (Util.isEmpty(cellphone)) 
//			return ResultData.from("F-5", "핸드폰 번호는 필수입력 정보입니다.");
//		if (Util.isEmpty(email)) 
//			return ResultData.from("F-6", "이메일은 필수입력 정보입니다.");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) 
			return ResultData.from("F-7", String.format("입력하신 [ %s ] 아이디는 이미 사용중입니다.", loginId));
		
		memberService.memberJoin(loginId, loginPw, name, nickname, cellphone, email);

		int id = memberService.getLastInsertId();
		
		return ResultData.from("S-1", String.format("회원가입을 환영합니다."), memberService.getMemberById(id));
	}

	@GetMapping("/usr/member/login")
	public String login() {
		return "usr/member/login";
	}
	
	@PostMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String id, String pw) {
		
		Member member = memberService.getMemberByLoginId(id);
		
		if (member == null) { 
			return Util.jsBack(String.format("[ %s ] 계정은 존재하지 않습니다.", id));
		}
		
		if (!member.getLoginPw().equals(pw)) { 
			return Util.jsBack(String.format("비밀번호가 일치하지 않습니다."));
		}

		rq.login(member);
		
		return Util.jsReplace(String.format("%s 님의 로그인을 환영합니다.", member.getNickname()), "/");
	}
	
	@GetMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(String loginId, String loginPw) {
	
		rq.logout();
		
		return Util.jsReplace("정상적으로 로그아웃 되었습니다.", "/");
	}
	
	@GetMapping("/usr/member/config")
	public String config() {
		return "usr/member/config";
	}

}