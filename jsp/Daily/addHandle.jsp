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
    String rBtn = request.getParameter("btn");
    String rId = (String)session.getAttribute("id");

        try{
            if(rBtn.equals("add")){
                Class.forName("com.mysql.jdbc.Driver"); // dbms 설정
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "ubuntun","1234"); //db 설정

                
                // 새 일정 추가
                sql="INSERT INTO Daily(id, date, start, end, toDo) Values(?,?,?,?,?);";
                //쿼리 상태 채워주기
                pstmt = conn.prepareStatement(sql);
                //sql문에 값 채워주기
                pstmt.setString(1, rId);
                pstmt.setString(2, rDate);
                pstmt.setString(3, rStart);
                pstmt.setString(4, rEnd);
                pstmt.setString(5, rContent);
                //쿼리 전송
                pstmt.executeUpdate();
            }


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
    opener.document.location.reload();  // 메인 페이지 새로고침
    window.open('','_self').close();    // 추가페이지 창 닫기
 </script>