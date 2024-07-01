<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="회원가입" />

<%@ include file="../../common/head.jsp"%>

<section class="mt-8 text-lg">
	<div class="container mx-auto px-3">
		<form action="doJoin" method="POST" onsubmit="check(this); return false;">
			<label class="input input-bordered flex items-center gap-2">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"
					fill="currentColor" class="h-4 w-4 opacity-70">
	   				<path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6ZM12.735 14c.618 0 1.093-.561.872-1.139a6.002 6.002 0 0 0-11.215 0c-.22.578.254 1.139.872 1.139h9.47Z" />
	  			</svg> 
	  			<input maxlength="20" type="text" class="grow" placeholder="아이디" name="id"/>
			</label> 
			<label class="mt-1 input input-bordered flex items-center gap-2">
				<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 16 16"
					fill="currentColor" class="h-4 w-4 opacity-70">
	   				<path fill-rule="evenodd"
						d="M14 6a4 4 0 0 1-4.899 3.899l-1.955 1.955a.5.5 0 0 1-.353.146H5v1.5a.5.5 0 0 1-.5.5h-2a.5.5 0 0 1-.5-.5v-2.293a.5.5 0 0 1 .146-.353l3.955-3.955A4 4 0 1 1 14 6Zm-4-2a.75.75 0 0 0 0 1.5.5.5 0 0 1 .5.5.75.75 0 0 0 1.5 0 2 2 0 0 0-2-2Z"
						clip-rule="evenodd" />
	  			</svg> 
	  			<input maxlength="12" type="password" class="pw grow" placeholder="비밀번호" name="pw"/> 
	  			<button class="change" type="button"><i class="see fa-solid fa-eye"></i><i class="notSee hidden fa-solid fa-eye-slash"></i></button>
			</label>
			<button class="mt-5 btn btn-outline btn-info">회원가입</button>
		</form>
	</div>
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

let input = document.querySelector(".pw");
let change = document.querySelector(".change");
let see = document.querySelector(".see");
let notSee = document.querySelector(".notSee");

change.addEventListener("click", function() {
	if (input.type == "password") {
		input.type = "text";
		see.style.display= "none";
		notSee.style.display = "block";
	} else {
		input.type = "password";
		see.style.display = "block";
		notSee.style.display = "none";
	}
});
</script>

<%@ include file="../../common/foot.jsp"%>
