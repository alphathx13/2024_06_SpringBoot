<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="게시글 작성" />

<%@ include file="../../common/head.jsp"%>

<script>
	function check(form) {
		let title = form.title.value.trim();
		let body = form.body.value.trim();

		if (title.length == 0) {
			alert('글 제목은 필수입력 정보입니다.');
			form.title.focus();
			return;
		}

		if (body.length == 0) {
			alert('글 내용은 필수입력 정보입니다.');
			form.body.focus();
			return;
		}

		form.submit();
	}

</script>

<section class="mt-8 text-lg">
	<div class="container mx-auto px-3">
		<form action="doWrite" method="GET" onsubmit="check(this); return false;">
			<input type="hidden" value="${boardId }" name="boardId">
			<label class="input input-bordered flex items-center gap-2">
				글 제목 : <input type="text" class="grow" name="title"
				placeholder="${article.title } " />
			</label> <label class="input input-bordered flex items-center gap-2">
				글 내용 : <input type="text" class="grow h-20" name="body"
				placeholder="${article.body }" />
			</label>
			<div class="tooltip" data-tip="뒤로 가기">
				<button class="btn btn-outline btn-info" onclick="history.back();" type="button">
				<i class="fa-solid fa-arrow-left-long"></i>
				</button>
			</div>
			<button class="mt-5 btn btn-outline btn-info">글 작성하기</button>
		</form>
	</div>
</section>

<%@ include file="../../common/foot.jsp"%>
