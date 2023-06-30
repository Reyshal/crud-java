# crud-java
This web application is a basic CRUD application for university project

## Installation

-   clone this repository
-   setting properties on the project
-   set your java platform and mysql connector on libraries settings
-   clean your project, build it and close it
-   create the database `crud_java` and run/import query `crud_java.sql`
-   adjust the project database settings in `src/java/Koneksi`
    ```
    private static final String url = "jdbc:mysql://localhost:3306/crud_java";
    private static final String user = "root";
    private static final String password = "";
    ```
-   check user table to see its data for sign in on the project
-   build and run the project
