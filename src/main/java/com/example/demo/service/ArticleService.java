package com.example.demo.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.demo.dao.ArticleDao;
import com.example.demo.vo.Article;

@Service
public class ArticleService {

	private ArticleDao articleDao;

	public ArticleService(ArticleDao articleDao) {
		this.articleDao = articleDao;
	}

	public Article articleWrite(String title, String body) {
		return articleDao.articleWrite(title, body);
	}

	public List<Article> articleList() {
		return articleDao.articleList();
	}
	
	public Article getArticleById(int id) {
		return articleDao.getArticleById(id);
	}
	
	public void articleModify(int id, String title, String body) {
		articleDao.articleModify(id, title, body);
	}
	
	public void articleDelete(int id) {
		articleDao.articleDelete(id);
	}
	
}
