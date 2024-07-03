package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ReplyDao;
import com.example.demo.vo.Reply;

@Service
public class ReplyService {

	private ReplyDao replyDao;

	public ReplyService(ReplyDao replyDao) {
		this.replyDao = replyDao;
	}

	public void writeReply(int loginMemberNumber, String relTypeCode, int relId, String body) {
		this.replyDao.writeReply(loginMemberNumber, relTypeCode, relId, body);
	}
	
	public List<Reply> viewReply(String relTypeCode, int relId) {
		return this.replyDao.viewReply(relTypeCode, relId);
	}

	public int getLastInsertId() {
		return this.replyDao.getLastInsertId();
	}

	public void replyModify(int id, String body) {
		replyDao.replyModify(id, body);
	}

	public void replyDelete(int id) {
		replyDao.replyDelete(id);
	}

	public Reply getReplyBody(int id) {
		return replyDao.getReplyBody(id);
	}
}