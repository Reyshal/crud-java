<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="book" scope="page" class="crud.Book" />
<jsp:setProperty name="book" property="*" />
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        String site = "/CrudJava/index.jsp" ;
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
    }

    String message = "";
    String id = request.getParameter("id") ;
    
    if (!id.equals("")) {
        if (book.delete(Integer.parseInt(id))) {
            message = "Data telah terhapus";
        } else {
            message = "Error" ;
        }
    } else {
        message="Data tidak ditemukan";
    }

    String site = "/CrudJava/dashboard.jsp" ;
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site);  
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <title>GuestBook</title>
    </head>
    <body>
        <h2><%=message%>
            <br>
            <a href="index.jsp"> GUEST BOOK </a>
            <br>
            <a href="guestBookView.jsp"> VIEW GUEST BOOK </a>
        </h2>
    </body>
</html>