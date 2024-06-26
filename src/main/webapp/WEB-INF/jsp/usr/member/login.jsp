<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="로그인 페이지" />
  
<%@ include file="../../common/head.jsp" %>  

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
  		let change = document.querySelector(".see");
  		change.addEventListener("click", function () {
  		  if (input.type == "password") {
  		    input.type = "text";
  		  } else {
  		    input.type = "password";
  		  }
  		});
  	</script>

	<section class="mt-8 text-lg">
		<div class="container mx-auto px-3">
			<form action="doLogin" method="post">
				<div class="table-box-type">
					<table>
						<tr>
							<th>아이디</th>
							<td><input class="w-96" type="text" name="id" placeholder="아이디를 입력해주세요" /></td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input class="pw w-96" type="password" name="pw" placeholder="비밀번호를 입력해주세요" /> <button class = "see" type="button">보기</button></td>
						</tr>
						<tr>
							<td colspan="2"><div class="btns"><button>로그인</button></div></td>
						</tr>
					</table>
				</div>
			</form>
		</div>
	</section>


<!--  
	<form action="doLogin" method="post" onsubmit="check(this); return false;">
		<div> 아이디 : <input type ="text" name = "id" placeholder = "아이디를 입력해주세요"/></div>
		<div> 비밀번호 : <input class = "text-black" type = "text" name="pw" placeholder = "비밀번호를 입력해주세요"/></div>
		<div class="btns"><button> 로그인 </button></div>
	</form>
-->

  	
  	<div class="btns text-3xl mt-3">
		<button class = "back" onclick="history.back();">
			<i class="fa-solid fa-arrow-left-long"></i>
			<div class="tip">
        		<p> 뒤로 가기 </p>
    		</div>
		</button>
	</div>

<%@ include file="../../common/foot.jsp" %>  


<!-- 
	
  		let input = document.querySelector(".pw");
  		let change = document.querySelector(".see");
  		change.addEventListener("click", function () {
  		  if (input.type == "password") {
  		    input.type = "text";
  		  } else {
  		    input.type = "password";
  		  }
  		});
  	
 -->