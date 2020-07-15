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
function search(form){
	$(form).submit();
}
function pageGo(pageNo){
	$("#search-form input[name='pageNo']").val(pageNo);
	$("#search-form").submit();
}
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
					<h2>상품검색</h2>
				</div>
				<div id="contentsSearch">
					<div>
						<c:if test="${not empty paging.query}">
							<div class="text">[${paging.query}] 검색 결과입니다.</div>
						</c:if>
						<div class="search_area">
							<form id="search-form" action="<c:url value="${listUrl }"/>">
								<input type="text" placeholder="검색어 입력" name="query" <c:if test="${not empty paging.query}">value="${paging.query}"</c:if>>
								<input type="hidden" name="pageNo" value="${paging.pageNo }"/>
								<input type="button" value="검색" onclick="javascript:search(this.form);">
							</form>
						</div>
					</div>
				</div>
				<div id="products_list_wrap">
					<ul>
						<c:forEach items="${list}" var="item" varStatus="step">
							<li>
								<a href="<c:url value="/products/detail/${item.id }"/>" class="image" style="background-image: url('/picture/${item.representImage}');">사진</a>  
								<p>[${item.primaryId}] ${item.size }</p>
								<a href="<c:url value="/products/detail/${item.id }"/>" class="name">${item.name }</a>
							</li>
						</c:forEach>
					</ul>
				</div>
				<c:if test="${fn:length(list) eq 0 }">
					<c:choose>
						<c:when test="${not empty paging.query}">
							<div id="products_list_wrap" class="none">
								검색된 상품이 없습니다.
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
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>