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
		
		<c:if test="${rq.loginMemberNumber != 0 }">
			<div class="h-16">
				<div id="undoLike" class="tooltip w-16 h-full text-3xl" data-tip="추천 취소">
					<button class="btn btn-outline btn-info w-full h-full" type="button">
						<i class="fa-solid fa-star"><div class="likePoint text-xl"></div></i>
					</button>
				</div>
				<div id="doLike" class="tooltip w-16 h-full text-3xl" data-tip="추천">
					<button class="btn btn-outline btn-info w-full h-full" type="button">
						<i class="fa-regular fa-star"><div class="likePoint text-xl"></div></i>
					</button>
				</div>
			</div>
		</c:if>
		
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
	window.onload=function(){
		if (${articleLikeCheck == 1}) {
			$('#doLike').css('display', 'none');
		} else {
			$('#undoLike').css('display', 'none');
		}
		$('.likePoint').each(function(index,item){
			$(item).text("${article.likePoint}")
		});
	}

	$(document).ready(function(){
		
		let likePoint = ${article.likePoint};
		
		$('#doLike').click(function(){
			$.ajax({
				url : '/usr/article/doLike', 
				type : 'GET', 
				data : { 
					id : ${article.id},
					memberNumber : ${rq.loginMemberNumber}
				},
				dataType : 'text', 
				success : function() {
					likePoint = likePoint + 1;
					$('#doLike').css('display', 'none');
					$('#undoLike').css('display', 'inline-block');
					$('.likePoint').each(function(index, item){
						$(item).text(likePoint)
					});
				},
				error : function(xhr, status, error) {
					console.log(error);
				},
			})
		})
		
		$('#undoLike').click(function(){
			$.ajax({
				url : '/usr/article/undoLike', 
				type : 'GET', 
				data : { 
					id : ${article.id},
					memberNumber : ${rq.loginMemberNumber}
				},
				dataType : 'text', 
				success : function() { 
					likePoint = likePoint - 1;
					$('#undoLike').css('display', 'none');
					$('#doLike').css('display', 'inline-block');
					$('.likePoint').each(function(index, item){
						$(item).text(likePoint)
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
