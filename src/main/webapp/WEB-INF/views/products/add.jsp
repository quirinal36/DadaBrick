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
			<div id="contentsPrint">
				<!-- 상세 페이지 상단 -->
				<div id="contentsTitle">
					<h2>제품 등록</h2>
				</div>
				<!-- 상세 페이지 제품정보 등록 -->
				<div class="product_info_wrap">
					<table class="tbl1">
						<colgroup>
							<col width="12%">
							<col width="38%">
							<col width="12%">
							<col width="38%">
						</colgroup>
						<tbody>
							<tr>
								<th>제품명</th>
								<td><input type="text" placeholder="제품명 입력" class="ipt1 w80"></td>
								<th>카테고리</th>
								<td>
									<select class="select1">
										<option>점토벽돌</option>
										<option>부터</option>
										<option>인터노킹</option>
										<option>까지</option>
									</select>
								</td>
							</tr>
							<tr>
								<th>제품번호</th>
								<td><input type="text" placeholder="제품번호 입력" class="ipt1 w80"></td>
								<th>규격</th>
								<td><input type="text" placeholder="규격 입력" class="ipt1 w80"></td>
							</tr>
							<tr>
								<th>포장</th>
								<td><input type="text" placeholder="포장 입력" value="파렛트 포장" class="ipt1 w80"></td>
								<th>배송</th>
								<td><input type="text" placeholder="배송 입력" value="화물" class="ipt1 w80"></td>
							</tr>
							<tr>
								<th>대표사진</th>
								<td colspan="3">
									<ul class="imgUpload_list">
										<li>
											<input type="button" value="등록" class="bt_imgUpload">
										</li>
									</ul>
								</td>
							</tr>
							<tr>
								<th>상세사진</th>
								<td colspan="3">
									<ul class="imgUpload_list">
										<li style="background-image: url(/resources/img/temp/7.png);">
											<input type="button" value="삭제" class="bt_imgDelete">
										</li>
										<li style="background-image: url(/resources/img/temp/10.png);">
											<input type="button" value="삭제" class="bt_imgDelete">
										</li>
										<li style="background-image: url(/resources/img/temp/11.png);">
											<input type="button" value="삭제" class="bt_imgDelete">
										</li>
										<li>
											<input type="button" value="등록" class="bt_imgUpload">
										</li>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="#" class="bt1 on">등록</a>
						<a href="#" class="bt1">취소</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
</body>
</html>