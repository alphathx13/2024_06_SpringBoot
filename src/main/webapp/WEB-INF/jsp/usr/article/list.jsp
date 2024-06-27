<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
    
<c:set var="pageTitle" value="게시물 목록" />    
    
<%@ include file="../../common/head.jsp" %>      
	
	<section class="mt-8 text-lg text-center">
		<div class="container flex flex-col mx-auto px-3 w-3/5">
			<div class="flex justify-center">
				<table class = "w-full text-center">
					<colgroup>
						<col class = "w-1/6"/>
						<col class = "w-2/6"/>
						<col class = "w-1/6"/>
						<col class = "w-2/6"/>
					</colgroup>
					<thead>
						<tr class = "border-collapse border-2 bg-orange-300">
							<th>글 번호</th>
							<th>글 제목</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articles }">
							<tr class = "border-collapse border-2 bg-orange-200">
								<td>${article.id } </td>
								<td class="hover:underline"><a href="detail?id=${article.id }">${article.title } </a></td>
								<td>${article.writerName }</td>
								<td>${article.regDate.substring(2, 16) }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="mt-4 w-full flex justify-end">
				<c:if test="${rq.loginMemberNumber != 0 }">
					<div class="tooltip" data-tip="글 작성">
						<a class="btn btn-outline btn-info mr-4" href="write">
							<i class="fa-solid fa-pen"></i>
						</a>
					</div>
				</c:if>
			</div>
		</div>
	</section>
	
	

<%@ include file="../../common/foot.jsp" %>  