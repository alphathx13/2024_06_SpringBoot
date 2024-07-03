<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시글 보기" />

<%@ include file="../../common/head.jsp"%>

<!-- 전체 틀 -->
<section class="mt-8 text-lg text-center">
	<div class="container flex flex-col mx-auto px-3 w-3/5">
		
		<!-- 게시글 내용 -->
		<div class="flex justify-center">
			<table class="w-full table table-xl table-pin-rows table-pin-cols text-xl">
				<colgroup>
					<col width=150/>
					<col width=150/>
					<col/>
					<col width=220/>
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
					<td colspan="4" class="">${article.getBody() }</td>
				</tr>
			</table>
		</div>
		
		<!-- 추천수 -->
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
								$('.likeBtn').html(`
										<i class="star fa-solid fa-star"></i>
										<div class="likePoint">${article.likePoint }</div>
										`);
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
			
			const likeBtnChange = function() {
				
				if(${rq.loginMemberNumber != 0}) {
		
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
				}
			}
		</script>
		
		<div class="h-16">
			<div class="likeTooltip tooltip w-20 h-full" data-tip="">
				<button class="likeBtn btn btn-outline w-full h-full text-xl" onclick = "likeBtnChange();" type="button">
					<i class="star"><div class="likePoint text-xl">${article.likePoint }</div></i>
				</button>
			</div>
		</div>	
			
			
		<!--  댓글 조회 및 수정 삭제 -->
		<script>
			$(document).ready(function(){
				replyLoad('article', ${article.id });
			})
			
			const replyLoad = function(relTypeCode, relId) {
				$.ajax({
					url : '../reply/viewReply',
					type : 'POST',
					data : {
						relTypeCode : relTypeCode,
						relId : relId
					},
					async: false,
					dataType : 'json',
					success : function(result) {
						let loginMemberNumber = ${rq.loginMemberNumber};
						let content = '';
						if (result.data.length != 0) {
							
							$('.reply').html(`
									<div class="container mx-auto px-3>
										<div class="">
											<table class="table table-lg">
												<colgroup>
													<col width="30"/>
													<col width=""/>
													<col width="210"/>
													<col width="10"/>
													<col width="10"/>
												</colgroup>
											<thead>
												<tr>
													<th>작성자</th>
													<th>내용</th>
													<th>작성일시</th>
													<th></th>
													<th></th>
												</tr>
											</thead>
												<tbody class="replyList">
												</tbody>
											</table>
										</div>
									</div>
									`);
						
							$.each(result.data, function(index, item) {
								content += `
										<tr>
											<td>\${item.nickname}</td>
											<td>
												<div class="\${item.id}R">\${item.body}	</div>
												<div class="\${item.id}"></div>
											</td>
											<td>\${item.updateDate}
										`;
								if (item.regDate != item.updateDate) {
									content += `(수정됨)`;
								}
								content += `</td>`;
								$('.replyList').append('</td>');		
								if(item.memberNumber == loginMemberNumber ) {
									content += `<td><div class="tooltip" data-tip="댓글 수정"><button onclick="replyModify(\${item.id})"><i class="fa-solid fa-pen-to-square"></i></button></div></td>`;
									content += `<td><div class="tooltip" data-tip="댓글 삭제"><button onclick="replyDelete(\${item.id}); return false;"><i class="fa-solid fa-trash-can"></i></button></div></td>`;
								}
							})
							$('.replyList').append(content);
						}
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				})
			}
			
			const replyModify = function(id) {
				let body;
				
				$.ajax({
					url : '../reply/getReplyBody',
					type : 'POST',
					data : {
						id : id
					},
					dataType : 'text',
					success : function(result) {
						body = result;
						
						if(!$('div.' + id).hasClass('replyModifyOpen')) {
							replyFormClose('replyModifyOpen');
							
							console.log(body);
							
							$('div.' + id + 'R').css('display', 'none');
							$('div.' + id).html(`
									<form class="replyForm" onsubmit="if(replyForm_onSubmit(this) == true) { if(confirm('댓글을 수정하시겠습니까?')) replySend(this);} return false;">
										<input type="hidden" name="id" value="\${id}"/>
										<input type="hidden" name="articleId" value="${article.id }"/>
										<textarea maxlength=300 class="textarea textarea-bordered textarea-lg w-full" name="body" placeholder="\${body}"></textarea>
										<div class="flex justify-end"><button class="btn btn-outline btn-sm">댓글 수정</button></div>
									</form>
									`);
							$('div.' + id).addClass('replyModifyOpen');
						} else {
							replyFormClose(id);
						}
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				})
			}
			
			const replyFormClose = function(id) {
				$('div.' + id).siblings().css('display', 'inline-block');
				$('div.' + id).html('');
				$('div.' + id).removeClass('replyModifyOpen');
			}
			
			function replySend(){
				let data = $(".replyForm").serialize();
				
				$.ajax({
					url : '../reply/replyModify',
					type : 'POST',
					data : data,
					dataType : 'json',
					success : function(result) {
						location.href='/usr/article/detail?id=${article.id}';
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				})
			}
			
			const replyDelete = function(id) {
				if(confirm('정말 삭제하시겠습니까?')) {
					location.href="/usr/reply/replyDelete?id=" + id + "&articleId=" + ${article.id};
				}
			}
			
		</script>	
		
		<section class="reply mt-8 text-lg"></section>	
		
		<!--  댓글 작성 -->
		<script>
			const replyForm_onSubmit = function(form){
				let body = form.body.value.trim();
			
				if (body.length == 0) {
					alert('비어있는 댓글은 작성할 수 없습니다');
					form.body.focus();
					return false;
				}
				
				return true;
			}
		</script>
		
		<div class="container mx-auto px-3">
			
			<form action="../reply/doWrite" method="post" onsubmit="if(replyForm_onSubmit(this)) { if(confirm('댓글을 작성하시겠습니까?')) form.submit();} return false;">
				<input type="hidden" name="relTypeCode" value="article"/>
				<input type="hidden" name="relId" value="${article.id }"/>
				<div class="mt-4 reply-border p-4 text-left">
					<div class="mb-2">${rq.loginMemberNn }</div>
					<textarea maxlength=300 class="textarea textarea-bordered textarea-lg w-full" name="body" placeholder="댓글을 입력하세요."></textarea>
					<div class="flex justify-end"><button class="btn btn-outline btn-sm">댓글 작성</button></div>
				</div>
			</form>
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
					<i class="fa-solid fa-pen-to-square"></i>
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



<%@ include file="../../common/foot.jsp"%>

<!-- 
$('.reply').append('<section class="mt-4 border-2 border-red-200"><table class="table"><colgroup><col width="30"/><col width=""/><col width="210"/><col width="10"/><col width="10"/></colgroup><thead><tr><th>작성자</th><th>내용</th><th>작성일시</th></tr></thead><tbody class="replyList"></tbody></table></section>');
							$.each(result.data, function(index, item) {
								console.log(item);
								let str = '';
								str += '<tr>';
								str += '<td>' + item.nickname + '</td><td><div class="'+item.id+'R">';
								if(item.relTypeCode != 'article') {
									str += '<i class="fa-solid fa-l"></i> &nbsp;&nbsp;';	
								}
								str += item.body + '</div><div class="' + item.id + '"></div></td><td>' + item.updateDate;
								if(item.regDate != item.updateDate) {
									str += '&nbsp;&nbsp;(수정됨)';
								}
								str += '</td>';
								if(item.memberNumber == ${rq.loginMemberNumber }) {
									str += '<td><div class="tooltip" data-tip="댓글 수정"><button onclick="replyModify(' + item.id + ', \'' + item.body + '\')"><i class="fa-solid fa-pen-to-square"></i></button></div></td>';
									str += '<td><div class="tooltip" data-tip="댓글 삭제"><button onclick="replyDelete(' + item.id + '); return false;"><i class="fa-solid fa-trash-can"></i></button></div></td>';
								}
								str += '</tr>';
								$('.replyList').append(str);
							});						
								
 -->
