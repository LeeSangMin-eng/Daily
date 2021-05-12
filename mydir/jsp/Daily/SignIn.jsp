<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>
    <link rel="stylesheet" href="../../css/daily/SignIn.css">

</head>
<body>

<% 
    String Id = null;
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("memberId")){
                Id = c.getValue();

            }
        }
    }
%>
    
    <div id="logo" onclick="location.href='../../index.jsp'">daily</div>
    <form action="login.jsp" method="post">
    <div id="signIn">
        <div id="signInDiv">
            <div id="title">로그인</div>
            <label id="autoLogin">로그인 상태 유지<input type="checkbox" name="autoLogin" id="check" onclick="isChecked()"></label>
        </div>
        <div id="signInform">
            <%if(Id == null) {%>
            <input id="id" type="text" placeholder="아이디" name="id" onfocus="this.placeholder=''" onblur="this.placeholder='아이디'">
            <%} else{%>
            <input id="id" type="text" value="<%=Id%>" name="id" placeholder="아이디" onfocus="this.placeholder=''" onblur="this.placeholder='아이디'">
            <% } %>
            <input id="password" type="password" name="password" oninput="correctPwd();" placeholder="비밀번호(영문, 숫자, 특문, 중 2개 조합 10자 이상)" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호(영문, 숫자, 특문, 중 2개 조합 10자 이상)'">
        </div>
    </div>
    <button id="login" type="submit">로그인</button>
    </form>  


    <script>

    function correctPwd() {
        var pwd = document.getElementById("password")
        var value = pwd.value;
        var number = /[0-9]/;
        var str = /[A-Za-z]/;
        var specialStr = /[~!@#$%^&*()_+|<>?:{}]/;;

        if((number.test(value) && str.test(value) || number.test(value) && specialStr.test(value) || str.test(value) && specialStr.test(value)) && value.length >=10){
            pwd.style.backgroundImage = "url(../../css/daily/checked.jpg)";
        }
        else{
            pwd.style.backgroundImage = "none";
        }
    }

    function isChecked() {
        var Check = document.getElementById("check");
        var text = document.getElementById("autoLogin");

        if(Check.checked == false){
            text.style.color = "rgba(134, 134, 134, 0.747)";
        }
        else{
            text.style.color = "#00B0F0";
        }
    }
    </script>  
</body>
</html>