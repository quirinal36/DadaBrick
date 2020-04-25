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
						<div class="item">
							<a href="/products/detail/11" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
							<input type="button" value="변경" class="bt_idx main popup1_opener">
						</div>
						<div class="item">
							<a href="/products/detail/11" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
							<input type="button" value="변경" class="bt_idx main popup1_opener">
						</div>
						<div class="item">
							<a href="/products/detail/11" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
							<input type="button" value="변경" class="bt_idx main popup1_opener">
						</div>
					</div>
				</div>
				<div class="idx_products_wrap">
					<strong>Products</strong>
					<div class="idx_products">
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">점토벽돌</a>
							<input type="button" value="변경" class="bt_idx prdt">
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">타일벽돌</a>
							<input type="button" value="변경" class="bt_idx prdt">
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">고벽돌</a>
							<input type="button" value="변경" class="bt_idx prdt">
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화산석</a>
							<input type="button" value="변경" class="bt_idx prdt">
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화강석</a>
							<input type="button" value="변경" class="bt_idx prdt">
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">바닥벽돌</a>
							<input type="button" value="변경" class="bt_idx prdt">
						</div>
					</div>
				</div>
				<div class="idx_insta_wrap">
					<strong>Instagram</strong>
					<div class="idx_insta">
						<ul>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
							<li>
								<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
								<input type="button" value="변경" class="bt_idx ist">	
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
	<div class="popupWrap popup1">
		<div class="bg"></div>
		<div class="popup_view_wrap">
			<div>
				<div class="popup_view">
					<input type="button" value="닫기" class="bt_popup_close">
					<!-- 팝업 내용 시작 -->
					<form>
						<input type="button" value="사진 업로드" class="bt1">
						<div class="address">
							153156153132.jpg
							<input type="button" value="삭제" class="bt_del">
						</div>
						<input type="text" placeholder="링크 입력" class="ipt1">
						<input type="button" value="등록" class="bt3 on">
					</form>
					<!-- 팝업 내용 끝 -->
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>