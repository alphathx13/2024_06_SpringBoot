package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.service.ArticleService;
import com.example.demo.util.Util;
import com.example.demo.vo.Article;
import com.example.demo.vo.Rq;

@Controller
public class UsrArticleController {

	private ArticleService articleService;
	private Rq rq;

	public UsrArticleController(ArticleService articleService, Rq rq) {
		this.articleService = articleService;
		this.rq = rq;
	}
	
	@GetMapping("/usr/article/write")
	public String write(Model model, int boardId) {
		model.addAttribute("boardId", boardId);
		return "/usr/article/write";
	}
	
	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body) {
		
		articleService.articleWrite(title, body, boardId, rq.getLoginMemberNumber());

		int id = articleService.getLastInsertId();
		
		return Util.jsReplace(String.format("%d번 게시글을 작성했습니다.", id), "/usr/article/detail?id="+id);
	}

	@GetMapping("/usr/article/list")
	public String list(Model model, int boardId, @RequestParam(defaultValue = "0") int searchType, @RequestParam(defaultValue = "") String searchText, @RequestParam(defaultValue = "10") int itemsInPage, @RequestParam(defaultValue = "1") int cPage) {
		
		searchText = searchText.trim();
		
		int from = ((cPage - 1) * itemsInPage);
		
		int articleCount = articleService.articleCount(boardId, searchType, searchText);
		
		int tPage = articleCount % itemsInPage == 0 ? articleCount / itemsInPage : articleCount / itemsInPage + 1;
//		tPage = (int) Math.ceil((double) tArticle / 10);	
		
		List<Article> articles = articleService.articleList(from, itemsInPage, boardId, searchType, searchText);
		
		String boardName = articleService.findBoard(boardId);

		model.addAttribute("articleCount", articleCount);
		model.addAttribute("articles", articles);
		model.addAttribute("boardName", boardName);
		model.addAttribute("cPage", cPage);
		model.addAttribute("tPage", tPage);
		model.addAttribute("from", from);
		model.addAttribute("itemsInPage", itemsInPage);
		model.addAttribute("searchText", searchText);
		model.addAttribute("searchType", searchType);

		return "usr/article/list";
	}

	@GetMapping("/usr/article/detail")
	public String showDetail(Model model, int id) {
		
		Article article = articleService.forPrintArticle(id);
		
		model.addAttribute("article", article);
		
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
	public String doDelete(int id, int boardId) {
		
		articleService.articleDelete(id);
		
		return Util.jsReplace(String.format("%d번 게시글을 삭제했습니다.", id), String.format("/usr/article/list?boardId=%d", boardId));
	}

}