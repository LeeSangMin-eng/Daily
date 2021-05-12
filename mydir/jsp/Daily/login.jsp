<%@ page import ="java.sql.Connection"%>
<%@ page import ="java.sql.PreparedStatement"%>
<%@ page import ="java.sql.DriverManager"%>
<%@ page import ="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<%

    Connection conn = null;
    PreparedStatement pstmt = null;  //쿼리를 보내주기 전 상태
    String sql = "";
    ResultSet rs = null;

    request.setCharacterEncoding("UTF-8");
    String rId = request.getParameter("id");
    String rPassword = request.getParameter("password");
    String autoLogin = request.getParameter("autoLogin");
    Cookie cookie = null;

    int emptyId = 0;
    int emptyPwd = 0;
    int noId = 0;
    int wrongPwd = 0;
    int done =0;

        try{
            if(rId.equals("")){
                emptyId++;
            }
            else if(rPassword.equals("")){
                emptyPwd++;
            }
            else{
                Class.forName("com.mysql.jdbc.Driver"); // dbms 설정
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "ubuntun","1234"); //db 설정

                sql = "SELECT id FROM user WHERE id = '" + rId + "';";
                pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                rs = pstmt.executeQuery();
                rs.last();
            
                if(rs.getRow()==0){
                    noId++;
                }
                else{
                    sql = "SELECT id password FROM user WHERE id = '"+ rId +"' AND password = '" + rPassword + "';";
                    pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                    rs = pstmt.executeQuery();
                    rs.last();
                    if(rs.getRow()==0){
                        wrongPwd++;
                    }
                    else{
                        if(autoLogin != null){                     // 자동 로그인인 경우
                            cookie = new Cookie("autoId", rId);
                            cookie.setMaxAge(100*365*24*60*60);
                            response.addCookie(cookie);
                            response.sendRedirect("Daily.jsp");
                        }
                        else{                    
                            cookie = new Cookie("memberId", rId);     // 자동 로그인이 아닐 경우
                            cookie.setMaxAge(100*365*24*60*60);
                            response.addCookie(cookie);                   
                            response.sendRedirect("Daily.jsp");
                        }


                    }
                    
                }
        
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
    if(<%=emptyId%>==1){
        alert("아이디를 입력해주세요.");
    }
    else if(<%=emptyPwd%>==1){
        alert("비밀번호를 입력해주세요.");
    }
    else if(<%=noId%>==1){
        alert("아이디가 존재하지 않습니다.");
    }
    else if(<%=wrongPwd%>==1){
        alert("비밀번호가 틀렸습니다.");
    }
    location.href = "SignIn.jsp";

    
</script>