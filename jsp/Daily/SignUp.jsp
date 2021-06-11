<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>
    <link rel="stylesheet" href="../../css/daily/SignUp.css">

</head>
<body>

<%
    String rId = (String)session.getAttribute("id");  // 이미 로그인한 상태라면 메인페이지로 이동
    if(rId != null){
        response.sendRedirect("Daily.jsp");
    }
%>

    <div id="logo" onclick="location.href='../../index.jsp'">daily</div>
    <form action="register.jsp" method="post" onsubmit="return isDone()">
    <div id="signUp">
        <div id="title">회원가입</div>
        <div id="signUpform">
            <input id="id" type="text" name="id" placeholder="아이디" onfocus="this.placeholder=''" onblur="this.placeholder='아이디'">
            <input id="password" type="password" name="password" oninput="isSamepwd(); correctPwd();" placeholder="비밀번호(영문, 숫자, 특문, 중 2개 조합 10자 이상)" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호(영문, 숫자, 특문, 중 2개 조합 10자 이상)'">
            <input id="passwordCheck" type="password" name="pwdCheck" oninput="isSamepwd()" placeholder="비밀번호체크" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호체크'" >
        </div>
    </div>
    <div id="alram"></div>
    <input type="submit" id="create" value="계정생성">
    </form>

    <script>
    function correctPwd() {                           // 패스워드 조건에 맞게 입력했는지 체크
        var pwd = document.getElementById("password")
        var value = pwd.value;
        var number = /[0-9]/;
        var str = /[A-Za-z]/;
        var specialStr = /[~!@#$%^&*()_+|<>?:{}]/;;

        if((number.test(value) && str.test(value) || number.test(value) && specialStr.test(value) || str.test(value) && specialStr.test(value)) && value.length >=10){
            pwd.style.backgroundImage = "url(../../css/daily/checked.jpg)";
            return true;
        }
        else{
            pwd.style.backgroundImage = "none";
            return false;
        }
    }

    function isSamepwd() {                              // 비밀번호와 비밀번호 확인이 일치하는지 체크
        var pwd= document.getElementById("password");
        var Check= document.getElementById("passwordCheck")
        if(Check.value !="" && pwd.value != ""){
            if(Check.value == pwd.value){
                Check.style.backgroundImage= "url(../../css/daily/checked.jpg)";
                return true;
            }

            else{
                Check.style.backgroundImage= "none";
                return false;
    
            }
        }
        else if(Check.value =="" || pwd.value == ""){
                Check.style.backgroundImage= "none";
                return false;
        }
    }

    function isDone() {                                  // 입력 폼에 입력하지 않은 부분이 있는지 체크
        var id = document.getElementById("id");
        var password = document.getElementById("password");
        var pwdCheck = document.getElementById("passwordCheck");
        var alram = document.getElementById("alram");

        if(id.value == ""){
            alram.innerText = "아이디를 입력해주세요.";
            return false;
        }

        else if(password.value == ""){
            alram.innerText = "비밀번호를 입력해주세요.";
            return false;
        }

        else if(pwdCheck.value  == ""){
            alram.innerText = "비밀번호 확인을 입력해주세요.";
            return false;
        }

        else if(!correctPwd()){
            alram.innerText = "비밀번호가 조건에 맞지 않습니다.";
            return false;
        }

        else if(!isSamepwd()){
            alram.innerText = "비밀번호가 일치하지 않습니다.";
            return false;
        }

        else{
            return true;
        }
    }
    </script>  
</body>
</html>