package com.example.demo.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.vo.Article;

@Service
public class ArticleService {
	
	private int lastArticleId;
	private List<Article> articles;

	private ArticleDao articleDao;

	public ArticleService(ArticleDao articleDao) {
		lastArticleId = 1;
		articles = new ArrayList<>();
		this.articleDao = articleDao;
		
		makeTestData();
	}
	
	public void makeTestData() {
		for (int i = 1; i <= 10; i++) {
			String title = i + "번 게시글";
			String body = i + "번 게시글 내용";
			articles.add(new Article(lastArticleId++, title, body));
		}
	}
	
	///////////////////////////////////
	
	public Article articleWrite(String title, String body) {
		return articleDao.articleWrite(lastArticleId, articles, title, body);
	}

	///////////////////////////////////
	
	public List<Article> articleList() {
		return articles;
	}
	
	public String articleDetail(int id) {
		return articleDao.articleDetail(id);
	}
	
	///////////////////////////////////
	
	public String articleModify(int id, String title, String body) {
		return articleDao.articleModify(id, title, body);
	}
	
	///////////////////////////////////
	
	public String articleDelete(int id) {
		return articleDao.articleDelete(id);
	}
	
	///////////////////////////////////
	
	private Article getArticleById(int id) {
		Article foundArticle = null;

		for (Article article : articles) {
			if (article.getId() == id) {
				foundArticle = article;
			}
		}
		
		return foundArticle;
	}
}
