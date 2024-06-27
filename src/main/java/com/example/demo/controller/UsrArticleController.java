package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;
import com.example.demo.vo.Article;
import com.example.demo.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UsrArticleController {

	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}
	
	@GetMapping("/usr/article/write")
	public String write(Model model, int boardId) {
		model.addAttribute("boardId", boardId);
		return "/usr/article/write";
	}
	
	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(HttpSession session, String title, String body, int boardId) {
		
		articleService.articleWrite(title, body, boardId, (int) session.getAttribute("loginMemberNumber"));

		int id = articleService.getLastInsertId();
		
		return Util.jsReplace(String.format("%d번 게시글을 작성했습니다.", id), "/usr/article/detail?id="+id);
	}

	@GetMapping("/usr/article/list")
	public String list(Model model, int boardId, int cPage) {
		
		List<Article> articles = articleService.articleList(boardId);
		model.addAttribute("articles", articles);
		
		int articleCount = articleService.articleCount(boardId);
		model.addAttribute("articleCount", articleCount);
		
		String boardName = articleService.findBoard(boardId);
		model.addAttribute("boardName", boardName);
		
		return "usr/article/list";
	}

	@GetMapping("/usr/article/detail")
	public String showDetail(HttpServletRequest request, Model model, int id) {
		
		Rq rq = (Rq) request.getAttribute("rq");
		
		Article article = articleService.forPrintArticle(id);
		
		model.addAttribute("article", article);
		model.addAttribute("loginMemberNumber", rq.getLoginMemberNumber());
		
		return "usr/article/detail";
	}

	@GetMapping("/usr/article/modify")
	public String modify(Model model, int id) {
		
		Article article = articleService.forPrintArticle(id);
		
		model.addAttribute("article", article);
		return "usr/article/modify";
	}
	
	@PostMapping("/usr/article/doModify")
	@ResponseBody
	public String modify(int id, String title, String body) {
		
		articleService.articleModify(id, title, body);
		
		return Util.jsReplace(String.format("%d번 게시글을 수정하였습니다.", id), "/usr/article/detail?id="+id);
	}
		
	@GetMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		
		articleService.articleDelete(id);
		
		return Util.jsReplace(String.format("%d번 게시글을 삭제했습니다.", id), "list");
	}

}