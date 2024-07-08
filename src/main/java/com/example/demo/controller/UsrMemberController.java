package com.example.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String join(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		memberService.memberJoin(loginId, loginPw, name, nickname, cellphone, email);

		return Util.jsReplace("정상적으로 회원가입 되었습니다.", "/usr/home/main");
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
	
	@PostMapping("/usr/member/passCheck")
	public String passCheck(Model model) {
		model.addAttribute("member", memberService.getMemberById(rq.getLoginMemberNumber()));
		return "usr/member/config";
	}

	@GetMapping("/usr/member/myPage")
	public String myPage(Model model) {
		model.addAttribute("member", memberService.getMemberById(rq.getLoginMemberNumber()));
		return "usr/member/myPage";
	}
	
	
	@PostMapping("/usr/member/memberModify")
	public String memberModify(Model model, String nickname, String loginPw, String cellphone, String email){
		
		memberService.change(rq.getLoginMemberNumber(), loginPw, nickname, cellphone, email);
		
		model.addAttribute("member", memberService.getMemberById(rq.getLoginMemberNumber()));
		return "usr/member/myPage";
	}

	@GetMapping("/usr/member/idDupCheck")
	@ResponseBody
	public ResultData<Boolean> idDupCheck(String loginId){
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) {
			return ResultData.from("F-1", String.format("입력하신 [%s] 아이디는 이미 사용중인 아이디입니다.", loginId), true);
		}
		
		return ResultData.from("S-1", String.format("입력하신 [%s] 아이디는 사용하실 수 있습니다.", loginId), false);
	}
	
}