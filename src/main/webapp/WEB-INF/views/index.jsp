<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
						<div class="item">
							<a href="/products/detail/11" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
							<input type="button" value="변경" class="bt_change main popup1_opener">
						</div>
						<div class="item">
							<a href="/products/detail/11" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
							<input type="button" value="변경" class="bt_change main popup1_opener">
						</div>
						<div class="item">
							<a href="/products/detail/11" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
							<input type="button" value="변경" class="bt_change main popup1_opener">
						</div>
					</div>
				</div>
				<div class="idx_products_wrap">
					<strong>Products</strong>
					<div class="idx_products">
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">점토벽돌</a>
							<sec:authorize access="hasRole('ADMIN')">
								<input type="button" value="변경" class="bt_change prdt">
							</sec:authorize>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">타일벽돌</a>
							<sec:authorize access="hasRole('ADMIN')">
								<input type="button" value="변경" class="bt_change prdt">
							</sec:authorize>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">고벽돌</a>
							<sec:authorize access="hasRole('ADMIN')">
								<input type="button" value="변경" class="bt_change prdt">
							</sec:authorize>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화산석</a>
							<sec:authorize access="hasRole('ADMIN')">
								<input type="button" value="변경" class="bt_change prdt">
							</sec:authorize>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화강석</a>
							<sec:authorize access="hasRole('ADMIN')">
								<input type="button" value="변경" class="bt_change prdt">
							</sec:authorize>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">바닥벽돌</a>
							<sec:authorize access="hasRole('ADMIN')">
								<input type="button" value="변경" class="bt_change prdt">
							</sec:authorize>
						</div>
					</div>
				</div>
				<div class="idx_insta_wrap">
					<strong>Instagram</strong>
					<div class="idx_insta">
						<ul>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>