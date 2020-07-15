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
<script type="text/javascript">
function deleteSlidePopup(id){
	if("삭제하시겠습니까?"){
		var url = "/delete/slide";
		var param = "id="+id;
		
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType: 'json'
		}).done(function(json){
			alert(json.msg);
			if(json.result > 0){
				window.location.reload();
			}
		});
	}
}
</script>
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
					<div>
						<div class="idx_main">
							<c:forEach items="${slideList }" var="item">
								<div class="item">
									<a href="${item.linkUrl }" class="item" style="background-image: url(${item.url});">제품</a>
									<sec:authorize access="hasRole('ADMIN')">
										<div class="bt_wrap">
											<input type="hidden" value="1" name="display"/>
											<input type="button" value="추가" class="bt_add main popup1_opener">	
											<input type="button" value="삭제" class="bt_del main" onclick="deleteSlidePopup('${item.id}')">	
										</div>
									</sec:authorize>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="idx_products_wrap">
					<strong>Products</strong>
					<div class="idx_products">
						<c:forEach items="${productList }" var="item">
							<div class="item">
								<a href="${item.linkUrl }" class="image" style="background-image: url(${item.url});">사진</a>
								<a href="${item.linkUrl }" class="name">${item.title }</a>
								<sec:authorize access="hasRole('ADMIN')">
									<input type="hidden" value="2" name="display"/>
									<input type="hidden" value="${item.menuId }" name="menuId"/>
									<input type="button" value="변경" class="bt_change prdt popup1_opener">
								</sec:authorize>
							</div>
						</c:forEach>
					</div>
				</div>
				<div class="idx_insta_wrap">
					<strong>Instagram</strong>
					<div class="idx_insta">
						<ul>
							<li>
								<a href="https://www.instagram.com/p/CCqY6jaJta6/" target="_blank" style="background-image: url(/resources/img/temp/i1.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/CB5H-DVJaBq/" target="_blank" style="background-image: url(/resources/img/temp/i2.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/CBiK0rNJ031/" target="_blank" style="background-image: url(/resources/img/temp/i3.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/CBiJu43JKQt/" target="_blank" style="background-image: url(/resources/img/temp/i4.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B9yXbqMp47k/" target="_blank" style="background-image: url(/resources/img/temp/i5.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B9qxyl3J8dn/" target="_blank" style="background-image: url(/resources/img/temp/i6.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B9qwnRIpR3N/" target="_blank" style="background-image: url(/resources/img/temp/i7.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B9gbk3HJYFp/" target="_blank" style="background-image: url(/resources/img/temp/i8.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B9gakQAJn6Q/" target="_blank" style="background-image: url(/resources/img/temp/i9.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B8nKZoUpyVf/" target="_blank" style="background-image: url(/resources/img/temp/i10.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B8nJiGWpUjA/" target="_blank" style="background-image: url(/resources/img/temp/i11.jpg);">사진</a>
							</li>
							<li>
								<a href="https://www.instagram.com/p/B8dH6Crp72D/" target="_blank" style="background-image: url(/resources/img/temp/i12.jpg);">사진</a>
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