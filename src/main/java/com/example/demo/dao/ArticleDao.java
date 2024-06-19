package com.example.demo.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.example.demo.vo.Article;

@Component
public class ArticleDao {
	private static int lastArticleId;
	private static List<Article> articles;
	
	public ArticleDao(ArticleDao articleDao) {
		lastArticleId = 1;
		articles = new ArrayList<>();
		
		makeTestData();
	}
	
	public void makeTestData() {
		for (int i = 1; i <= 10; i++) {
			String title = i + "번 게시글";
			String body = i + "번 게시글 내용";
			articles.add(new Article(lastArticleId++, title, body));
		}
	}
	
	public Article articleWrite(String title, String body) {
		Article article = new Article(lastArticleId++, title, body);
		articles.add(article);

		return article;
	}
	
	public List<Article> articleList() {
		return articles;
	}
	
	public Object articleDetail(int id) {
		Article foundArticle = getArticleById(id);

		if (foundArticle == null) 
			return id + "번 게시글은 존재하지 않습니다.";
		
		return foundArticle;
	}
	
	public String articleModify(int id, String title, String body) {
		Article foundArticle = getArticleById(id);
		
		if (foundArticle == null) 
			return id + "번 게시글은 존재하지 않습니다.";

		foundArticle.setTitle(title);
		foundArticle.setBody(body);
		return id + "번 게시글을 수정하였습니다.";
	}
	
	public String articleDelete(int id) {
		Article foundArticle = getArticleById(id);
		
		if (foundArticle == null) 
			return id + "번 게시글은 존재하지 않습니다.";

		articles.remove(foundArticle);
		return id + "번 게시글을 삭제하였습니다.";
	}
	
	public Article getArticleById(int id) {
		Article foundArticle = null;

		for (Article article : articles) {
			if (article.getId() == id) {
				foundArticle = article;
			}
		}
		
		return foundArticle;
	}
	
}
