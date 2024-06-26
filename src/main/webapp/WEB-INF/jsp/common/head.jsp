<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>

<!-- tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- daisyUI -->
<link
	href="https://cdn.jsdelivr.net/npm/daisyui@4.12.8/dist/full.min.css"
	rel="stylesheet" type="text/css" />


<!-- jQuery -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- font awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

<!-- 공통 CSS -->
<link rel="stylesheet" href="/resource/common.css" />

</head>
<body>

	<div class="h-20 flex container mx-auto text-3xl text-sky-500">
		<div class="logo text-6xl">
			<a href="#" class="h-full flex items-center"><i
				class="fa-solid fa-cloud"></i></a>
		</div>
		<div class="grow"></div>
		<ul class="flex">
			<c:choose>
				<c:when test="${rq.loginMemberNumber == 0 }">
					<li class="hover:underline p-4"><a
						class="h-full px-3 flex items-center" href="/usr/member/login"><span>Login</span></a></li>
				</c:when>
				<c:otherwise>
					<div class="dropdown dropdown-end">
						<div tabindex="0" role="button"
							class="btn btn-ghost btn-circle avatar">
							<div class="w-10 mt-2"> ${rq.loginMemberNn }</div>
						</div>
						<ul tabindex="0"
							class="menu menu-sm dropdown-content bg-base-100 rounded-box z-[1] mt-3 w-52 p-2 shadow">
							<li><a class="h-full px-3 flex items-center" href= "#"> Setting </a></li>
							<li><a class="h-full px-3 flex items-center" href="/usr/member/doLogout">Logout</a></li>
						</ul>
					</div>
				</c:otherwise>
			</c:choose>

			<li class="hover:underline p-4"><a
				class="h-full px-3 flex items-center" href="/"><span>HOME</span></a></li>
			<li class="hover:underline p-4"><a
				class="h-full px-3 flex items-center" href="/usr/article/list"><span>LIST</span></a></li>
		</ul>
	</div>

	<br />

	<div class="p-2 text-4xl">
		<h1>${pageTitle }</h1>
	</div>