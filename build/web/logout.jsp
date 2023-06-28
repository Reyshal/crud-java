<%
    String user = (String) session.getAttribute("user");
    if (user != null) {
        session.removeAttribute("user"); 
    } 

    String site = "/CrudJava/index.jsp" ;
    response.setStatus(response.SC_MOVED_TEMPORARILY);
    response.setHeader("Location", site); 
%>