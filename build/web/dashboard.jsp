<%@ include file="/WEB-INF/jspf/header_dashboard.jspf" %>
<jsp:useBean id="book" scope="page" class="crud.Book" />
<jsp:setProperty name="book" property="*" />
<%
    String user = (String) session.getAttribute("user");
    if (user == null) {
        String site = "/CrudJava/index.jsp" ;
        response.setStatus(response.SC_MOVED_TEMPORARILY);
        response.setHeader("Location", site); 
    }

    String id_input = request.getParameter("product_id");
    String title_input = request.getParameter("title");
    String author_input = request.getParameter("author");
    String description_input = request.getParameter("description");
    String price_input = request.getParameter("price");
    String category_input = request.getParameter("categoryId");
    String image_input = request.getParameter("image");
    String submit_input = request.getParameter("submit");

    if (title_input != null && author_input != null && description_input != null && price_input != null && category_input != null && image_input != null) {
        if ((!title_input.equals("")) && (!author_input.equals("")) && (!description_input.equals("")) && (!price_input.equals("")) && (!category_input.equals("")) && (!image_input.equals(""))) {
            if (submit_input.equals("add") ? book.simpan() : book.update(Integer.parseInt(id_input))) {
                response.setIntHeader("Refresh", 0);
            } else {
                response.setIntHeader("Refresh", 0);
            }
        } 
    }
    
    int start = request.getParameter("start") != null ? Integer.parseInt(request.getParameter("start")) : 0;
    int size = 10;
    Object[][] listBook = null;
    listBook = book.listData(start, size);
%>
<main class="pt-2 pb-16 lg:pt-16 lg:pb-24 bg-gray-900 min-h-[80vh] flex">
    <div class="flex justify-between px-4 mx-auto max-w-screen-xl">
        <div class="mx-auto max-w-5xl text-gray-400">
            <div class="flex justify-between items-center pb-4">
                <h4 class="text-2xl font-extrabold leading-none tracking-tight text-gray-900 dark:text-white">Book List</h4>
                <button type="button" data-modal-target="book-add-modal" data-modal-toggle="book-add-modal" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-bold rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800">Add Book</button>
            </div>

            <div class="relative overflow-x-auto">
                <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400">
                    <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
                        <tr>
                            <th scope="col" class="px-6 py-3">
                                No
                            </th>
                            <th scope="col" class="px-6 py-3">
                                ID
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Title
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Author
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Description
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Price
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Category
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Image
                            </th>
                            <th scope="col" class="px-6 py-3">
                                Action
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (listBook != null) {
                                for (int i = 0; i < listBook.length; i++) {
                                    int no = i + 1;
                                
                                    String id = listBook[i][0].toString();
                                    String title = listBook[i][1].toString();
                                    String author = listBook[i][2].toString();
                                    String desc = listBook[i][3].toString();
                                    String price = listBook[i][4].toString();
                                    String category_id = listBook[i][5].toString();
                                    String image = listBook[i][6].toString();
                        %>
                                    <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
                                        <td scope="row" class="px-6 py-4 font-medium text-gray-900 whitespace-nowrap dark:text-white"><%=no%></td>
                                        <td class="px-6 py-4"><%=id%></td>
                                        <td class="px-6 py-4"><%=title%></td>
                                        <td class="px-6 py-4"><%=author%></td>
                                        <td class="px-6 py-4"><%=desc%></td>
                                        <td class="px-6 py-4"><%=price%></td>
                                        <td class="px-6 py-4"><%=category_id%></td>
                                        <td class="px-6 py-4"><img src="<%=image%>" alt="Book Image" class="bg-contain" width="200"></td>
                                        <td class="px-6 py-4 flex gap-2">
                                            <button type="button" onclick="editButton(this)" 
                                            data-id="<%=id%>" data-title="<%=title%>" data-author="<%=author%>" data-desc="<%=desc%>" 
                                            data-price="<%=price%>" data-category="<%=category_id%>" data-image="<%=image%>" 
                                            data-modal-toggle="book-edit-modal" class="font-bold text-blue-500">
                                                Edit
                                            </button> 
                                            | 
                                            <a href="delete.jsp?id=<%=id%>" class="font-bold text-red-500">Delete</a> 
                                        </td>
                                    </tr>
                        <%
                                }
                            }
                        %>

                    </tbody>
                </table>
            </div>

            <div class="flex items-center justify-end mt-4">
                <!-- Buttons -->
                <a href="dashboard.jsp?start=<%=(start - 10)%>" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-gray-800 rounded-l hover:bg-gray-900 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                    <svg aria-hidden="true" class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414l4-4a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd"></path></svg>
                    Prev
                </a>
                <a href="dashboard.jsp?start=<%=(start + 10)%>" class="inline-flex items-center px-4 py-2 text-sm font-medium text-white bg-gray-800 border-0 border-l border-gray-700 rounded-r hover:bg-gray-900 dark:bg-gray-800 dark:border-gray-700 dark:text-gray-400 dark:hover:bg-gray-700 dark:hover:text-white">
                    Next
                    <svg aria-hidden="true" class="w-5 h-5 ml-2" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L14.586 11H3a1 1 0 110-2h11.586l-2.293-2.293a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>
                </a>
            </div>
        </div>


        <!-- add book modal -->
        <div id="book-add-modal" tabindex="-1" aria-hidden="true"
             class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
            <div class="relative w-full max-w-md max-h-full">
                <!-- Modal content -->
                <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                    <button type="button"
                            class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white"
                            data-modal-hide="book-add-modal">
                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                             xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"></path>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                    <div class="px-6 py-6 lg:px-8">
                        <h3 class="mb-4 text-xl font-medium text-gray-900 dark:text-white">Add New Book</h3>
                        <form class="space-y-6" action="dashboard.jsp" method="post">
                            <div>
                                <label for="title"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Title</label>
                                <input type="text" name="title" id="title"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="author"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Author</label>
                                <input type="text" name="author" id="author"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="price"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Price</label>
                                <input type="number" name="price" id="price"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="category_id"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Category ID</label>
                                <input type="number" name="categoryId" id="category_id"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your Description</label>
                                <textarea id="description" rows="3" name="description" class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder=""></textarea>
                            </div>
                            <div>
                                <label for="image"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Image</label>
                                <input type="text" name="image" id="image"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <button type="submit" name="submit" value="add"
                                    class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- edit book modal -->
        <div id="book-edit-modal" tabindex="-1" aria-hidden="true"
             class="fixed top-0 left-0 right-0 z-50 hidden w-full p-4 overflow-x-hidden overflow-y-auto md:inset-0 h-[calc(100%-1rem)] max-h-full">
            <div class="relative w-full max-w-md max-h-full">
                <!-- Modal content -->
                <div class="relative bg-white rounded-lg shadow dark:bg-gray-700">
                    <button type="button"
                            class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white"
                            data-modal-hide="book-edit-modal">
                        <svg aria-hidden="true" class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20"
                             xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
                              d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                              clip-rule="evenodd"></path>
                        </svg>
                        <span class="sr-only">Close modal</span>
                    </button>
                    <div class="px-6 py-6 lg:px-8">
                        <h3 class="mb-4 text-xl font-medium text-gray-900 dark:text-white">Edit Book</h3>
                        <form class="space-y-6" action="dashboard.jsp" method="post">
                            <input type="hidden" name="product_id" id="edit-id">
                            <div>
                                <label for="title"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Title</label>
                                <input type="text" name="title" id="edit-title"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="author"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Author</label>
                                <input type="text" name="author" id="edit-author"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="price"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Price</label>
                                <input type="number" name="price" id="edit-price"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="category_id"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Category ID</label>
                                <input type="number" name="categoryId" id="edit-category_id"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <div>
                                <label for="description" class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your Description</label>
                                <textarea id="edit-description" rows="3" name="description" class="block p-2.5 w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder=""></textarea>
                            </div>
                            <div>
                                <label for="image"
                                       class="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your
                                    Image</label>
                                <input type="text" name="image" id="edit-image"
                                       class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white"
                                       placeholder="" required>
                            </div>
                            <button type="submit" name="submit" value="edit"
                                    class="w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Save</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/jspf/footer_dashboard.jspf" %>

<script>
    function editButton(e) {
        $('#edit-id').val($(e).data('id'));
        $('#edit-title').val($(e).data('title'));
        $('#edit-author').val($(e).data('author'));
        $('#edit-price').val($(e).data('price'));
        $('#edit-description').val($(e).data('desc'));
        $('#edit-image').val($(e).data('image'));
        $('#edit-category_id').val($(e).data('category'));
    }
</script>