<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
    <form action="addHandle.jsp" method="post" onsubmit="return isDone()">
        <div id="main">
            <input type="date" id="date" name="date">
            <input type="time" id="start" name="start"> 
            <input type="time" id="end" name="end">
            <input type="text" id="content" name="content" placeholder="내용을 작성해주세요.">
            <button type="submit" name="btn" id="btn" value="add">추가하기</button>
        </div>
    </form>
    
    <script>
    function isDone() {                               // 입력 폼에 입력되지 않은 값이 있는지 체크
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