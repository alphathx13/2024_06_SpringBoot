<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원 정보 수정" />

<%@ include file="../../common/head.jsp"%>

<section class = "ml-4">
	<div>아이디 : ${member.loginId }</div>
	<div>가입일 : ${member.regDate }</div>
	<div>이름 : ${member.name }</div>
	<form action="memberModify" method="POST" onsubmit="check(this); return false;">
		<label class="mt-1 input input-bordered flex items-center gap-2">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"
					fill="currentColor" class="h-4 w-4 opacity-70">
	   				<path fill-rule="evenodd"
						d="M14 6a4 4 0 0 1-4.899 3.899l-1.955 1.955a.5.5 0 0 1-.353.146H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2.293a.5.5 0 0 1 .146-.353l3.955-3.955A4 4 0 1 1 14 6Zm-4-2a.75.75 0 0 0 0 1.5.5.5 0 0 1 .5.5.75.75 0 0 0 1.5 0 2 2 0 0 0-2-2Z"
						clip-rule="evenodd" />
	  			</svg> 
	  			<input maxlength="12" type="password" class="pw grow" placeholder="비밀번호" name="loginPw"/> 
	  			<button class="change" type="button"><i class="see fa-solid fa-eye"></i><i class="notSee hidden fa-solid fa-eye-slash"></i></button>
			</label>
			<label class="mt-1 input input-bordered flex items-center gap-2">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"
					fill="currentColor" class="h-4 w-4 opacity-70">
	   				<path fill-rule="evenodd"
						d="M14 6a4 4 0 0 1-4.899 3.899l-1.955 1.955a.5.5 0 0 1-.353.146H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2.293a.5.5 0 0 1 .146-.353l3.955-3.955A4 4 0 1 1 14 6Zm-4-2a.75.75 0 0 0 0 1.5.5.5 0 0 1 .5.5.75.75 0 0 0 1.5 0 2 2 0 0 0-2-2Z"
						clip-rule="evenodd" />
	  			</svg> 
	  			<input maxlength="12" type="password" class="pw grow" placeholder="비밀번호 재입력" name="loginPwRe"/> 
			</label>
			별명 : <label class="mt-1 input input-bordered flex items-center gap-2" >
	  			<input maxlength="12" type="text" class="grow" placeholder="닉네임" name="nickname" value="${member.nickname }"/> 
			</label>
			핸드폰 : <label class="mt-1 input input-bordered flex items-center gap-2">
	  			<input maxlength="13" type="text" class="grow" placeholder="핸드폰번호" name="cellphone" value="${member.cellphone }"/> 
			</label>
			이메일 : <label class="mt-1 input input-bordered flex items-center gap-2">
	  			<input maxlength="30" type="text" class="grow" placeholder="이메일" name="email" value="${member.email }"/> 
			</label>
		<div class="tooltip" data-tip="뒤로 가기">
			<button class="btn btn-outline btn-info" type="button" onclick="history.back();">
			<i class="fa-solid fa-arrow-left-long"></i>
			</button>
		</div>
			<button class="btn btn-outline btn-info"> 회원 정보 수정</button>
	</form>

</section>

<script>
	function check(form) {
		let loginPw = form.loginPw.value.trim();
		let loginPwRe = form.loginPwRe.value.trim();
		let nickname = form.nickname.value.trim();
		let cellphone = form.cellphone.value.trim();
		let email = form.email.value.trim();
		
		if (loginPw.length == 0) {
			alert('암호는 필수입력 정보입니다.');
			form.pw.focus();
			return;
		}
		
		if (loginPwRe.length == 0) {
			alert('암호확인은 필수입력 정보입니다.');
			form.pw.focus();
			return;
		}
		
		if (loginPw != loginPwRe) {
			alert('입력하신 비밀번호가 일치하지 않습니다.');
			form.loginPw.value = '';
			form.loginPwRe.value = '';
			return false;
		}
		
		if (nickname.length == 0) {
			alert('닉네임은 필수입력 정보입니다.');
			form.nickname.focus();
			return false;
		}
		
		if (cellphone.length == 0) {
			alert('핸드폰번호는 필수입력 정보입니다.');
			form.cellphone.focus();
			return false;
		}
	
		if (email.length == 0) {
			alert('이메일은 필수입력 정보입니다.');
			form.email.focus();
			return false;
		}
		
		form.submit();
	}
	
	$('.change').click(function() {
		if ($('.pw').attr('type') == 'password') {
			$('.pw').attr('type', 'text');
			$('.see').css('display', 'none');
			$('.notSee').css('display', 'block');
		} else {
			$('.pw').attr('type', 'password');
			$('.see').css('display', 'block');
			$('.notSee').css('display', 'none');
		}
	})
</script>


<%@ include file="../../common/foot.jsp"%>