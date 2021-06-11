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
    String button = request.getParameter("btn");
    String autoLogin = request.getParameter("autoLogin");
    String ismember = null;
    Cookie[] cookies = request.getCookies();
    Cookie cookie = null;


    int emptyId = 0;
    int emptyPwd = 0;
    int noId=0;
    int wrongPwd=0;
    int duplication = 0;

    if(button.equals("register")){
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
                // sql문 작성
                sql="INSERT INTO user(id, password,is_admin) Values(?,?,?);";
                //쿼리 상태 채워주기
                pstmt = conn.prepareStatement(sql);
                //sql문에 값 채워주기
                pstmt.setString(1, rId);
                pstmt.setString(2, rPassword);
                pstmt.setString(3, "N");
                //쿼리 전송
                pstmt.executeUpdate();
                }
                else{
                    duplication++;
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
    }

    else if(button.equals("login")){
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
                            cookie = new Cookie("memberId", rId);
                            cookie.setMaxAge(60*60);
                            response.addCookie(cookie);
                            response.sendRedirect("indexLogin.jsp");
                        }
                        else{                                       // 자동 로그인이 아닐 경우
                            session.setAttribute("_id",rId);
                            response.sendRedirect("indexLogin.jsp");
                        }
                        ismember = "true";
                        session.setAttribute("loginDone", ismember);

                        sql = "SELECT id,is_admin FROM user WHERE id = '"+ rId +"' AND is_admin = 'Y';";
                        pstmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
                        rs = pstmt.executeQuery();
                        
                        while(rs.next()){
                            String isAdmin = rs.getString("is_admin");

                            if(isAdmin.equals("Y")){
                            session.setAttribute("isAdmin","Y");
                            session.setAttribute("pwd",rPassword);
                            response.sendRedirect("admin.jsp");
                            }
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
    }
%>
<script>
    if(<%=emptyId%>==1){
        alert("empty ID");
    }
    else if(<%=emptyPwd%>==1){
        alert("empty password");
    }
    else if(<%=duplication%>==1){
        alert("id is duplicate");
    }
    else if(<%=noId%>==1){
        alert("there is no Id");
    }
    else if(<%=wrongPwd%>==1){
        alert("wrong password");
    }
    location.href = "_jsp.html";

    
</script>