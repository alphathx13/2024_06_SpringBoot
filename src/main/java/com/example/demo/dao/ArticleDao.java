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
			SELECT a.*, m.nickname `writerName`, IFNULL(SUM(l.point), 0) `likePoint`
				FROM article a
				INNER JOIN `member` m
					ON a.memberNumber = m.id
				LEFT OUTER JOIN likePoint l
					ON a.id = l.relId AND l.relTypeCode = 'article'
				WHERE a.boardId = #{boardId}
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
				GROUP BY a.id
				ORDER BY a.id desc
				LIMIT #{from}, #{itemsInPage};
			</script>
			""")
	public List<Article> articleList(int from, int itemsInPage, int boardId, int searchType, String searchText);
	
	@Select("""
			SELECT a.*, m.nickname `writerName`, IFNULL(SUM(l.point), 0) `likePoint`
				FROM article a
				INNER JOIN `member` m
					ON a.memberNumber = m.id
				LEFT OUTER JOIN likePoint l
					ON a.id = l.relId AND l.relTypeCode = 'article'
				WHERE a.id = #{id}
				GROUP BY a.id
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

	@Select("""
			SELECT count(*)
				FROM likePoint 
				WHERE memberNumber = #{loginMemberNumber} 
					and relId = #{id} 
					and relTypeCode = 'article';
			""")
	public int articleLikeCheck(int id, int loginMemberNumber);

	@Insert("""
			insert into likePoint
			set memberNumber = #{memberNumber}
				, relTypeCode = 'article'
				, relId = #{id}
			""")
	public void articleLike(int id, int memberNumber);

	@Delete("""
			DELETE FROM likePoint
			where memberNumber = #{memberNumber}
				and relTypeCode = 'article'
				and relId = #{id}
			""")
	public void articleUndoLike(int id, int memberNumber);

	@Select("""
			SELECT count(*)
				FROM likePoint 
				WHERE relId = #{id} 
					and relTypeCode = 'article';
			""")
	public int articleLikeCount(int id);
}