<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
// header 상단 고정
$(window).scroll(function(){
	var sPosition = $(window).scrollTop();
	// console.log(sPosition);
	if( sPosition > 0 ) {
		$("#header").addClass("fixed");
	} else {
		$("#header").removeClass("fixed");
	}
});

// 모바일 메뉴 열기/닫기
$(function(){
	$("#header .bt_menu").click(function(){
		$("html").addClass("fixed");
		$("#gnbWrap_mobile").fadeIn();
		$("#gnbWrap_mobile .cont").css("right", "0");
	});
	$("#gnbWrap_mobile .bg").click(function(){
		$("html").removeClass("fixed");
		$("#gnbWrap_mobile").fadeOut();
		$("#gnbWrap_mobile .cont").css("right", "-240px");
	});
	$("#gnbWrap_mobile .dep1 > li > a").click(function(){
		$("#gnbWrap_mobile .dep1 > li").not($(this).parent()).removeClass("on");
		$(this).parent().toggleClass("on");
		$("#gnbWrap_mobile .dep2").not($(this).find("+ul")).slideUp();
		$(this).find("+ul").slideToggle();
	});
});
</script>
<header>
	<div id="headerWrap">
		<div id="header">
			<div>
				<h1>
					<a href="/">
						<img src="/resources/img/comm/logo.png" alt="logo">
					</a>
				</h1>
				<div id="gnbWrap">
					<ul class="dep1">
						<c:forEach items="${parents}" var="item">
						<li>
							<a href="${item.url }${item.menuNum}">${item.name }</a>
							<ul class="dep2">
								<c:forEach items="${item.children }" var="menu">
									<li><a href="${menu.url }${menu.id}">${menu.name }</a></li>
								</c:forEach>
							</ul>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="right">
					<a href="#" class="bt_search"><img src="/resources/img/comm/bt_search.png" alt="검색"></a>
					<a href="#" target="_blank" class="bt_insta"><img src="/resources/img/comm/bt_insta.png" alt="인스타그램"></a>
					<a href="javascript:void(0);" class="bt_menu"><img src="/resources/img/comm/bt_menu.png" alt="메뉴"></a>
				</div>
				<div id="gnbWrap_mobile">
					<div class="bg"></div>
					<div class="cont">
						<div>
							<div class="logo">
								<a href="/">
									<img src="/resources/img/comm/logo.png" alt="logo">
								</a>						
							</div>
							<ul class="dep1">
								<c:forEach items="${parents}" var="item">
								<li>
									<a href="javascript:void(0);">${item.name }</a>
									<ul class="dep2">
										<c:forEach items="${item.children }" var="menu">
											<li><a href="${menu.url }${menu.id}">${menu.name }</a></li>
										</c:forEach>
									</ul>
								</li>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
