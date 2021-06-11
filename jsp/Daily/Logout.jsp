<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>



<%
    /* 모든 쿠키와 세션을 삭제해주는 페이지 */

    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("autoId")){
                c.setMaxAge(0);
                c.setPath("/");
                response.addCookie(c);
            }

                if(c.getName().equals("memberId")){
                c.setMaxAge(0);
                c.setPath("/");
                response.addCookie(c);
            }
            
        }
        session.invalidate();
        response.sendRedirect("../../index.jsp");
    }
%>