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

    request.setCharacterEncoding("utf-8");
    String rId = request.getParameter("id");
    String rPassword = request.getParameter("password");
    String rPwdcheck = request.getParameter("pwdCheck");
    Cookie cookie = null;


    int emptyId = 0;
    int emptyPwd = 0;
    int differentPwd =0;
    int duplication = 0;
    int done =0;

        try{
            if(rId.equals("")){
                emptyId++;
            }
            else if(rPassword.equals("")){
                emptyPwd++;
            }
            else if(!rPassword.equals(rPwdcheck)){
                differentPwd++;
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

                cookie = new Cookie("memberId", rId);
                cookie.setMaxAge(100*365*24*60*60);
                response.addCookie(cookie);

                done++;
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
%>
<script>
    if(<%=emptyId%>==1){
        alert("아이디를 입력해주세요.");
    }
    else if(<%=emptyPwd%>==1){
        alert("비밀번호를 입력해주세요.");
    }
    else if(<%=duplication%>==1){
        alert("이미 존재하는 아이디입니다.");
    }
    else if(<%=differentPwd%>==1){
        alert("비밀번호가 다릅니다.");
    }
    location.href = "SignUp.jsp";

    if(<%=done%>==1){
        alert("회원가입 성공!");
        location.href = "SignIn.jsp";
    }
</script>