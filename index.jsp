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
    Cookie[] cookies = request.getCookies();           // 자동로그인을 위해 쿠키값 가져오기
    String rId = (String)session.getAttribute("id");   // 현재 로그인한 상태인지 확인

    if(cookies != null){                               
        for(Cookie c : cookies){
            if(c.getName().equals("autoId")){          // 로그인 유지 버튼이 체크 됐는지 확인
                session.setAttribute("id",c.getValue());
                rId= (String)session.getAttribute("id");
            }
        }       
    }

    if(rId != null){                                   // 이미 로그인한 상태라면 메인페이지로 이동
        response.sendRedirect("./jsp/Daily/Daily.jsp");
    }


%>

    <div id="main">
        <div id="logo">daily</div>
        <button id="signUp" onclick="location.href='jsp/Daily/SignUp.jsp'">회원가입</button>
        <button id="signIn" onclick="location.href='jsp/Daily/SignIn.jsp'">로그인</button>
    </div>
    
</body>
</html>