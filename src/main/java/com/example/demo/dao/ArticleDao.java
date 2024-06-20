package com.example.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.example.demo.vo.Article;

@Mapper
public interface ArticleDao {

	@Insert("""
			insert into article
				set regDate = now()
					, updateDate = now()
					, title = #{title}
					, body = #{body}
			""")
	public void articleWrite(String title, String body);
	
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
			<script>
			update article 
				set updateDate = NOW()
					<if test = "title != null and title != ''">
					, title = #{title}
					</if>
					<if test = "body != null and body != ''">
					, body = #{body}
					</if>
					where id = #{id}
			</script>
			""")
	public void articleModify(int id, String title, String body);
	
	@Delete("""
			delete from article 
				where id = #{id}
			""")
	public void articleDelete(int id);

	@Select("SELECT last_insert_id()")
	public int getLastInsertId();
}