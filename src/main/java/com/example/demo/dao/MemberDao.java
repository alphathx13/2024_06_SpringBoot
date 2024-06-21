package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.vo.Member;

@Mapper
public interface MemberDao {

	@Insert("""
			INSERT INTO `member`
			 	SET regDate = NOW()
			     	, updateDate = NOW()
			     	, loginId = #{loginId}
			     	, loginPw = #{loginPw}
			     	, `name` = #{name}
			     	, nickname = #{nickname}
			     	, cellphone = #{cellphone}
			     	, email = #{email};
			""")
	public void memberJoin(String loginId, String loginPw, String name, String nickname, String cellphone, String email);

	@Select("""
			select * 
				from `member`
				order by id desc
			""")
	public List<Member> memberList();

	@Select("""
			SELECT *
				FROM `member`
				WHERE id = #{id}
			""")
	public Member getMemberById(int id);
	
	@Select("""
			select * 
				from `member` 
				where id = #{id}
			""")
	public Member getMemberByLoginId(String loginId);

	@Select("SELECT last_insert_id()")
	public int getLastInsertId();

}