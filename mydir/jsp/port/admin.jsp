<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./index.css">
</head>
<body>
<%
    String id="";
    String password = (String)session.getAttribute("pwd");
    String loginDone = (String)session.getAttribute("loginDone");
    String isAdmin = (String)session.getAttribute("isAdmin");
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("memberId")){
                id=c.getValue();
            }
            else{
                id= (String)session.getAttribute("_id");
            }
        }
    }
    
%>
<script>
    if("<%=isAdmin%>" == null){
        alert("관리자만 볼 수 있습니다.");
        location.href = "index.jsp";
    }

    console.log("<%=id%>");
    console.log("<%=password%>");
</script>


 
</body>
</html>