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

	public void articleWrite(String title, String body, int boardId, int memberNumber) {
		articleDao.articleWrite(title, body, boardId, memberNumber);
	}

	public List<Article> articleList(int from, int itemsInPage, int boardId, int searchType, String searchText) {
		return articleDao.articleList(from, itemsInPage, boardId, searchType, searchText);
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

	public int getLastInsertId() {
		return articleDao.getLastInsertId();
	}

	public Article forPrintArticle(int id) {
		return articleDao.forPrintArticle(id);
	}

	public int articleCount(int boardId, int searchType, String searchText) {
		return articleDao.articleCount(boardId, searchType, searchText);
	}

	public void viewCountPlus(int id) {
		articleDao.viewCountPlus(id);
	}

	public int articleLikeCheck(int loginMemberNumber, int id) {
		return articleDao.articleLikeCheck(id, loginMemberNumber);
	}

	public void articleLike(int id, int memberNumber) {
		articleDao.articleLike(id, memberNumber);
	}

	public void articleUndoLike(int id, int memberNumber) {
		articleDao.articleUndoLike(id, memberNumber);
	}
	
}
