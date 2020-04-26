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
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div id="containerWrap">
		<div id="container">
			<div id="contentsPrint">
				<!-- 목록 페이지 상단 -->
				<div id="contentsTop">
					<div style="background-image: url(/resources/img/temp/4.png);"></div>
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
				<div id="products_list_wrap">
					<ul>
						<c:forEach items="${products}" var="item" varStatus="step">
							<li>
								<a href="<c:url value="/products/detail/${item.id }"/>" class="image" style="background-image: url('/picture/${item.representImage}');">사진</a>  
								<p>[${item.primaryId}] ${item.size }</p>
								<a href="<c:url value="/products/detail/${item.id }"/>" class="name">${item.name }</a>
								<div class="bt_move_wrap">
									<c:choose>
										<c:when test="${step.first }">
											<input type="button" value="이전" class="bt_move prev off">
										</c:when>
										<c:otherwise>
											<input type="button" value="다음" class="bt_move prev">	
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${step.last }">
											<input type="button" value="이전" class="bt_move next off">
										</c:when>
										<c:otherwise>
											<input type="button" value="다음" class="bt_move next">
										</c:otherwise>
									</c:choose>
								</div>
							</li>
						</c:forEach>
					</ul>
				</div>
				<c:if test="${fn:length(products) eq 0 }">
					<c:choose>
						<c:when test="${not empty paging.query}">
							<div id="products_list_wrap" class="none">검색된 상품이 없습니다.</div>	
						</c:when>
						<c:otherwise>
							<div id="products_list_wrap" class="none">등록된 상품이 없습니다.</div>
						</c:otherwise>
					</c:choose>		
				</c:if>
				
				
				<sec:authorize access="hasRole('ADMIN')">
					<div class="bt_wrap">
						<a href="<c:url value="/products/add"/>" class="bt1 on">등록</a>
					</div>
				</sec:authorize>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>