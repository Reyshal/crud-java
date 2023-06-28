<%@ include file="/WEB-INF/jspf/header.jspf" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="User" scope="page" class="crud.User" />
<jsp:setProperty name="User" property="*" />
<%
    String message = "";
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    if (username != null && password != null) {
        if((!username.equals("")) && (!password.equals(""))) {
            if (User.login(username, password)){
                session.setAttribute("user", username); 
                String site = "/CrudJava/dashboard.jsp" ;
                response.setStatus(response.SC_MOVED_TEMPORARILY);
                response.setHeader("Location", site);  
            } else {
                message = "Wrong username or password" ;
            }
        } else {
            message = "Field name or password tidak boleh kosong";
        }
    }  
%>
<section class="bg-gray-50 dark:bg-gray-900">
    <div class="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">
        <div
            class="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
            <div class="p-6 space-y-4 md:space-y-6 sm:p-8">
                <h1
                    class="text-xl font-bold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
                    Sign in to your account
                </h1>
                <div class="text-sm rounded-lg text-red-400" role="alert">
                    <%=message%>
                </div>

                <form action="" method="post" name="login">
                    <div class="mb-6">
                        <label for="username" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                            username</label>
                        <input type="text" id="username" name="username"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               placeholder="" required>
                    </div>
                    <div class="mb-6">
                        <label for="password"
                               class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                            password</label>
                        <input type="password" id="password" name="password"
                               class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                               required>
                    </div>
                    <button type="submit" name="submit" value="submit"
                            class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Submit</button>
                </form>
            </div>
        </div>
    </div>
</section>

<%@include file="/WEB-INF/jspf/footer.jspf" %>