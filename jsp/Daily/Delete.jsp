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
    String rContent = request.getParameter("toDo");
    String rId = (String)session.getAttribute("id");


    try{
            Class.forName("com.mysql.jdbc.Driver"); // dbms 설정
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "ubuntun","1234"); //db 설정

            // 해당 데이터 삭제
            sql="Delete FROM Daily WHERE id = '" + rId + "' AND date = '" + rDate + "' AND start= '" + rStart + "' AND end = '" + rEnd + "' AND toDo = '" + rContent + "';";
            //쿼리 상태 채워주기
            pstmt = conn.prepareStatement(sql);
            //sql문에 값 채워주기
            //쿼리 전송
            pstmt.executeUpdate();
            response.sendRedirect("Daily.jsp");



    } catch(Exception e){
        e.printStackTrace();
    } finally{
        if(pstmt != null){ try{ pstmt.close(); } catch (Exception e){}
        }
        if(conn != null){ try{ conn.close(); } catch (Exception e){}
        }
    }
%>