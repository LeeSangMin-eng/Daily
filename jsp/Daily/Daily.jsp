<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daily</title>
    <link rel="stylesheet" href="../../css/daily/main.css">

</head>
<body>
    <div id="mainBoard">
    </div>
    <div id="menu">
        <div id="logo" onclick="location.href='Daily.jsp'">Daily</div>
        <div id="add" onclick="add()">+</div>
        <div id="Logout" onclick="location.href='Logout.jsp'">Logout</div>
    </div>

<script>
    function add() {              // 일정을 추가하는 새 창을 띄운다.
        var url = "add.jsp";
        var name = "일정 추가";
        var option = "width = 400, height = 250, top = 200, left = 400, location = no";
        window.open(url,name,option);
    }

    function getToday(){          // 현재의 날짜를 가져온다. (YYYY-MM-DD)
        var date = new Date();
        var year = date.getFullYear();
        var month = ("0" + (1 + date.getMonth())).slice(-2);
        var day = ("0" + date.getDate()).slice(-2);

        return year + "-" + month + "-" + day;
    }

    function getNowtime(){         // 현재의 시간을 가져온다. (HH:MM)
        var date = new Date();
        var hour = ("0" + date.getHours()).slice(-2);
        var minute = ("0" + date.getMinutes()).slice(-2);

        return hour + ":" + minute;
    }

    function eliminate(){          // 해당 일정을 삭제하는 페이지로 이동한다.
        var form = this.parentNode.parentNode;
        if(confirm("정말로 삭제하시겠습니까?")){
            form.action = "Delete.jsp";
        }
    }

    function modify(){              // 해당 일정을 수정하는 페이지를 새 창으로 띄운다.
        var form = this.parentNode.parentNode;
        var url = "modify.jsp";
        var name = "일정 수정";
        var option = "width = 400, height = 250, top = 200, left = 400, location = no";
        window.open(url,name,option);
        form.action ="modify.jsp";
        form.target = name;
    }


    function addBoardEvent(_date, _start, _end, _toDo, isSameDate){     // 일정들을 동적으로 추가해준다.

            var form = document.createElement("form");                  // 폼 
            form.method = "post" 
            form.action = "";

            var board = document.createElement("div");                  // 일정 보드
            board.className = "board";

            var date = document.createElement("div");                   // 날짜
            if(isSameDate != "Y") {date.innerText = _date;}             // 이전 날짜와 같으면 날짜 칸은 비워둔다.
            date.className = "date";

            var start = document.createElement("div");                  // 시작 시간
            start.innerText = _start;
            start.className = "start";

            var tilde = document.createElement("div");                  // 물결표
            tilde.innerText = "~";
            tilde.className = "tilde";

            var end = document.createElement("div");                    // 끝나는 시간
            end.innerText = _end;
            end.className = "end";


            var toDo = document.createElement("div");                    // 할 일
            toDo.innerText = _toDo;
            toDo.className = "toDo";

            var modification = document.createElement("button");         // 수정 버튼
            modification.innerText = "수정";
            modification.className = "modify";
            modification.setAttribute("type","submit");
            modification.onclick = modify;

            var remove = document.createElement("button");                // 삭제 버튼
            remove.innerText = "삭제";  
            remove.className = "remove";
            remove.setAttribute("type","submit");
            remove.onclick = eliminate;

            var dateValue = document.createElement("input");               /* 폼 태그로 값을 보내주기 위한 설정 */
            dateValue.setAttribute("type","hidden");
            dateValue.setAttribute("name","date");
            dateValue.setAttribute("value", _date);

            var startValue = document.createElement("input");
            startValue.setAttribute("type","hidden");
            startValue.setAttribute("name", "start");
            startValue.setAttribute("value", _start);

            var endValue = document.createElement("input");
            endValue.setAttribute("type","hidden");
            endValue.setAttribute("name", "end");
            endValue.setAttribute("value", _end);

            var toDoValue = document.createElement("input");
            toDoValue.setAttribute("type","hidden");
            toDoValue.setAttribute("name", "toDo");
            toDoValue.setAttribute("value", _toDo);

 
            board.appendChild(date);                
            board.appendChild(start);
            board.appendChild(tilde);
            board.appendChild(end);
            board.appendChild(toDo);
            board.appendChild(modification);
            board.appendChild(remove);

            board.appendChild(dateValue);
            board.appendChild(startValue);
            board.appendChild(endValue);
            board.appendChild(toDoValue);
            
            form.appendChild(board);

            var main = document.getElementById("mainBoard");
            main.appendChild(form);

            if(getToday() + getNowtime() > _date + _end){         // 이미 끝난 일정들에 대해 취소선을 긋는다.
                date.style.textDecorationLine = "line-through";
                date.style.color = "grey";
                start.style.textDecorationLine = "line-through";
                start.style.color = "grey";
                end.style.textDecorationLine = "line-through";
                end.style.color = "grey";
                toDo.style.textDecorationLine = "line-through";
                toDo.style.color = "grey";
                tilde.style. color = "grey";
            } 

            if(isSameDate == "Y"){                                 // 이전 일정과 날짜가 같으면 붙여준다. 
                form.style.marginTop = "-1.5%";
                board.style.borderTopLeftRadius= "0";
                board.style.borderTopRightRadius= "0";
            }
    }


function addEmptyBoardEvent(){                                      // 하단의 메뉴바 만큼 빈 공간을 추가해준다.                     

            var board = document.createElement("div");
            board.className = "emptyBoard";

            var main = document.getElementById("mainBoard");
            main.appendChild(board);
    }

            
</script>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;  //쿼리를 보내주기 전 상태
    String sql = "";
    ResultSet rs = null;

    String rId = (String)session.getAttribute("id");
    String preDate = null;
    String date = null;
    String start = null;
    String end = null;
    String content = null;

    if(rId == null){
        response.sendRedirect("../../index.jsp");
    }

        try{
            Class.forName("com.mysql.jdbc.Driver"); // dbms 설정
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "ubuntun","1234"); //db 설정

            // 날짜, 시작시간으로 정렬해서 값을 가져온다.
            sql = "SELECT * FROM Daily WHERE id = '"+ rId +"' ORDER BY date ASC, start ASC;";  
            pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            rs = pstmt.executeQuery();

            // 일정을 추가한다.
            while(rs.next()){     
                
                date = rs.getString(2);
                start = rs.getString(3);
                end = rs.getString(4);    
                content = rs.getString(5);

                if(date.equals(preDate)){
%>                  
                <script> addBoardEvent('<%=date%>', '<%=start%>', '<%=end%>', '<%=content%>', 'Y');</script>

<%                  } 
                else{
%>
                <script> addBoardEvent('<%=date%>', '<%=start%>', '<%=end%>', '<%=content%>', 'N');</script>

<%                  }
                preDate = rs.getString(2);
            }
%>
                <script> addEmptyBoardEvent();</script>
<%
        } catch(Exception e){
            e.printStackTrace();
        } finally{
            if(pstmt != null){ try{ pstmt.close(); } catch (Exception e){}
            }
            if(conn != null){ try{ conn.close(); } catch (Exception e){}
            }
        }

%>


</body>
</html>