package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleDao {

	public Article articleWrite(String title, String body);
	
	public List<Article> articleList();
	
	public Object articleDetail(int id);
	
	public String articleModify(int id, String title, String body);
	
	public String articleDelete(int id);
}
