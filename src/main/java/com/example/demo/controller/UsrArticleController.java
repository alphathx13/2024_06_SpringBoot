package com.example.demo.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.vo.Article;
import com.example.demo.service.ArticleService;

@Controller
public class UsrArticleController {
	
	private ArticleService articleService;

	public UsrArticleController(ArticleService articleService) {
		this.articleService = articleService;
	}
	
	@GetMapping("/usr/article/doWrite")
	@ResponseBody
	public Article doWrite(String title, String body) {
		return articleService.articleWrite(title, body);
	}

	@GetMapping("/usr/article/showList")
	@ResponseBody
	public List<Article> showList() {
		return articleService.articleList();
	}

	@GetMapping("/usr/article/showDetail")
	@ResponseBody
	public Object showDetail(int id) {
		return articleService.articleDetail(id);
	}

	@GetMapping("/usr/article/doModify")
	@ResponseBody
	public String modify(int id, String title, String body) {
		return articleService.articleModify(id, title, body);
	}
		
	@GetMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {
		return articleService.articleDelete(id);
	}

}