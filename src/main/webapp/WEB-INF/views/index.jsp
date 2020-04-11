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
					<div class="idx_main">
						<a href="#" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
						<a href="#" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
						<a href="#" class="item" style="background-image: url(/resources/img/temp/1.png);">제품</a>
					</div>
				</div>
				<div class="idx_products_wrap">
					<strong>Products</strong>
					<div class="idx_products">
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">점토벽돌</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">타일벽돌</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">고벽돌</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화산석</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">화강석</a>
						</div>
						<div class="item">
							<a href="#" class="image" style="background-image: url(/resources/img/temp/2.png);">사진</a>
							<a href="#" class="name">바닥벽돌</a>
						</div>
					</div>
				</div>
				<div class="idx_insta_wrap">
					<strong>Instagram</strong>
					<div class="idx_insta">
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
						<a href="#" style="background-image: url(/resources/img/temp/3.png);">사진</a>
					</div>
				</div>
				<!-- 목록 페이지 상단 -->
				<div id="contentsTop">
					<div style="background-image: url(/resources/img/temp/4.png);"></div>
				</div>
				<div id="contentsTitle">
					<h2>점토벽돌</h2>
					<ul>
						<li class="on"><a href="#">점토벽돌<span>(60)</span></a></li>
						<li><a href="#">전돌벽돌<span>(54)</span></a></li>
						<li><a href="#">수입벽돌<span>(21)</span></a></li>
						<li><a href="#">수공예벽돌<span>(34)</span></a></li>
					</ul>
				</div>
				<div id="contentsSearch">
					<div>
						<div class="text">[유로] 검색 결과입니다.</div>
						<div class="search_area">
							<form>
								<input type="text" placeholder="검색어 입력">
								<input type="button" value="검색">
							</form>
						</div>
					</div>
				</div>
				<div id="products_list_wrap">
					<ul>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/5.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
						<li>
							<a href="#" class="image" style="background-image: url(/resources/img/temp/6.png);">사진</a>
							<p>[CT-001] 500 x 95 x 40T 1㎡ = 33장</p>
							<a href="#" class="name">유로화이트</a>
						</li>
					</ul>
				</div>
				<!-- 상세 페이지 상단 -->
				<div id="contentsTitle">
					<h2>레드미장</h2>
				</div>
				<!-- 상세 페이지 슬라이드 -->
				<div class="detail_slider_wrap">
					<div class="detail_slider">
						<div class="item" style="background-image: url(/resources/img/temp/7.png);">사진</div>
						<div class="item" style="background-image: url(/resources/img/temp/8.png);">사진</div>
						<div class="item" style="background-image: url(/resources/img/temp/9.png);">사진</div>
						<div class="item" style="background-image: url(/resources/img/temp/10.png);">사진</div>
						<div class="item" style="background-image: url(/resources/img/temp/11.png);">사진</div>
					</div>
					<div class="detail_slider_pager">
						<a href="" data-slide-index="0"><img src="/resources/img/temp/7.png" alt="사진" class="item"></a>
						<a href="" data-slide-index="1"><img src="/resources/img/temp/8.png" alt="사진" class="item"></a>
						<a href="" data-slide-index="2"><img src="/resources/img/temp/9.png" alt="사진" class="item"></a>
						<a href="" data-slide-index="3"><img src="/resources/img/temp/10.png" alt="사진" class="item"></a>
						<a href="" data-slide-index="4"><img src="/resources/img/temp/11.png" alt="사진" class="item"></a>
					</div>
				</div>
				<!-- 상세 페이지 제품정보 -->
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
								<td>레드미장</td>
								<th>카테고리</th>
								<td>점토벽돌</td>
							</tr>
							<tr>
								<th>제품번호</th>
								<td>EH_D20129</td>
								<th>규격</th>
								<td>(190 x 90 x 57T ) 1㎡ = 75장</td>
							</tr>
							<tr>
								<th>포장</th>
								<td>파렛트 포장</td>
								<th>배송</th>
								<td>화물</td>
							</tr>
						</tbody>
					</table>
					<div class="bt_wrap">
						<a href="#" class="bt1">문의하기</a>
						<a href="#" class="bt1 on">목록</a>
					</div>
				</div>
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