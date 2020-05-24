<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script>
$(function(){
	$("#header").addClass("line");
});
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="containerWrap">
		<div id="container">
			<div id="contentsPrint">
				<!-- 상세 페이지 상단 -->
				<div id="contentsTitle">
					<h2>${product.name }</h2>
				</div>
				<!-- 상세 페이지 슬라이드 -->
				<div class="detail_slider_wrap">
					<div class="detail_slider">
						<c:forEach items="${detailPhotoList }" var="item">
							<div class="item" style="background-image: url(${item.url});">사진</div>
						</c:forEach>
					</div>
					<div class="detail_slider_pager">
						<div>
							<div>
								<c:forEach items="${detailPhotoList }" var="item">
									<a href="" data-slide-index="0"><img src="${item.url}" alt="사진" class="item"></a>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
				<!-- 상세 페이지 제품정보 -->
				<div id="products_info_wrap">
					<table class="tbl1">
						<tbody>
							<tr>
								<th>제품명</th>
								<td>${product.name }</td>
								<th>카테고리</th>
								<td>${product.menuName }</td>
							</tr>
							<tr>
								<th>제품번호</th>
								<td>${product.primaryId}</td>
								<th>규격</th>
								<td>${product.size}</td>
							</tr>
							<tr>
								<th>포장</th>
								<td>${product.packaging }</td>
								<th>배송</th>
								<td>${product.delivery }</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="<c:url value="/products/edit/${product.menuId }"/>" class="bt1">수정</a>
						<a href="#" class="bt1">문의하기</a>
						<a href="<c:url value="/products/list/${product.menuId }"/>" class="bt1 on">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>