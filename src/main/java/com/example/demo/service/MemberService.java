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


	public void memberJoin(String loginId, String loginPw, String name, String nickname, String cellphone, String email) {
		memberDao.memberJoin(loginId, loginPw, name, nickname, cellphone, email);
	}
	
	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public List<Member> memberList() {
		return memberDao.memberList();
	}
	
	public Object getMemberById(int id) {
		return this.memberDao.getMemberById(id);
	}

	public int getLastInsertId() {
		return memberDao.getLastInsertId();
	}
}
