<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="baseUrl" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html>
<head>
	<c:import url="/inc/head"></c:import>
	<link href="<c:url value="/resources/css/dropzone.css"/>" type="text/css" rel="stylesheet" />
	<script src="https://cdn.ckeditor.com/4.11.3/standard-all/ckeditor.js"></script>
	<script type="text/javascript">
	$(document).ready(function(){
		var url = $("#clearUrl").val();
		
		var isLoginUrl = $("input[name='isLoginUrl']").val();
		var loginUrl = $("input[name='loginUrl']").val();
		var redirectUrl = $("input[name='currentUrl']").val();
		$.ajax({
			url : isLoginUrl,
			type: "GET",
			dataType: 'json'
		}).done(function(json){
			if(json.result){
				
			}else{
				alert("로그인하세요.");
				window.location.replace(loginUrl +"?loginRedirect=" + redirectUrl);
			}
		});
	});
	
	function delButtonClick(button){
		var id = $(button).val();
		var btnWhich = $(button).hasClass("btn_del_img");
		if(btnWhich){
			$(".bt_del_img").each(function(index, item){
				if(id == $(item).val()){
					var url = "/delete/img/"+id;
					// console.log("delete: "+url);
					
					$.ajax({
						url : url,
						type: "POST",
						dataType : "json"
					}).done(function(json){
						console.log(json);
					});
					
					$(item).parent().remove();
					return;
				}
			});
		}else{
			$(".bt_del_file").each(function(index, item){
				if(id == $(item).val()){
					// var url = $(button).parent().find("input[name='del_url']").val();
					// console.log("delete: "+url);
					var url = "/delete/file/"+id;
					$.ajax({
						url : url,
						type: "POST",
						dataType : "json"
					}).done(function(json){
						console.log(json);
					});
					
					$(item).parent().remove();
					return;
				}
			});
		}
	}
	function replaceAll(str, searchStr, replaceStr){
		var arr = str.split(searchStr);
		return str.split(searchStr).join(replaceStr);
	}
	function editBoard(){
		var textContent = CKEDITOR.instances.editor1.getData();
		textContent = replaceAll(textContent, "&nbsp;", " ");
		textContent = replaceAll(textContent, "&", "%26");
		
		var url = $("form").attr("action");
		
		var title = $("input[name='title']").val();
		var title_en = $("input[name='title_en']").val();
		var content = textContent;
		var boardType = $("input[name='board_type']").val();
		var pictures = [];
		var files = [];
		$("#picture_ul").find(".bt_del_img").each(function(i, item){
			pictures.push($(item).val());
		});
		$("#file_ul").find(".bt_del_file").each(function(i, item){
			files.push($(item).val());
		});
		
		var param = "title="+title;
		param += "&title_en="+title_en;
		param += "&id="+ $("form").find("input[name='id']").val();
		param += "&viewCount" + $("form").find("input[name='view_count']").val();
		param += "&content="+content;
		param += "&boardType="+boardType;
		param += "&pictures="+pictures.join(",");
		param += "&files="+files.join(",");
		
		$.ajax({
			url : url,
			data: param,
			type: "POST",
			dataType : "json"
		}).done(function(json){
			if(json.result > 0){
				alert("글 수정이 완료되었습니다.");
				window.location.replace($("input[name='detailUrl']").val());
			}
		});
	}
	</script>
</head>
<body>
<div id="wrap">
	<c:import url="/inc/header"></c:import>
	<div class="container_wrap">
		<div class="container">
			<c:import url="/inc/lnb_wrap">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<c:import url="/inc/contentsTitle">
				<c:param name="id">${curMenu.id }</c:param>
			</c:import>
			<div id="contentsPrint">
				<form action="<c:url value="/board/editBoard"/>" method="post">
					<input type="hidden" name="board_type" value="${board.boardType }"/>
					<input type="hidden" name="id" value="${board.id }"/>
					<input type="hidden" name="view_count" value="${board.viewCount }"/>
					<input type="hidden" name="isLoginUrl" value="<c:url value="${authUrl }"/>"/>
					<input type="hidden" name="loginUrl" value="<c:url value="/member/login"/>"/>
					<input type="hidden" name="currentUrl" value="${current }"/>
					<input type="hidden" name="detailUrl" value="${detailUrl }"/>
					
					<div class="board_write" style="margin-top:60px;">
						<div class="board_write_title">
							<div class="title">제목</div>
							<div class="title_ipt">
								<input type="text" placeholder="제목 입력" name="title" autocomplete="off" value="${board.title }">
							</div>
							<div class="writer">작성자</div>
							<div class="writer_ipt"><input type="text" placeholder="작성자 입력" value="${board.writerName }" readonly autocomplete="off"></div>
						</div>
						<div class="board_write_cont">
							<textarea name="editor1" id="editor1" rows="30" cols="80">${board.content }</textarea>
	                        <script>
			                CKEDITOR.replace( 'editor1' ,{
			                	toolbarGroups: [
			                    ],
			                    // Remove the redundant buttons from toolbar groups defined above.
			                    removeButtons: 'Underline,Strike,Subscript,Superscript,Anchor,Styles,Specialchar,Image'
			                	,height: 630
			                });
			            	</script>
						</div>
						<div class="board_write_img">
							<dl>
								<dt>사진</dt>
								<dd>
									<!-- 사진 목록 -->
									<ul id="picture_ul">
										<c:forEach items="${photoList }" var="item">
											<li style="background-image: url(${item.url});">
												<input type="button" title="삭제" class="bt_del_img" value="${item.id }" 
													onclick="javascript:delButtonClick(this);">
											</li>
										</c:forEach>
									</ul>
									<!-- 첨부하기 버튼 -->
									<input id="imageupload" type="file" name="files[]" 
										accept="image/*" data-url="<c:url value="/upload/image"/>" multiple>
									<div id="dropzone" class="fade well" style="display:none;">Drop files here</div>
								    <div id="progress">
								        <div style="width: 0%;"></div>
								    </div>
								</dd>
							</dl>
						</div>
						<div class="board_write_file">
							<dl>
								<dt>첨부파일</dt>
								<dd>
									<!-- 첨부파일 목록 -->
									<ul id="file_ul">
										<c:forEach items="${fileList }" var="item">
											<li>
												<span>${item.name }</span>
												<input type="button" title="삭제" class="bt_del_file" value="${item.id }"
													onclick="javascript:delButtonClick(this);">
											</li>
										</c:forEach>
									</ul>
									<input id="fileupload" type="file" name="files[]" 
										data-url="<c:url value="/upload/file"/>" multiple>
									<div id="dropzone" class="fade well" style="display:none;">Drop files here</div>
								    <div id="progress">
								        <div style="width: 0%;"></div>
								    </div>
								</dd>
							</dl>
						</div>
						<div class="bt_wrap">
							<a href="javascript:void(0);" onclick="javascript:editBoard();" class="bt1 on">등록</a>
							<a href="javascript:void(0);" onClick="history.back();" class="bt1">취소</a>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<c:import url="/inc/footer"></c:import>
</div>
<script type="text/javascript">
$(document).ready(function(){
    $('#imageupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	
        	var file = data.result.file;
        	$("#picture_ul").append(
       			$("<li>").attr("style", "background-image: url(" + file.url + ");")
       				.append(
       						$("<input>").attr("type","button").attr("title","삭제").addClass("bt_del_img")
       						.attr("onclick", "delButtonClick(this);").val(file.id)
       				)
       			);

        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        },
 
        dropZone: $('#dropzone')
    });
    $('#fileupload').fileupload({
    	imageCrop: true,
        dataType: 'json',
        done: function (e, data) {
        	
        	var file = data.result.file;
            
           	$("#file_ul").append(
           		$("<li>").append(
           			$("<span>").text(file.name)
           		).append(
           			$("<input>").attr("type","button").addClass("bt_del_file").attr("title","삭제")
           				.attr("onclick", "delButtonClick(this);").val(file.id)
           		)
           	);
        },
        progressall: function (e, data) {
            var progress = parseInt(data.loaded / data.total * 100, 10);
            $('#progress .bar').css(
                'width',
                progress + '%'
            );
        },
 
        dropZone: $('#dropzone')
    });
});

</script>

<script src="<c:url value="/resources/js/jquery.ui.widget.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.iframe-transport.js"/>"></script>
<script src="<c:url value="/resources/js/jquery.fileupload.js"/>"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
</body>
</html>