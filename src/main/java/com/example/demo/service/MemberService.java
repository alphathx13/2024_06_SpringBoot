package com.example.demo.service;

import org.springframework.stereotype.Service;

import com.example.demo.dao.MemberDao;
import com.example.demo.vo.Member;

@Service
public class MemberService {

	private MemberDao memberDao;

	public MemberService(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	public void memberJoin(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		memberDao.memberJoin(loginId, loginPw, name, nickname, cellphone, email);
	}
	
	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public Member getMemberById(int id) {
		return this.memberDao.getMemberById(id);
	}

	public int getLastInsertId() {
		return memberDao.getLastInsertId();
	}

	public void change(int memberNumber, String loginPw, String nickname, String cellphone, String email) {
		memberDao.change(memberNumber, loginPw, nickname, cellphone, email);
	}

	public Member idDupCheck(String loginId) {
		return memberDao.idDupCheck(loginId);
	}

}
