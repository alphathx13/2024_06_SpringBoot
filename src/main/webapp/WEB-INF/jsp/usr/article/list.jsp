<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
	int cPage = (int) request.getAttribute("cPage");
	int tPage = (int) request.getAttribute("tPage");
	int from = (int) request.getAttribute("from");
	int tempPage = cPage;
%>    
    
<c:set var="pageTitle" value="${boardName} " />    
    
<%@ include file="../../common/head.jsp" %>      
	
	<section class="mt-8 text-lg text-center">
		<div class="container flex flex-col mx-auto px-3 w-3/5">
			<div class="list_top flex">
				<div>총 게시글 : ${articleCount }</div>
				<div class ="grow"></div> 
				<div>${cPage } 페이지 / ${tPage } 페이지 &nbsp;&nbsp;</div>
				<div>
					<form action="" method="get"> 
						<input type="hidden" name ="page" value="1"/>
						<input type="hidden" name ="boardId" value="${param.boardId }"/>
						<select onchange="this.form.submit()" name="itemsInPage">
							<option value="" selected disabled> 페이지내 게시글 수
							<option value="10"> 10개
							<option value="20"> 20개
							<option value="30"> 30개
							<option value="50"> 50개
						</select>
					</form>
				</div>
			</div>	
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
			<div class="mt-4 w-full flex justify-between">
				<div></div>
				<div>
					<form action="" method="get"> 
						<input type="hidden" name ="page" value="1"/>
						<input type="hidden" name ="boardId" value="${param.boardId }"/>
						<select name="searchType">
							<option value="" selected disabled> 검색항목
							<option value="1"> 제목
							<option value="2"> 내용
							<option value="3"> 제목+내용
						</select>
						<input class="input input-bordered w-full max-w-sm" type="text" style="width:110px; text-align:center" name ="searchText" placeholder="검색"/>
					&nbsp;<button class="join-item btn btn-sm">검색</button>
					</form>
				</div>
				<c:if test="${rq.loginMemberNumber != 0 }">
					<div class="tooltip" data-tip="글 작성">
						<a class="btn btn-outline btn-info mr-4" href="doWrite?boardId=${param.boardId}">
							<i class="fa-solid fa-pen"></i>
						</a>
					</div>
				</c:if>
			</div>
			<div class="mt-4 mb-4 flex justify-center">
				<a class="join-item btn btn-sm" href="?cPage=1&boardId=${param.boardId}&itemsInPage=${itemsInPage}"> 첫페이지 </a> &nbsp;&nbsp;
		
				<c:forEach begin="1" end="${tPage }" var="i">
					<a class="join-item btn btn-sm ${i == cPage? 'btn-active' : ''}"  href="?cPage=${i }&boardId=${param.boardId}&itemsInPage=${itemsInPage}&searchType=${searchType}&searchText=${searchText}"> ${i } </a>
				</c:forEach>
		
				&nbsp;&nbsp;<a class="join-item btn btn-sm" href="?cPage=<%= tPage %>&boardId=${param.boardId}&itemsInPage=${itemsInPage}"> 끝페이지</a>&nbsp;&nbsp;
				
				<form action="" method="get" onsubmit="pageCheck(this); return false;"> 
					<input type="hidden" name ="boardId" value="${param.boardId }"/>
					<input type="hidden" name ="itemsInPage" value="${itemsInPage }"/>
					<input type="hidden" name ="searchType" value="${searchType }"/>
					<input type="hidden" name ="searchText" value="${searchText }"/>
					<input class="input input-bordered w-full max-w-sm" type="text" style="width:110px; text-align:center" name ="cPage" placeholder="이동할 페이지"/>
					&nbsp;<button class="join-item btn btn-sm">이동</button>
				</form>
			</div>
		</div>
	</section>
	
	<script>
	
	if (${searchType} == 1) {
		$("select[name=searchType]").val("1").prop("selected", true);
	} else if (${searchType} == 2) {
		$("select[name=searchType]").val("2").prop("selected", true);
	} else if (${searchType} == 3) {
		$("select[name=searchType]").val("3").prop("selected", true);
	}
	
	if (${searchText} != '') {
		$("input[name=searchText]").attr("value", "${searchText}");
	}

	function pageCheck(form) {
		let cPage = form.cPage.value.trim();

		if (cPage <= 0 || cPage > ${tPage}) {
			alert('해당 페이지는 존재하지 않습니다.');
			form.cPage.focus();
			return;
		}
		
		if (isNaN(cPage)) {
			alert('숫자만 입력해주세요.');
			form.cPage.focus();
			return;
		}
		
		form.submit();
	}
	</script>
	
<%@ include file="../../common/foot.jsp" %>  