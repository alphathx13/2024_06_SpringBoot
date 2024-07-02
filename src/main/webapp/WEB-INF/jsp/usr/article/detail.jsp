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
			<div class="likeTooltip tooltip w-24 h-full" data-tip="">
				<button class="likeBtn btn btn-outline btn-info w-full h-full text-xl" type="button">
					<i class="star"><div class="likePoint text-xl">${article.likePoint }</div></i>
				</button>
			</div>
		</div>	
		
		<div class="reply">
			<table class="table">
				<colgroup>
					<col width="30"/>
					<col width=""/>
					<col width="200"/>
				</colgroup>
			    <thead>
		     		<tr>
		        		<th>작성자</th>
		        		<th>내용</th>
				        <th>작성일시</th>
						<th></th>
		   			</tr>
		    	</thead>
		    	<tbody>
		    		<c:forEach var="reply" items="${replyList }">
		      			<tr>
		        			<th>${reply.nickname }</th>
		        			<th>${reply.body }</th>
		        			<th class="flex">
        						${reply.updateDate }
								<c:if test="${reply.regDate != reply.updateDate}">
									<div>&nbsp; 수정됨</div>
								</c:if>       				
		        			</th>
		        			<th>
		        				<c:if test="${reply.memberNumber == rq.loginMemberNumber }">
		        					<button>
		        						<i class="fa-solid fa-pen-to-square"></i>
		        					</button>
		        				</c:if>
		        			</th>
		      			</tr>
		   			</c:forEach>  
		    	</tbody>
			</table>
		</div>
		
		<div class="writeReply mt-5 w-full bg-sky-200 h-40">
			테스트 영역
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
		if (${rq.loginMemberNumber == 0 }) {
			$('.likeTooltip').attr('data-tip', '추천수');
			$('.star').addClass('fa-solid fa-splotch');
		} else {
		
			$.ajax({
				url : '../likePoint/likeCheck',
				type : 'GET',
				data : {
					relTypeCode : 'article',
					relId : ${article.id }
				},
				dataType : 'json',
				success : function(result) {
					if (result.resultCode == "S-1") {
						$('.likeBtn').html(`
								<i class="star fa-solid fa-star"></i>
								<div class="likePoint">${article.likePoint }</div>
								`);
						$('.likeTooltip').attr('data-tip', '추천취소');
					} else {
						$('.likeBtn').html(`
								<i class="star fa-regular fa-star"></i>
								<div class="likePoint">${article.likePoint }</div>
								`);
						$('.likeTooltip').attr('data-tip', '추천하기');
					}
				},
				error : function(xhr, status, error) {
					console.log(error);
				}
			})
		}
	})
	
	$('.likeBtn').click(function(){

		let likeCheck = true;
		if($('.star').hasClass('fa-regular')) {
			likeCheck = false;
		}

		$.ajax({
			url : '../likePoint/doLike',
			type : 'GET',
			data : {
				relTypeCode : 'article',
				relId : ${article.id },
				likeCheck : likeCheck
			},
			dataType : 'json',
			success : function(result) {
				$('.likePoint').text(result.data);
				if (result.resultCode == 'undoLike') {
					$('.star').attr('class','star fa-regular fa-star');
					$('.likeTooltip').attr('data-tip', '추천하기');
				} else {
					$('.star').attr('class','star fa-solid fa-star');
					$('.likeTooltip').attr('data-tip', '추천취소');
				}
			},
			error : function(xhr, status, error) {
				console.log(error);
			}
		})
	}) 
	
</script>

<%@ include file="../../common/foot.jsp"%>
