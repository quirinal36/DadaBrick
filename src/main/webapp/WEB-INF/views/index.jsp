<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="containerWrap">
		<div id="container">
			<!-- 
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			-->
			<div id="contentsPrint">
				<div class="idx_main_wrap">
					<div class="idx_main">
						<a href="#" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
						<a href="#" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
						<a href="#" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
					</div>
				</div>
				<div class="idx_products_wrap">
					<strong>Products</strong>
					<div class="idx_products">
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">점토벽돌</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">타일벽돌</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">고벽돌</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화산석</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화강석</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">바닥벽돌</a>
						</div>
					</div>
				</div>
				<div class="idx_insta_wrap">
					<strong>Instagram</strong>
					<div class="idx_insta">
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
					</div>
				</div>
				<!-- 콘텐츠페이지 상단 이미지 -->
				<div id="contentsTop">
					<div style="background-image: url(/resources/img/temp/4.png);"></div>
				</div>
				<div id="contentsTitle">
					<h2>점토벽돌</h2>
					<ul>
						<li class="on"><a href="#">점토벽돌<span>(60)</span></a></li>
						<li><a href="#">전돌벽돌<span>(54)</span></a></li>
						<li><a href="#">수입벽돌<span>(21)</span></a></li>
						<li><a href="#">수공예벽돌<span>(34)</span></a></li>
					</ul>
				</div>
				<div id="contentsSearch">
					<div>
						<div class="text">[유로] 검색 결과입니다.</div>
						<div class="search_area">
							<form>
								<input type="text" placeholder="검색어 입력">
								<input type="button" value="검색">
							</form>
						</div>
					</div>
				</div>
				<div id="products_list_wrap">
					<ul>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>