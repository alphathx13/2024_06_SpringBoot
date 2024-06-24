<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${pageTitle }</title>

<!-- tailwind CSS -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- font awesome -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"></script>

<!-- jQuery -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 공통 CSS -->
<link rel="stylesheet" href="/resource/common.css" />

</head>
<body>
	
	<div class = "h-20 flex container mx-auto text-3xl">
		<div class = "h-full flex items-center"><a href="/"><i class="fa-solid fa-cloud"></i></a></div>
		<div class = "grow"></div>
		<ul class = "flex">
			<li class = "hover:underline p-4"><a class="h-full px-3 flex items-center" href="/"><span>HOME</span></a></li>
			<li class = "hover:underline p-4"><a class="h-full px-3 flex items-center" href="/usr/article/list"><span>LIST</span></a></li>
		</ul>
	</div>
	
	<br/>
	
	<div class = "p-2 text-4xl"><h1>${pageTitle }</h1></div>