package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.vo.Member;

@Service
public class MemberService {

	private MemberDao memberDao;

	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}


	public String memberJoin(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		
		if (this.idDupCheck(loginId) == true) {
			return "입력하신 [" + loginId + "] 아이디는 이미 사용중입니다.";
		}
		
		memberDao.memberJoin(loginId, loginPw, name, nickname, cellphone, email);
		
		return loginId + "님의 회원가입을 환영합니다.";
	}
	
	public boolean idDupCheck(String loginId) {
		Member foundMember = memberDao.idDupCheck(loginId);
		
		if (foundMember != null) 
			return true;
		
		return false;
	}
	
	public Member getMemberById(int lastInsertId) {
		return memberDao.getMemberById(lastInsertId);
	}

	public List<Member> memberList() {
		return memberDao.memberList();
	}
	
	public int getLastInsertId() {
		return memberDao.getLastInsertId();
	}
}
