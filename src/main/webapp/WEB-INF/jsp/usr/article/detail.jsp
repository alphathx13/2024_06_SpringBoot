<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시글 보기" />

<%@ include file="../../common/head.jsp"%>

<section class="m-10">
	<div>
		<div class="table-box-type">
			<table class="w-3/5 text-center">
				<tr>
					<th class="border-collapse border-2 bg-orange-300 w-20">글 번호</th>
					<td class="border-collapse border-2 bg-orange-200">${article.id }</td>
				</tr>
				<tr>
					<th class="border-collapse border-2 bg-orange-300">작성자</th>
					<td class="border-collapse border-2 bg-orange-200">${article.writerName }</td>
				</tr>
				<tr>
					<th class="border-collapse border-2 bg-orange-300">작성일시</th>
					<td class="border-collapse border-2 bg-orange-200">${article.regDate.substring(2, 16) }</td>
				</tr>
				<tr>
					<th class="border-collapse border-2 bg-orange-300">수정일시</th>
					<td class="border-collapse border-2 bg-orange-200">${article.updateDate.substring(2, 16) }</td>
				</tr>
				<tr>
					<th class="border-collapse border-2 bg-orange-300">글 제목</th>
					<td class="border-collapse border-2 bg-orange-200">${article.title }</td>
				</tr>
				<tr class="h-40">
					<th class="border-collapse border-2 bg-orange-300">글 내용</th>
					<td class="border-collapse border-2 bg-orange-200">${article.body }</td>
				</tr>
			</table>
		</div>
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
				onclick="if(confirm('정말 삭제하시겠습니까?') == false) return false; location.href='doDelete?id=${article.id }'">
				<i class="fa-solid fa-trash"></i>
			</button>
			</div>
		</c:if>
	</div>
</section>

<%@ include file="../../common/foot.jsp"%>
