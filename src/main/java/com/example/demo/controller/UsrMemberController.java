package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.MemberService;
import com.example.demo.util.Util;
import com.example.demo.vo.Member;
import com.example.demo.vo.ResultData;

@Controller
public class UsrMemberController {

	private MemberService memberService;

	public UsrMemberController(MemberService memberService) {
		this.memberService = memberService;
	}
	
	@GetMapping("/usr/member/doJoin")
	@ResponseBody
	public ResultData doJoin(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		if (Util.isEmpty(loginId)) {
			return ResultData.from("F-1", "아이디는 필수입력 정보입니다.");
		} else if (Util.isEmpty(loginPw)) {
			return ResultData.from("F-2", "비밀번호는 필수입력 정보입니다.");
		} else if (Util.isEmpty(name)) {
			return ResultData.from("F-3", "이름은 필수입력 정보입니다.");
		} else if (Util.isEmpty(nickname)) {
			return ResultData.from("F-4", "닉네임은 필수입력 정보입니다.");
		} else if (Util.isEmpty(cellphone)) {
			return ResultData.from("F-5", "핸드폰 번호는 필수입력 정보입니다.");
		} else if (Util.isEmpty(email)) {
			return ResultData.from("F-6", "이메일은 필수입력 정보입니다.");
		}
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member != null) {
			return ResultData.from("F-7", String.format("입력하신 [ %s ] 아이디는 이미 사용중입니다.", loginId));
		}
		
		memberService.memberJoin(loginId, loginPw, name, nickname, cellphone, email);

		int id = memberService.getLastInsertId();
		
		return ResultData.from("S-1", String.format("회원가입을 환영합니다."), memberService.getMemberById(id));
	}

//	@GetMapping("/usr/member/memberList")
//	@ResponseBody
//	public List<Member> showList() {
//		return memberService.memberList();
//	}

}

//@Component
//class Test1 {
//	
//	@Autowired
//	private Test2 test2;
//	
//	public void test1() {
//		test2.test2();
//	}
//}
//
//@Component
//class Test2 {
//	
//	@Autowired
//	private Test1 test1;
//	
//	public void test2() {
//		test1.test1();
//	}
//}
//
//@Component
//class BeanA {
//	private BeanB beanB;
//
//	public BeanA(BeanB beanB){
//		this.beanB = beanB;
//	}
//}
//
//@Component
//class BeanB {
//	private BeanA beanA;
//
//	public BeanB(BeanA beanA){
//		this.beanA = beanA;
//	}
//}