<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    if (email.equals("admin@example.com") && password.equals("admin")) {
        response.sendRedirect("success.jsp");
    } else {
        response.sendRedirect("error.jsp");
    }
%>
