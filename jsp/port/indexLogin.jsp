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
    String loginDone = (String)session.getAttribute("loginDone");
    String isAdmin= null;
    String autoLogin = null;
    if((String)session.getAttribute("isAdmin") == "Y"){
        isAdmin = "Y";
    }
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("memberId")){
                id=c.getValue();
                autoLogin = "Y";
            }
            else{
                id= (String)session.getAttribute("_id");
            }
        }
    }
%>
<script>
   //으악 왜 안돼
    
</script>
    <section id="home">
        
        <header>
            <%if(isAdmin == null) {%>
            <a href="#" id="logo"></a>
            <ul id="menu">
                <li><%=id %> 님 안녕하세요</li>
                <li><a href="./logout.jsp">Logout</a></li>
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#portfolio">Portfolio</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <%} else{ %>
            <a href="#" id="logo"></a>
            <ul id="menu">
                <li><%=id %> 님 안녕하세요</li>
                <li><a href="./admin.jsp">Admin</a></li>
                <li><a href="./logout.jsp">Logout</a></li>
                <li><a href="#home">Home</a></li>
                <li><a href="#about">About</a></li>
                <li><a href="#portfolio">Portfolio</a></li>
                <li><a href="#contact">Contact</a></li>
            </ul>
            <% } %>
        </header>
        <div>
            <h1>능력 있는 개발자가 되고 싶은<span></span></h1>
            <h1>개발자 이상민의 포트폴리오 사이트입니다.<span></span></h1>
            <input type="button" value="보러가기" id="down" onclick="location.href='#about'">
        </div>
    </section>
    <section id="about">
        <div id="aboutMe">
            <div id="aboutTitle">About Me</div>
            <ul id="aboutMain">
                <li id="aboutLeft">
                    <div id="mypicture"><img src="./css/index/my.jpg"></div>
                    <div>
                        <ul id="meDescribe">
                            <li class="index">이름</li><li>이상민</li>
                            <li class="index">생년월일</li><li>1998.05.29(24세)</li>
                            <li class="index">주소</li><li>미추홀구 용현동</li>
                            <li class="index">이메일</li><li>****@naver.com</li>
                            <li class="index">연락처</li><li>010 2262 ****</li>
                        </ul>
                    </div>
                </li>
                <li id="aboutRight">
                    <ul>
                        <li class="desTitle">지금 하는 일?</li>
                        <li class="desMain">인하대학교 컴퓨터공학과에 재학 중에 있으며, stageus에서 웹기초에 대해 배우고 있습니다.</li>
                        <li class="desTitle">배우고 싶은 것</li>
                        <li class="desMain">백엔드 부분을 깊게 배워보고 싶습니다.</li>
                    </ul>
                </li>
            </ul>
        </div>
    </section>
    <section id="portfolio">
        <div id="myPortfolio">
            <div id="portfolioTitle">My_Portfoilo</div>
            <input type="image" id="leftArrow" src="./css/index/left_arrow.png" onclick="left()">
            <div id="contents">
                <div id="view">
                    <div class="container">
                        <div class="inner">
                            <input class="myWork" type="image" src="./css/index/youtube.PNG" onclick="location.href='./html/youtube.html'">
                            <div>유튜브 페이지를 만들면서 배운 것은 웹페이지 기획단계부터 구조를 생각하고 html 문서를 작성해야한다는 것이었다.
                                맨처음에는 어찌됐든 완성해야된다는 생각에 콘텐츠 하나 하나 구현하는데만 집중했는데, 그렇게 다 구현해보니 콘텐츠들의 배치가
                                제가 원래 생각했던 것과는 너무나 달라서 다시 내용을 수정했어야만 했고, 그 과정에서 시간도 많이 들고 고칠 것도 많아서 힘들었다. </div>
                        </div>
                        <div class="inner">
                            <input class="myWork" type="image" src="./css/index/baseball.PNG" onclick="location.href='./html/baseball.html'">
                            <div> 버튼을 이용해 Dom에 직접 값을 넣을 수도, 지울 수도 있게 만들었고, 최종적으로는 내가 입력한 값과 난수로 생성된 값이 일치하는 지 확인할 수 있게 만들었다.
                                  이 과정에서 간단한 함수 구현 그리고 함수로 Dom값을 가져와서 일련의 연산처리를 한 이후에 다시 Dom값으로 보내는 방법을 배우게 됐다.
                            </div>
                        </div>
                        <div class="inner">
                            <input class="myWork" type="image" src="./css/index/drag&drop.PNG" onclick="location.href='html/drag and drop game.html'">
                            <div>start버튼을 누르면 게임이 시작되고 setInterval을 이용해서 타이머가 시작되게 만들었다. 진짜 게임처럼 만들기 위해 hover를 이용해 숫자박스에 마우스를 갖다대면
                                 커지는 효과와 그림자를 넣어주었다. 그리고 addEventListener를 이용해 드래그를 시작할 때, 드래그가 끝났을 때 등을 각각 함수로 정의해주었다. 여기서 아래박스와 윗박스의 값 비교는 dataTransfer을 이용했다. 그리고 게임이 끝나면 clearInterval을 이용해 타이머를 중지시키고 현재 시간을 record부분에 기록하게 만들었다.</div>
                        </div>
                    </div>
                </div>
            </div>
            <input type="image" id="rightArrow" src="./css/index/right_arrow.png" onclick="right()">
        </div>
    </section>
    <section id="contact">
        <div id="contact_title">Contact me</div>
        <div id="mypicture2"><img src="./css/index/my.jpg"></div>
        <ul id="contact_text">
            <li>이상민</li>
            <li>E-mail - ******@naver.com</li>
            <li>Phone - 010-****-****</li>
        </ul>
        
    </section>






    <script>
        var index=0;
        function left(){
            index--;
            if(index<0){index=2;}
            document.querySelector('.container').style.transform = "translate("+ -60*(index%3)+"vw)";
    }

    function right(){
            index++; 
            document.querySelector('.container').style.transform = "translate("+ -60*(index%3)+"vw)";        
    }

   
    </script>
 
</body>
</html>