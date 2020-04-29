<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
					<h2>${boardName }</h2>
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
				<div class="board_list board_list_typeB">
					<ul class="list">
						<li class="head">
							<div class="num"><spring:message code="board.number"/></div>
							<div class="title"><spring:message code="board.title"/></div>
							<div class="writer"><spring:message code="board.user"/></div>
							<div class="date"><spring:message code="board.date"/></div>
							<div class="file"><spring:message code="board.attachment"/></div>
							<div class="view"><spring:message code="board.show"/></div>
						</li>
						<c:forEach items="${list }" var="item" varStatus="sts">
							<li>
								<div class="num">${paging.totalCount - (sts.index) - (paging.pageSize * (paging.pageNo-1))}</div>
								<div class="title">
									<a href="<c:url value="${viewUrl }${item.id }"/>">
										<c:choose>
											<c:when test="${locale.language eq 'en' }">
												${item.title_en }
											</c:when>
											<c:otherwise>
												${item.title }
											</c:otherwise>
										</c:choose>
										<c:if test="${item.replyCnt > 0 }">(${item.replyCnt })</c:if></a>
								</div>
								<div class="writer">${item.writerName }</div>
								<div class="date">
									<fmt:formatDate value="${item.wdate}" pattern="yyyy-MM-dd" />
								</div>
								<div class="file">${item.fileCnt }</div>
								<div class="view">${item.viewCount }</div>
							</li>
						</c:forEach>
						
					</ul>
					<div class="page">
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
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<div class="bt_wrap">
							<input type="button" class="bt1 bt_write popup_password_opener" value="<spring:message code="board.write"/>" onclick="window.location.replace('${writeUrl}')">
						</div>
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>