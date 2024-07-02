package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Reply;

@Mapper
public interface ReplyDao {

	@Insert("""
			INSERT INTO reply
				SET regDate = NOW()
					, updateDate = NOW()
					, memberNumber = #{loginMemberNumber}
					, relTypeCode = #{relTypeCode}
					, relId = #{relId}
					, `body` = #{body}
			""")
	public void writeReply(int loginMemberNumber, String relTypeCode, int relId, String body);
	
	@Select("""
			SELECT r.*, m.nickname `nickname`
				FROM reply r
				LEFT JOIN `member` m
					on r.memberNumber = m.id
				WHERE r.relTypeCode = #{relTypeCode}
					and r.relId = #{relId}
			""")
	public List<Reply> viewReply(String relTypeCode, int relId);

	@Select("SELECT LAST_INSERT_ID()")
	public int getLastInsertId();

	@Update("""
			UPDATE reply
				SET body = #{body}
				WHERE id = #{id}
			""")
	public void replyModify(int id, String body);
}