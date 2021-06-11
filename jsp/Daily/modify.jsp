<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page import="java.io.*, java.util.Date, java.util.Enumeration" %> 
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    String sql = "";
    ResultSet rs = null;

    request.setCharacterEncoding("utf-8");
    String preDate = request.getParameter("date");
    String preStart = request.getParameter("start");
    String preEnd = request.getParameter("end");
    String preContent = request.getParameter("toDo");
%>

<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>
    <link rel="stylesheet" href="../../css/daily/select.css">

</head>
<body>
    <form action="modifyHandle.jsp" method="post" onsubmit="return isDone()">
        <div id="main">
            <input type="date" id="date" name="date" value="<%=preDate%>">
            <input type="time" id="start" name="start" value="<%=preStart%>"> 
            <input type="time" id="end" name="end" value = "<%=preEnd%>">
            <input type="text" id="content" name="content" value = "<%=preContent%> "placeholder="내용을 작성해주세요.">
            <button type="submit" name="btn" id="btn" value="add">수정하기</button>
        </div>
        <input type="hidden" name="preDate" value="<%=preDate%>">
        <input type="hidden" name="preStart" value="<%=preStart%>">
        <input type="hidden" name="preEnd" value="<%=preEnd%>">
        <input type="hidden" name="preToDo" value="<%=preContent%>">

    </form>
    
    <script>
    function isDone() {                             // 입력 폼에 입력되지 않은 값이 있는지 체크
        var date = document.getElementById("date");
        var start = document.getElementById("start");
        var end = document.getElementById("end");
        var content = document.getElementById("content");

        if(date.value == "" || start.value =="" || end.value =="" || content.value =="") {
            return false;
        }
        else return true;
    }
    </script>
</body>
</html>