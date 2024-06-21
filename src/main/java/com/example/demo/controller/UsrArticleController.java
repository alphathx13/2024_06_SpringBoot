package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Article;
import com.example.demo.vo.ResultData;

import jakarta.servlet.http.HttpSession;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;

@Controller
public class UsrArticleController {

	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}
	
	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public ResultData<Article> doWrite(HttpSession session, String title, String body) {
		
		if(session.getAttribute("loginMemberNumber") == null)
			return ResultData.from("L-1", "로그인 후 사용해주세요.");
		
		if(Util.isEmpty(title))
			return ResultData.from("F-1", "제목을 입력해주세요.");
		
		if(Util.isEmpty(body))
			return ResultData.from("F-2", "내용을 입력해주세요.");
		
		articleService.articleWrite(title, body, (int) session.getAttribute("loginMemberNumber"));

		int id = articleService.getLastInsertId();
		
		return ResultData.from("S-1", String.format("%d번 게시글을 작성했습니다.", id), articleService.getArticleById(id));
	}

	@GetMapping("/usr/article/showList")
	@ResponseBody
	public ResultData<List<Article>> showList() {
		
		List<Article> articles = articleService.articleList();
		
		if (articles.size() == 0)
			return ResultData.from("F-1", "게시물이 존재하지 않습니다.");
		
		return ResultData.from("S-1", "게시물 목록", articles);
	}

	@GetMapping("/usr/article/showDetail")
	@ResponseBody
	public ResultData<Article> showDetail(int id) {
		Article foundArticle = articleService.forPrintArticle(id);
		
		if (foundArticle == null) {
			return ResultData.from("F-1", String.format("%d번 게시글은 존재하지 않습니다.", id));
		}
		
		return ResultData.from("S-1", "게시물 상세정보", foundArticle);
	}

	@GetMapping("/usr/article/doModify")
	@ResponseBody
	public ResultData modify(HttpSession session, int id, String title, String body) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if (foundArticle == null) {
			return ResultData.from("F-1", String.format("%d번 게시글은 존재하지 않습니다.", id));
		}

		if((int) session.getAttribute("loginMemberNumber") != foundArticle.getMemberNumber())
			return ResultData.from("F-A", "글 수정은 작성자만 할 수 있습니다.");
		
		articleService.articleModify(id, title, body);
		
		return ResultData.from("S-1", String.format("%d번 게시글을 수정하였습니다.", id));
	}
		
	@GetMapping("/usr/article/doDelete")
	@ResponseBody
	public ResultData doDelete(HttpSession session, int id) {
		
		Article foundArticle = articleService.getArticleById(id);
		
		if (foundArticle == null) {
			return ResultData.from("F-1", String.format("%d번 게시글은 존재하지 않습니다.", id));
		}
		
		if((int) session.getAttribute("loginMemberNumber") != foundArticle.getMemberNumber())
			return ResultData.from("F-A", "글 삭제는 작성자만 할 수 있습니다.");
		
		articleService.articleDelete(id);
		
		return ResultData.from("S-1", String.format("%d번 게시글을 삭제하였습니다.", id));
	}

}