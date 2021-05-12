<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>
    <link rel="stylesheet" href="./css/daily/daily.css">

</head>
<body>
<% 
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
    for(Cookie c: cookies){
        if(c.getName().equals("autoId")){   
            response.sendRedirect("./jsp/Daily/Daily.jsp");
        }
    }
}
%>

    <div id="main">
        <div id="logo">daily</div>
        <button id="signUp" onclick="location.href='jsp/Daily/SignUp.jsp'">회원가입</button>
        <button id="signIn" onclick="location.href='jsp/Daily/SignIn.jsp'">로그인</button>
    </div>
    
</body>
</html>