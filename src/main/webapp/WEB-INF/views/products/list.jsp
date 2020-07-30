<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd-HHmm" var="nowDate"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script type="text/javascript" src="<c:url value="/resources/js/list.js"><c:param name="dt" value="${nowDate }"/></c:url>"></script>
<script src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.min.js"></script>
<script type="text/javascript">
function getNextPage(){
	return "";
}
function pageGo(pageNo){
	window.location.replace("/products/list/${current.menuNum}/"+pageNo);
}
$(".container").infiniteScroll({
	path: getNextPage,
	append: '.product',
	history: false,
});
</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="containerWrap">
		<div id="container">
			<div id="contentsPrint">
				<!-- 목록 페이지 상단 -->
				<div id="contentsTop">
					<div style="background-image: url(${paging.slideInfo.url});">
						<sec:authorize access="hasRole('ADMIN')">
							<input type="button" value="변경" class="bt_change popup1_opener">
						</sec:authorize>
						<input type="hidden" value="3" name="display"/>
						<input type="hidden" value="${current.id }" name="menuId"/>
					</div>
				</div>
				<div id="contentsTitle">
					<h2>${current.name }</h2>
					<ul>
						<c:forEach items="${tabs }" var="item">
							<li <c:if test="${item.menuNum eq current.menuNum}">class="on"</c:if>>
								<a href="${item.url }${item.id}">${item.name }<span>(${item.total })</span></a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<c:if test="${paging.totalCount gt 0 }">
					<div id="contentsSearch">
						<div>
							<c:if test="${not empty paging.query}">
								<div class="text">[${paging.query}] 검색 결과입니다.</div>
							</c:if>
							<div class="search_area">
								<form action="<c:url value="${listUrl }"/>">
									<input type="text" placeholder="검색어 입력" name="query" <c:if test="${not empty paging.query}">value="${paging.query}"</c:if>>
									<input type="hidden" name="pageNo" value="${paging.pageNo }"/>
									<input type="button" value="검색" onclick="javascript:search(this.form);">
								</form>
							</div>
						</div>
					</div>
				</c:if>
				<div id="products_list_wrap">
					<ul class="container">
						<c:forEach items="${products}" var="item" varStatus="step">
							<li class="product">
								<a href="<c:url value="/products/detail/${item.id }"/>" class="image" style="background-image: url('/picture/${item.representImage}');">사진</a>  
								<!-- <p>[${item.primaryId}] ${item.size }</p> -->
								<a href="<c:url value="/products/detail/${item.id }"/>" class="name">${item.name }</a>
								<sec:authorize access="hasRole('ADMIN')">
									<div class="bt_move_wrap">
										<input type="hidden" name="id" value="${item.id }"/>
										<input type="hidden" name="orderNum" value="${item.orderNum }"/>
										<input type="hidden" name="menuId" value="${item.menuId }"/>
										<c:choose>
											<c:when test="${step.first }">
												<input type="button" value="이전" class="bt_move prev off">
											</c:when>
											<c:otherwise>
												<input type="button" value="다음" class="bt_move prev" onclick="javascript:movePrev(this);">	
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${step.last }">
												<input type="button" value="이전" class="bt_move next off">
											</c:when>
											<c:otherwise>
												<input type="button" value="다음" class="bt_move next" onclick="javascript:moveNext(this);">
											</c:otherwise>
										</c:choose>
									</div>
								</sec:authorize>
							</li>
						</c:forEach>
					</ul>
					<a class="pagination__next" href="${listUrl }/2"/>
				</div>
				<c:if test="${fn:length(products) eq 0 }">
					<c:choose>
						<c:when test="${not empty paging.query}">
							<div id="products_list_wrap" class="none">
								검색된 상품이 없습니다.
								<sec:authorize access="hasRole('ADMIN')">
									<div class="bt_wrap">
										<a href="<c:url value="/products/add"/>" class="bt1 on">등록</a>
									</div>
								</sec:authorize>
							</div>
						</c:when>
						<c:otherwise>
							<div id="products_list_wrap" class="none">
								등록된 상품이 없습니다.
							</div>
						</c:otherwise>
					</c:choose>		
				</c:if>
				
				<div id="paging" class="page">
					<a href="javascript:pageGo(${paging.firstPageNo})" class="bt first">맨 처음 페이지로 가기</a>
					<a href="javascript:pageGo(${paging.prevPageNo})" class="bt prev">이전 페이지로 가기</a>
					<c:choose>
						<c:when test="${paging.finalPageNo eq 0}">
							<a href="javascript:pageGo(1)" class="num on">1</a>
						</c:when>
						<c:otherwise>
							<c:forEach begin="${paging.startPageNo }" end="${paging.endPageNo}" varStatus="loop">
								<a href="javascript:pageGo(${loop.current })" class="num <c:if test="${loop.current eq paging.pageNo }">on</c:if>">
								${loop.current }
								</a>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					<a href="javascript:pageGo(${paging.nextPageNo})" class="bt next">다음 페이지로 가기</a>
					<a href="javascript:pageGo(${paging.endPageNo})" class="bt last">마지막 페이지로 가기</a>
				</div>
				<sec:authorize access="hasRole('ADMIN')">
				<div id="products_list_wrap">
					<div class="bt_wrap">
						<a href="<c:url value="/products/add/${current.menuNum }"/>" class="bt1 on">등록</a>
					</div>
				</div>
				</sec:authorize>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>