package com.example.demo.dao;

import java.util.List;

import com.example.demo.vo.Article;

public class ArticleDao {
	
	public static List<Article> articleWrite(int lastArticleId, List<Article> articles, String title, String body) {
		articles.add(new Article(lastArticleId++, title, body));

		return articles;
	}
	
	public static void articleList() {
	}
	
	public static String articleDetail(int id) {
		Article foundArticle = getArticleById(id);

		if (foundArticle == null) 
			return id + "번 게시글은 존재하지 않습니다.";
		
		return foundArticle;
		
		if (id != null) {
			return id.getId() + "  " + id.getTitle() + "  " + id.getBody();
		}
		
		return "해당 게시글은 존재하지 않습니다.";
	}
	
	public static String articleModify(int id, String title, String body) {
		Article foundArticle = getArticleById(id);
		
		if (foundArticle == null) 
			return id + "번 게시글은 존재하지 않습니다.";

		modifyArticle(foundArticle, title, body);
		
		return id + "번 게시글을 수정하였습니다.";
		if (id != null) {
			id.setTitle(title);
			id.setBody(body);
			return id.getId() + "번 게시글을 수정하였습니다.";
		}

		return "해당 게시글은 존재하지 않습니다.";
	}
	
	public static String articleDelete(Article article) {
		Article foundArticle = getArticleById(id);
		
		if (foundArticle == null) 
			return id + "번 게시글은 존재하지 않습니다.";

		articleDelete(foundArticle);
		return id + "번 게시글을 삭제하였습니다.";
		
		if (article != null) {
			article.setTitle(null);
			article.setBody(null);
			return article.getId() + "번 게시글을 삭제하였습니다.";
		}
		
		return "해당 게시글은 존재하지 않습니다.";
	}
	
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
