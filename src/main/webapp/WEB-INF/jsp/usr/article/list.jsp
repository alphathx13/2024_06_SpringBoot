<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
    
<c:set var="pageTitle" value="Article List" />    
    
<%@ include file="../../common/head.jsp" %>      
	
	<section>
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
							<th>수정일시</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${articles }">
							<tr class = "border-collapse border-2 bg-orange-200">
								<td>${article.id } </td>
								<td class="hover:underline"><a href="detail?id=${article.id }">${article.title } </a></td>
								<td>${article.writerName }</td>
								<td>${article.updateDate.substring(2, 16) }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>

<%@ include file="../../common/foot.jsp" %>  