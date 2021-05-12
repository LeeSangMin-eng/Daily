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
    <form action="register.jsp" method="post">
    <div id="logo" onclick="location.href='../../index.jsp'">daily</div>
    <div id="signUp">
        <div id="title">회원가입</div>
        <div id="signUpform">
            <input id="id" type="text" name="id" placeholder="아이디" onfocus="this.placeholder=''" onblur="this.placeholder='아이디'">
            <input id="password" type="password" name="password" oninput="isSamepwd(); correctPwd();" placeholder="비밀번호(영문, 숫자, 특문, 중 2개 조합 10자 이상)" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호(영문, 숫자, 특문, 중 2개 조합 10자 이상)'">
            <input id="passwordCheck" type="password" name="pwdCheck" oninput="isSamepwd()" placeholder="비밀번호체크" onfocus="this.placeholder=''" onblur="this.placeholder='비밀번호체크'" >
        </div>
    </div>
    <button type="submit" id="create">계정생성</button>  
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

    function isSamepwd() {
        var pwd= document.getElementById("password");
        var Check= document.getElementById("passwordCheck")
        if(Check.value !="" && pwd.value != ""){
            if(Check.value == pwd.value){
                Check.style.backgroundImage= "url(../../css/daily/checked.jpg)";
            }

            else{
                Check.style.backgroundImage= "none";
            }
        }
        else if(Check.value =="" || pwd.value == ""){
                Check.style.backgroundImage= "none";
        }
    }
    </script>  
</body>
</html>