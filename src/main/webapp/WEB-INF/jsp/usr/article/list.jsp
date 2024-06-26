<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
    
<c:set var="pageTitle" value="Article List" />    
    
<%@ include file="../../common/head.jsp" %>      
	
	<section class = "m-10">
		<div>
			<div class="table-box-type">
				<table class = "w-3/5 text-center">
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
		</div>
	</section>
	
	<div class = "ml-4">
		<c:if test="${rq.loginMemberNumber != 0 }">
			<div class="tooltip" data-tip="글 작성">
				<button class="btn btn-outline btn-info" type="button"
					onclick="location.href='write'">
					<i class="fa-solid fa-pen"></i>
				</button>
			</div>
		</c:if>
	</div>

<%@ include file="../../common/foot.jsp" %>  