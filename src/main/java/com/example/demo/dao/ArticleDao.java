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
					, memberNumber = #{memberNumber}
					, boardId = #{boardId}; 
			""")
	public void articleWrite(String title, String body, int boardId, int memberNumber);
	
	@Select("""
			<script>
			select a.*, m.nickname `writerName`
				from article a
				Inner join `member` m
					on a.memberNumber = m.id
				where a.boardId = #{boardId}
					<if test="searchText != ''">
						<choose>
							<when test="searchType == 1">
								and title like CONCAT('%', #{searchText}, '%')
							</when>
							<when test="searchType == 2">
								and body like CONCAT('%', #{searchText}, '%')
							</when>
							<otherwise>
								and (title like CONCAT('%', #{searchText}, '%') or body like CONCAT('%', #{searchText}, '%'))
							</otherwise>
						</choose>
					</if>
				order by id desc
				LIMIT #{from}, #{itemsInPage};
			</script>
			""")
	public List<Article> articleList(int from, int itemsInPage, int boardId, int searchType, String searchText);
	
	@Select("""
			select a.*, m.nickname `writerName`
				from article a
				Inner join `member` m
				on a.memberNumber = m.id
				where a.id = #{id}
			""")
	public Article forPrintArticle(int id);
	
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

	@Select("SELECT last_insert_id()")
	public int getLastInsertId();

	@Select("""
			<script>
			SELECT count(id)
				FROM article
				WHERE boardId = #{boardId}
				<if test="searchText != ''">
					<choose>
						<when test="searchType == 1">
							and title like CONCAT('%', #{searchText}, '%')
						</when>
						<when test="searchType == 2">
							and body like CONCAT('%', #{searchText}, '%')
						</when>
						<otherwise>
							and (title like CONCAT('%', #{searchText}, '%') or body like CONCAT('%', #{searchText}, '%'))
						</otherwise>
					</choose>
				</if>
			</script>
			""")
	public int articleCount(int boardId, int searchType, String searchText);

	@Update("""
			update article
				set viewCount = viewCount+1
				where id = #{id};
			""")
	public void viewCountPlus(int id);
}