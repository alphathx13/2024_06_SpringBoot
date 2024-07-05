<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원 정보 수정" />

<%@ include file="../../common/head.jsp"%>

<section class = "ml-4">
	<div>아이디 : ${member.loginId }</div>
	<div>가입일 : ${member.regDate }</div>
	<div>이름 : ${member.name }</div>
	<form action="change" method="POST" onsubmit="check(this); return false;">
		비밀번호 : <input type="password" maxlength=100 class="input input-bordered w-full mb-4" name="loginPw"></input>
		별명 : <input type="text" maxlength=100 class="input input-bordered w-full mb-4" name="nickname" value="${member.nickname }"></input>
		핸드폰 : <input type="text" maxlength=100 class="input input-bordered w-full mb-4" name="cellphone" value="${member.cellphone }"></input>
		이메일 : <input type="text" maxlength=100 class="input input-bordered w-full mb-4" name="email" value="${member.email }"></input>

		<div class="tooltip" data-tip="뒤로 가기">
			<button class="btn btn-outline btn-info" type="button" onclick="history.back();">
			<i class="fa-solid fa-arrow-left-long"></i>
			</button>
		</div>
			<button class="btn btn-outline btn-info" onclick="location.href='config'"> 회원 정보 수정</button>
	</form>

</section>

<script>
	function check(form) {
		let id = form.id.value.trim();
		let pw = form.pw.value.trim();

		if (id.length == 0) {
			alert('id는 필수입력 정보입니다.');
			form.id.focus();
			return;
		}

		if (pw.length == 0) {
			alert('암호는 필수입력 정보입니다.');
			form.pw.focus();
			return;
		}

		form.submit();
	}
</script>


<%@ include file="../../common/foot.jsp"%>