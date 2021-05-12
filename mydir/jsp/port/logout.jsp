<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie c : cookies){
            if(c.getName().equals("memberId")){
                c.setMaxAge(0);
                response.addCookie(c);
            }
            
        }
        session.invalidate();
        response.sendRedirect("index.jsp");
    }
%>