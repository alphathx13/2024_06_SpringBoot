package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ReplyService;
import com.example.demo.util.Util;
import com.example.demo.vo.Reply;
import com.example.demo.vo.ResultData;
import com.example.demo.vo.Rq;

@Controller
public class UsrReplyController {

	private ReplyService replyService;
	private Rq rq;

	public UsrReplyController(ReplyService replyService, Rq rq) {
		this.replyService = replyService;
		this.rq = rq;
	}

	@PostMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(String body, String relTypeCode, int relId) {

		replyService.writeReply(rq.getLoginMemberNumber(), relTypeCode, relId, body);

		return Util.jsReplace(String.format("댓글을 작성했습니다"), String.format("../article/detail?id=%d", relId));
	}
	
	@PostMapping("/usr/reply/viewReply")
	@ResponseBody
	public ResultData <List<Reply>> viewReply(String relTypeCode, int relId) {

		List<Reply> replyList = replyService.viewReply(relTypeCode, relId);
		
		return ResultData.from("S-1", relTypeCode, replyList);
	}
	
	@PostMapping("/usr/reply/replyModify")
	@ResponseBody
	public String replyModify(String body, int id, int articleId) {
		replyService.replyModify(id, body);
		
		return "1234";
	}
	
	@GetMapping("/usr/reply/replyDelete")
	@ResponseBody
	public String replyDelete(int id, int articleId) {
		replyService.replyDelete(id);
		
		return Util.jsReplace(String.format("댓글을 삭제했습니다"), String.format("../article/detail?id=%d", articleId));
	}
}