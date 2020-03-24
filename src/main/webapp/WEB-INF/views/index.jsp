<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="su" uri="/WEB-INF/tlds/customTags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>다다벽돌</title>
    <style>
        * { margin: 0; padding: 0; }
        #tab { padding: 20px 0; border-bottom: 1px solid #000; text-align: center; }
        #tab input[type="button"] { display: inline-block; margin: 0 5px; padding: 10px 20px; border: 0; border-radius: 100px; background: #ddd; font-size: 14px; cursor: pointer; }
        #tab input[type="button"]:focus { outline: none; }
        #tab input[type="button"].on { background: #5e4736; color: #fff; }
        #cont { background: #ddd; text-align: center; }
        #cont > div { display: none; }
        #cont > div:first-child { display: block; }
        #cont img { width: 100%; }
    </style>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script>
        $(function(){
            $("#tab > input").click(function(){
                var idx = $(this).index();
                $("#tab > input").removeClass("on");
                $(this).addClass("on");
                $("#cont > div").hide();
                $("#cont > div:eq("+ idx +")").show();
            });
        });
    </script>
</head>
<body>
    <div id="wrap">
        <div id="tab">
            <input type="button" value="시안1" class="on">
            <input type="button" value="시안2">
        </div>
        <div id="cont">
            <div>
                <img src="<c:url value="/resources/img/img1.png"/>" alt="시안1">
            </div>
            <div>
                <img src="<c:url value="/resources/img/img2.png"/>" alt="시안2">
            </div>
        </div>
    </div>
</body>
</html>