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
	
	public Object articleDetail(int id) {
		return articleDao.articleDetail(id);
	}
	
	public String articleModify(int id, String title, String body) {
		return articleDao.articleModify(id, title, body);
	}
	
	public String articleDelete(int id) {
		return articleDao.articleDelete(id);
	}
	
}
