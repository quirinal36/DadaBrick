<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script src="<c:url value="/resources/js/jquery.i18n.properties.js"/>" type="text/javascript"></script>
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
	
	jQuery.i18n.properties({
  		name: 'messages', 
  		path:'/properties',
  		mode:'map',
  		language:"${locale}",
  		callback: function(){ 
  			
  		}
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
							<c:choose>
								<c:when test="${item.menuNum ge 70}">
									<a href="${item.url }">${item.name }</a>
								</c:when>
								<c:otherwise>
									<a href="${item.url }${item.menuNum}">${item.name }</a>
								</c:otherwise>
							</c:choose>
							<ul class="dep2">
								<c:forEach items="${item.children }" var="menu">
									<li>
										<c:choose>
											<c:when test="${menu.id ge 70 }">
												<a href="${menu.url }">${menu.name }</a>
											</c:when>
											<c:otherwise>
												<a href="${menu.url }${menu.id}">${menu.name }</a>
											</c:otherwise>
										</c:choose>
									</li>
								</c:forEach>
							</ul>
						</li>
						</c:forEach>
					</ul>
				</div>
				<div class="right">
					<a href="<c:url value="/search"/>" class="bt_search"><img src="/resources/img/comm/bt_search.png" alt="검색"></a>
					<a href="https://blog.naver.com/dadabrick" target="_blank" class="bt_blog"><img src="/resources/img/comm/bt_blog.png" alt="블로그"></a>
					<a href="https://www.instagram.com/dadabrick_/" target="_blank" class="bt_insta"><img src="/resources/img/comm/bt_insta.png" alt="인스타그램"></a>
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
											<li>
												<c:choose>
													<c:when test="${menu.id ge 70 }">
														<a href="${menu.url }">${menu.name }</a>
													</c:when>
													<c:otherwise>
														<a href="${menu.url }${menu.id}">${menu.name }</a>
													</c:otherwise>
												</c:choose>
											</li>
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
