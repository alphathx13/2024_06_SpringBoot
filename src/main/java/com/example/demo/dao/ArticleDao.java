package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleDao {

	public Article articleWrite(String title, String body);
	
	@Select("""
			select * 
				from article 
				order by id desc
			""")
	public List<Article> articleList();
	
	@Select("""
			select * 
				from article 
				where id = #{id}
			""")
	public Article getArticleById(int id);
	
	@Update("""
			update article 
				set updateDate = NOW()
					, title = #{title}
					, body = #{body} 
					where id = #{id}
			""")
	public void articleModify(int id, String title, String body);
	
	@Delete("""
			delete from article 
				where id = #{id}
			""")
	public void articleDelete(int id);
}