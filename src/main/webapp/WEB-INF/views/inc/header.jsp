<%@ page session="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<script>
// header 상단 고정
$(window).scroll(function(){
	var sPosition = $(window).scrollTop();
	console.log(sPosition);
	if( sPosition > 0 ) {
		$("#header").addClass("fixed");
	} else {
		$("#header").removeClass("fixed");
	}
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
				</div>
			</div>
		</div>
	</div>
</header>
