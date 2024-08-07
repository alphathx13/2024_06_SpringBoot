<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>${pageTitle }</title>
	<link rel="shortcut icon" href="/resource/favicon/favicon.ico" />
	
	<!-- tailwind CSS -->
	<script src="https://cdn.tailwindcss.com"></script>
	
	<!-- daisyUI -->
	<link
		href="https://cdn.jsdelivr.net/npm/daisyui@4.12.8/dist/full.min.css"
		rel="stylesheet" type="text/css" />
	
	<!-- jQuery -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- font awesome -->
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
	
	<!-- 공통 CSS -->
	<link rel="stylesheet" href="/resource/common.css" />
	
	<!-- 공통 javascript -->
	<script src="/resource/common.js" defer="defer"></script>

</head>
<body>
	<div class="h-20 flex container mx-auto text-3xl text-sky-500">
		<div class="logo text-6xl">
			<a href="#" class="h-full flex items-center"><i class="fa-solid fa-cloud"></i></a>
		</div>
		<div class="grow"></div>
		<ul class="flex">
			<c:choose>
				<c:when test="${rq.loginMemberNumber == 0 }">
					<li class="hover:underline p-4 text-black">
						<button class="btn text-sky-500" onclick="my_modal_1.showModal()">로그인</button>
						<dialog id="my_modal_1" class="modal">
					  		<div class="modal-box">
					    		<h3 class="text-lg font-bold">Login</h3>
					    		<div class="container mx-auto px-3 w-72">
									<form action="/usr/member/doLogin" method="post" onsubmit="check(this); return false;">
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
										<div class="tooltip w-full" data-tip="로그인">
											<button class="mt-5 w-full text-xl btn btn-outline">
												<i class="fa-solid fa-right-to-bracket text-black"></i>
											</button>
										</div>
									</form>
									<div class="mt-4 font-bold text-xs"><a href="#" class = "hover:text-sky-500 font-extrabold">비밀번호를 잊어버리셨나요?</a></div>
									<div class="mt-4 font-bold text-xs"><a href="/usr/member/join" class = "hover:text-sky-500 font-extrabold">계정이 없으신가요?</a></div>
								</div>
					      		<form method="dialog">
					        		<button class="btn">Close</button>
					      		</form>
					    	</div>
						</dialog>
					</li>
				</c:when>
				<c:otherwise>
					<div class="mt-6 dropdown dropdown-end">
						<div tabindex="0" role="button">
							<div class="w-10 rounded-full flex">
            					<i class="fa-solid fa-user"></i><div class="text-xl ml-2">${rq.loginMemberNn }</div>
        					</div>
						</div>
						<ul tabindex="0"
							class="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 shadow w-24">
							<li><div>  </div></li>
							<li><button class="h-full flex items-center" onclick="location.href='/usr/member/myPage'"> 마이 페이지 </button></li>
							<li><button class="h-full flex items-center" onclick="if(confirm('로그아웃 하시겠습니까?') == false) return false; location.href='/usr/member/doLogout'">로그아웃</button></li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>

			<li class="hover:underline p-4 ml-4"><a
				class="h-full px-3 flex items-center" href="/"><span>HOME</span></a>
			<li class="hover:underline p-4"><a
				class="h-full px-3 flex items-center" href="/usr/article/list?boardId=1"><span>NOTICE</span></a>
			<li class="hover:underline p-4"><a
				class="h-full px-3 flex items-center" href="/usr/article/list?boardId=2"><span>FREE</span></a>
		</ul>
	</div>

	<div class="ml-72 p-2 text-4xl">
		<h1>${pageTitle }</h1>
	</div>

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
	