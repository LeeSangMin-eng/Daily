<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page import="java.io.*, java.util.Date, java.util.Enumeration" %> 
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<%
    Connection conn = null;
    PreparedStatement pstmt = null;  //쿼리를 보내주기 전 상태
    String sql = "";
    ResultSet rs = null;

    request.setCharacterEncoding("utf-8");
    String rDate = request.getParameter("date");
    String rStart = request.getParameter("start");
    String rEnd = request.getParameter("end");
    String rContent = request.getParameter("content");
    String rId = (String)session.getAttribute("id");

    String preDate = request.getParameter("preDate");
    String preStart = request.getParameter("preStart");
    String preEnd = request.getParameter("preEnd");
    String preContent = request.getParameter("preToDo");

        try{
                Class.forName("com.mysql.jdbc.Driver"); // dbms 설정
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "ubuntun","1234"); //db 설정

                
                // 기존 값과 일치하는 row 찾아서 값들 수정하기
                sql="UPDATE Daily SET date = '" + rDate + "', start ='" + rStart + "', end ='" + rEnd + "', toDo = '" + rContent +"' WHERE id = '" + rId + "' AND date = '" + preDate + "' AND start= '" + preStart + "' AND end = '" + preEnd + "' AND toDo = '" + preContent + "';";
                //쿼리 상태 채워주기
                pstmt = conn.prepareStatement(sql);
                //쿼리 전송
                pstmt.executeUpdate();


        } catch(Exception e){
            e.printStackTrace();
        } finally{
            if(pstmt != null){ try{ pstmt.close(); } catch (Exception e){}
            }
            if(conn != null){ try{ conn.close(); } catch (Exception e){}
            }
        }

%>

<script>
    opener.document.location.reload(); // 메인페이지 새로고침
    window.open('','_self').close();   // 수정창 닫기
 </script>