<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="Main Page" />
  
<%@ include file="../../common/head.jsp" %>  

	<script>
		$(document).ready(function(){
			$('#test').click(function(){
				$.ajax({
					url : '/usr/home/test', // 요청을 보낼 URL
					type : 'GET', // HTTP 메서드(GET, POST, PUT, DELETE 등)
					data : { // 서버로 전송할 데이터
						key1 : 'value1',
						key2 : 'value2'
					},
					dataType : 'json', // 서버에서 응답 받을 데이터의 타입
					success : function(data) { // 여기서 function은 콜백함수, 성공적으로 요청이 되었을때만 시행. data : 요청을 보낸후 받은 response
						console.log(data);
						$('#testDiv').html('<div>' + data.resultMsg + '</div>');
					},
					error : function(xhr, status, error) {
						console.log(error);
					}
				})
			})
		})
	</script>
	
	

	<section class = "mt-8">
		<div class ="container mx-auto">
			<div><button id="test" class="btn btn-active btn-sm">테스트</button></div>
			<div id="testDiv"></div>
			<div>접속을 환영합니다.</div>
			<div>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</div>
		</div>
	</section>

<%@ include file="../../common/foot.jsp" %>  