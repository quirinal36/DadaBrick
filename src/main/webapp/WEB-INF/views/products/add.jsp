<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="today" class="java.util.Date" />
<fmt:formatDate value="${today}" pattern="yyyyMMdd-HHmm" var="nowDate"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>${title }</title>
<c:import url="/inc/head"></c:import>
<script src="<c:url value="/resources/js/products.js"><c:param name="dt" value="${nowDate }"/></c:url>"></script>
<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="https://code.jquery.com/ui/1.12.0/jquery-ui.min.js"></script> 
<script type="text/javascript">
$(document).ready(function(){
	$("#det-image").sortable({
		paceholder:"highlights"
	});
	$("#det-image").on("sortupdate", function(event, ui){
		var productOrder = $(this).sortable('toArray');
		var positions = productOrder.join(';');
		
		var url = "/products/edit/sort";
		var param = "ids="+positions;
		
		$.ajax({
			url: url,
			data: param,
			type: 'POST',
			dataType: 'json'
		}).done(function(json){
			console.log(json);	
		});
	});
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
					<h2>
					<c:choose>
						<c:when test="${product.id gt 0 }">제품 수정</c:when>
						<c:otherwise>제품 등록</c:otherwise>
					</c:choose>
					</h2>
				</div>
				<!-- 상세 페이지 제품정보 등록 -->
				<div id="products_info_wrap">
					<c:choose>
						<c:when test="${product.id gt 0}">
							<c:set var="actionUrl" value="/products/edit"/> 
						</c:when>
						<c:otherwise>
							<c:set var="actionUrl" value="/products/add"/>
						</c:otherwise>
					</c:choose> 
					<form id="admin-add-form" method="POST" action="${actionUrl }">
					
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
								<td>
									<input type="text" placeholder="제품명 입력" class="ipt1 w80"
										name="name" required value="${product.name }">
								</td>
								<th>카테고리</th>
								<td>
									<select class="select1" name="menuId">
										<c:forEach items="${category }" var="item">
												<c:set var="menu" value="${item.value }"></c:set>
												<c:choose>
													<c:when test="${menu.id eq currentMenuId }"><option value="${menu.id }" selected>${menu.name }</option></c:when>
													<c:otherwise>
														<c:if test="${menu.id lt 70 }">
															<option value="${menu.id }">${menu.name }</option>
														</c:if>
													</c:otherwise>
												</c:choose>
											
										</c:forEach>
									</select>
								</td>
							</tr>
							<tr>
								<th>제품번호</th>
								<td>
									<input type="text" placeholder="제품번호 입력" class="ipt1 w80"
										name="primaryId" value="${product.primaryId }">
								</td>
								<th>규격</th>
								<td>
									<input type="text" placeholder="규격 입력" class="ipt1 w80"
										name="size" value="${product.size }">
								</td>
							</tr>
							<tr>
								<th>포장</th>
								<td>
									<input type="text" placeholder="포장 입력" value="파렛트 포장" class="ipt1 w80"
										name="packaging" value="${product.packaging }">
								</td>
								<th>배송</th>
								<td>
									<input type="text" placeholder="배송 입력" value="화물" class="ipt1 w80"
										name="delivery" value="${product.delivery }">
								</td>
							</tr>
							<tr>
								<th>색상</th>
								<td>
									<input type="text" placeholder="색상 입력" class="ipt1 w80"
										name="color" value="${product.color }">
								</td>
								<th>재질</th>
								<td>
									<input type="text" placeholder="재질 입력" class="ipt1 w80"
										name="material" value="${product.material }">
								</td>
							</tr>
							<tr>
								<th>대표사진</th>
								<td colspan="3" id="dropzone-img-rep">
									<c:choose>
										<c:when test="${empty product.representImage or product.representImage eq 0}">
											<input id="image-upload-btn" type="file" accept="image/*" value="등록" class="bt_imgUpload" data-url="<c:url value="/upload/sized/image"/>">
	                                    </c:when>
	                                    <c:otherwise>
	                                    	<input id="image-upload-btn" type="file" accept="image/*" value="등록" class="bt_imgUpload" data-url="<c:url value="/upload/sized/image"/>" style="display:none;">
	                                    </c:otherwise>
									</c:choose>
									
                                    <ul id="rep-image" class="imgUpload_list"> 
                                    	<c:if test="${product.representImage > 0}">
                                    		<li id="${product.representImage }" style="background-image:url('/picture/${product.representImage }')">
                                    			<input type="button" class="bt_imgDelete" value="삭제" onclick="delImageClick(this);"/>
                                    			<input type="hidden" name="representImage" value="${product.representImage }"/>
                                    		</li>
                                    	</c:if>
                                    </ul>
                                    <div id="progress_rep_image" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
								    	<div class="progress-bar" style="width: 0%;" ></div>
								    </div>
								</td>
							</tr>
							<tr>
								<th>상세사진</th>
								<td colspan="3" id="dropzone-img-det">
									<input id="detail-upload-btn" type="file" accept="image/*" value="등록" class="bt_imgUpload" data-url="<c:url value="/upload/sized/image"/>" multiple>
									<ul id="det-image" class="imgUpload_list">
										<c:forEach items="${detailPhotoList }" var="item">
											<li id="${item.id }" style="background-image:url('${item.url }')">
                                    			<input type="button" class="bt_imgDelete" value="삭제" onclick="delImageClick(this);"/>
                                    			<input type="hidden" name="detImage" value="${item.id }"/>
                                    		</li>
										</c:forEach>
									</ul>
									사진 삭제와 순서 변경은 저장 버튼을 누르지 않아도 즉시 적용됩니다.
								</td>
							</tr>
							<tr>
								<th>동영상</th>
								<td colspan="3" id="dropzone-img-det">
									<a href="javascript:void(0);" class="bt1 on" id="openModalBtn">추가하기</a>
									<div id="youtube-thumbnails" class="youtube-thumbnails-container"></div>
								</td>
							</tr>	
						</tbody>
					</table>
					<div class="bt_wrap">
						<c:choose>
							<c:when test="${product.id gt 0}">
								<input type="hidden" name="id" value="${product.id }"/>
								<input type="hidden" name="orderNum" value="${product.orderNum }"/>
								<a href="javascript:submitProduct();" class="bt1 on">저장</a>
							</c:when>
							<c:otherwise>
								<a href="javascript:submitProduct();" class="bt1 on">등록</a>
							</c:otherwise>
						</c:choose>
						
						<a href="javascript:window.history.back();" class="bt1">취소</a>
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>

<!-- Modal Overlay -->
<div id="modalOverlay" class="modal-overlay">
    <div class="modal-container">
        <div class="modal-content">
            <div class="youtube-input-container">
                <input type="text" id="youtubeUrl" class="youtube-url-input" placeholder="YouTube URL을 입력하세요">
                <button class="ok-button" id="confirmYoutubeBtn">확인</button>
            </div>
            
            <div class="preview-container" id="youtubePreview">
                <div class="preview-text">미리보기</div>
                <div class="preview-placeholder">YouTube URL을 입력하면 미리보기가 표시됩니다.</div>
            </div>
            
            <div class="modal-buttons">
                <button class="cancel-button" id="cancelBtn">취소</button>
            </div>
        </div>
    </div>
</div>

<script>
// YouTube Modal functionality
const openModalBtn = document.getElementById('openModalBtn');
const modalOverlay = document.getElementById('modalOverlay');
const cancelBtn = document.getElementById('cancelBtn');
const youtubeUrlInput = document.getElementById('youtubeUrl');
const confirmYoutubeBtn = document.getElementById('confirmYoutubeBtn');
const youtubePreview = document.getElementById('youtubePreview');
const youtubeThumbnails = document.getElementById('youtube-thumbnails');

// Open modal
openModalBtn.addEventListener('click', function() {
    modalOverlay.style.display = 'block';
    youtubeUrlInput.value = '';
    youtubePreview.querySelector('.preview-placeholder').style.display = 'block';
    youtubePreview.querySelector('iframe')?.remove();
});

// Close modal (cancel button)
cancelBtn.addEventListener('click', function() {
    modalOverlay.style.display = 'none';
});

// Close modal when clicking outside
modalOverlay.addEventListener('click', function(event) {
    if (event.target === modalOverlay) {
        modalOverlay.style.display = 'none';
    }
});

// Handle YouTube URL input
youtubeUrlInput.addEventListener('input', function() {
    const url = this.value.trim();
    if (url) {
        const videoId = extractYoutubeId(url);
		console.log("videoId:" +videoId);
        if (videoId) {
            updatePreview(videoId);
        }
    }
});

// Confirm YouTube URL
confirmYoutubeBtn.addEventListener('click', function() {
    const url = youtubeUrlInput.value.trim();
    if (url) {
        const videoId = extractYoutubeId(url);
		//console.log("videoId:" +videoId);
        if (videoId) {
            addYoutubeThumbnail(videoId);
            modalOverlay.style.display = 'none';
        }
    }
});

// Extract YouTube video ID from URL
function extractYoutubeId(url) {
    // Handle both youtu.be/ and youtube.com/watch?v= formats
    const regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#&?]*).*/;
    const match = url.match(regExp);
	//console.log("match:" + match);

    return (match && match[7].length === 11) ? match[7] : null;
}

// Update preview
function updatePreview(videoId) {
    const previewPlaceholder = youtubePreview.querySelector('.preview-placeholder');
    previewPlaceholder.style.display = 'none';
    
    // Remove existing preview content
    youtubePreview.querySelector('iframe')?.remove();
    youtubePreview.querySelector('img')?.remove();
    
    // Add thumbnail image
    const thumbnail = document.createElement('img');
    thumbnail.src = 'https://img.youtube.com/vi/' + videoId +'/hqdefault.jpg';
    thumbnail.alt = 'YouTube Thumbnail';
    thumbnail.style.width = '100%';
    thumbnail.style.maxWidth = '480px'; // 적절한 크기로 조정
    
    youtubePreview.appendChild(thumbnail);
}

// Add YouTube thumbnail (마우스오버 효과 제거된 버전)
function addYoutubeThumbnail(videoId) {
    const thumbnailContainer = document.createElement('div');
    thumbnailContainer.className = 'youtube-thumbnail';
    thumbnailContainer.dataset.videoId = videoId;
    
    const thumbnail = document.createElement('img');
    thumbnail.src = 'https://img.youtube.com/vi/' + videoId +'/hqdefault.jpg';
    thumbnail.alt = 'YouTube Thumbnail';
    
    const deleteBtn = document.createElement('button');
    deleteBtn.className = 'bt_imgDelete';
    deleteBtn.textContent = '삭제';
    deleteBtn.onclick = function() {
        thumbnailContainer.remove();
    };
    
    // Add hidden input for videoId
    const hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.value = videoId;
    hiddenInput.name = 'videoId';
    
    thumbnailContainer.appendChild(thumbnail);
    thumbnailContainer.appendChild(deleteBtn);
    thumbnailContainer.appendChild(hiddenInput);  // Add hidden input to container
    youtubeThumbnails.appendChild(thumbnailContainer);
}
</script>
</body>
</html>