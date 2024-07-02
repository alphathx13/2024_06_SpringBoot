<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시글 보기" />

<%@ include file="../../common/head.jsp"%>

<section class="mt-8 text-lg text-center">
	<div class="container flex flex-col mx-auto px-3 w-3/5">
	
		<div class="flex justify-center">
			<table class="w-full table table-xl table-pin-rows table-pin-cols text-xl">
				<colgroup>
					<col width=150/>
					<col width=150/>
					<col/>
					<col width=200/>
				</colgroup>
				<tr>
					<td colspan="4" class="text-center">${article.title }</td>
				</tr>
				<tr>
					<td class="">${article.writerName }</td>
					<td class=""><i class="fa-solid fa-eye"></i> ${article.viewCount }</td>
					<td class="grow"></td>
					<td> 
						<c:choose>
							<c:when test="${article.regDate == article.updateDate }">
								${article.regDate.substring(2, 16) } 
							</c:when>
							<c:otherwise>
								작성일자 : ${article.regDate.substring(2, 16) } / 수정일자 : ${article.updateDate.substring(2, 16) }
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				<tr class="h-40">
					<td colspan="4" class="">${article.body }</td>
				</tr>
			</table>
		</div>
		
		<div class="h-16">
			<c:choose>
				<c:when test="${rq.loginMemberNumber != 0 }">
					<div class="undoLike tooltip w-16 h-full ${articleLikeCheck == 1? 'inline-block' : 'hidden' }" data-tip="추천취소">
						<button class="btn btn-outline btn-info w-full h-full text-xl" type="button">
							<i class="fa-solid fa-star"><div class="likePoint text-xl">${article.likePoint }</div></i>
						</button>
					</div>
					<div class="doLike tooltip w-16 h-full ${articleLikeCheck == 0? 'inline-block' : 'hidden' }" data-tip="추천하기">
						<button class="btn btn-outline btn-info w-full h-full text-xl" type="button">
							<i class="fa-regular fa-star"><div class="likePoint text-xl">${article.likePoint }</div></i>
						</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="h-16 tooltip w-16 h-full" data-tip="추천수">
						<button class="btn btn-outline btn-info w-full h-full flex justify-center">
							<i class="fa-solid fa-star"></i>${article.likePoint }
						</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div class="text-4xl mt-4">
			<div class="tooltip" data-tip="뒤로 가기">
				<button class="btn btn-outline btn-info" onclick="history.back();">			
					<i class="fa-solid fa-arrow-left-long"></i>
				</button>
			</div>
			<c:if test="${loginMemberNumber == article.memberNumber }">
				<div class="tooltip" data-tip="글 수정">
				<button class="btn btn-outline btn-info" type="button"
					onclick="location.href='modify?id=${article.id }'">
					<i class="fa-solid fa-pen"></i>
				</button>
				</div>
				<div class="tooltip" data-tip="글 삭제">
				<button class="btn btn-outline btn-info" type="button"
					onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false; location.href='doDelete?id=${article.id }&boardId=${article.boardId }'">
					<i class="fa-solid fa-trash"></i>
				</button>
				</div>
			</c:if>
		</div>
	</div>
</section>

<script>

	$(document).ready(function(){
		
		$('.doLike').click(function(){
			$.ajax({
				url : '/usr/article/doLike', 
				type : 'GET', 
				data : { 
					id : ${article.id},
					memberNumber : ${rq.loginMemberNumber}
				},
				dataType : 'text', 
				success : function(count) {
					$('.doLike').css('display', 'none');
					$('.undoLike').css('display', 'inline-block');
					$('.likePoint').each(function(index, item){
						$(item).text(count)
					});
				},
				error : function(xhr, status, error) {
					console.log(error);
				},
			})
		})
		
		$('.undoLike').click(function(){
			$.ajax({
				url : '/usr/article/undoLike', 
				type : 'GET', 
				data : { 
					id : ${article.id},
					memberNumber : ${rq.loginMemberNumber}
				},
				dataType : 'text', 
				success : function(count) { 
					$('.undoLike').css('display', 'none');
					$('.doLike').css('display', 'inline-block');
					$('.likePoint').each(function(index, item){
						$(item).text(count)
					});
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			})
		})
	})
	
</script>

<%@ include file="../../common/foot.jsp"%>
