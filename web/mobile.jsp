<%@page import="dto.Mobile"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mobile Page</title>
        <style>
            form div{
                margin-left: 20px;
                margin-right: 20px;
            }
            th{
                background: #e0ffff;
                color: #333;
            }
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                width: 80%;
                margin: auto;
                overflow: hidden;
            }
            #welcome {
                font-size: 1em;
                font-weight: bold;
                margin: 20px 0;
                color: #333;
                padding-bottom: 5%;
                display: flex;
                justify-content: space-around;
                align-items: end;
                padding-top: 50px;
                border: 5px #00ffff solid;
                background: #e0ffff ;
                padding-left: 20px;
                padding-right: 20px;
                background-image:url('https://m-cdn.phonearena.com/images/article/64576-wide-two_1200/The-Best-Phones-to-buy-in-2024---our-top-10-list.webp?1709730284');background-size: cover; 
            }
            form {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }
            form input[type="text"] {
                flex: 1;
                padding: 10px;
                margin-right: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
            }
            form input[type="submit"], form input[type="button"], td button {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                background-color: #e0ffff;
                color: #333;
                cursor: pointer;
            }
            table {
                width: 100%;
                background: white;
                border-collapse: collapse;
            }
            td {
                padding: 10px;
                border: 1px black solid #ddd;
            }
            form input[type="text"], form input[type="number"] {
                padding: 10px;
                margin-right: 10px;
                border-radius: 5px;
                border: 1px solid #ddd;
                width: 100%;
            }
        </style>

    </head>
    <body style="background-image: url('https://www.technocrazed.com/wp-content/uploads/2015/12/black-wallpaper-to-set-as-background-28.jpg');background-size: cover;">
        <div class="container">
            <div id="welcome">
                <h1 style="display: inline-block;color: #e0ffff">Welcome staff:</h1>
                <h1 style="color: #1e90ff;font-size: 250%;display: inline-block;"> <%= request.getSession().getAttribute("userId")%></h1>
                <form style="display: inline-block" action="LogoutController" method="POST">
                    <input style="background:#ff0000;color: whitesmoke" type="submit" value="Logout" />
                </form> 
            </div>
            <p style="background-color:red;color:white;display:inline-block">${message}</p>
            <div>
                <form action="MobileController">
                    <input type="text" name="query" />
                    <input id="search-bar" type="submit" value="SEARCH" name="action" /> 
                </form>
                <form action="mobile.jsp">
                    <input class="add-button" type="submit" value="ADD" name="action" /> 
                </form>
            </div>
            <%
                String action = request.getParameter("action");
                if (action != null && action.equalsIgnoreCase("Add")) {
            %>

            <form action="MobileController" method="POST">
                <!-- Your input fields here -->
                <div style="display: flex; align-items: end;">
                    <div style="margin-right: 20px;"><h3 style="color: white">Mobile ID:</h3> <input type="text" name="mobileId" required /></div>
                    <div style="margin-right: 20px;"><h3 style="color: white">Mobile Name:</h3> <input type="text" name="mobileName" required /></div>
                    <div style="margin-right: 20px;"><h3 style="color: white">Description:</h3> <input type="text" name="description" required /></div>
                    <div style="margin-right: 20px;"><h3 style="color: white">Price:</h3> <input type="number" name="price" required min="0"  /></div>
                    <div style="margin-right: 20px;"><h3 style="color: white">Year of production:</h3><input type="number" name="yearOfProduction" min="2000" required /></div>
                    <div style="margin-right: 20px;"><h3 style="color: white">Quantity:</h3> <input type="number" name="quantity" min="0" required /></div>
                    <div style="margin-right: 20px;"><h3 style="color: white">Image Link: </h3><input type="text" name="image" required /></div> <!-- Added Image Link field -->
                    <div style="margin-right: 20px;"><h3 style="color: white">Not sale? </h3><input type="checkbox" name="notSale" value="true"></div>
                    <div><input type="submit" name="action" value="add" /></div>
                </div>
            </form>



            <% } %>
            <table border="1">
                <colgroup>
                    <col style="width: 5%;"> <!-- Adjust the width of each column as needed -->
                    <col style="width: 10%;">
                    <col style="width: 10%;">
                    <col style="width: 5%;">
                    <col style="width: 5%;">
                    <col style="width: 5%;">
                    <col style="width: 5%;">
                    <col style="width: 5%;">
                    <col style="width: 10%;">
                    <col style="width: 10%;">
                </colgroup>
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Mobile ID</th> 
                        <th>Mobile name</th> 
                        <th>Description</th> 
                        <th>Price</th>
                        <th>Year of production</th>
                        <th>Quantity</th>
                        <th>Not sale</th> 
                        <th>ImagePath</th>
                        <th>ImageDemo</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% int count = 0;
                        List<Mobile> list = (List) request.getAttribute("mobileList");
                        if (list != null) {
                            for (Mobile i : list) {
                                count++;%>
                <form action="MobileController" method="POST">
                    <tr>
                        <td><%= count%></td>
                        <td><%= i.getMobileId()%></td>
                        <td><%= i.getMobileName()%></td>
                        <td><input type="text" name="description" value="<%= i.getDescription()%>" style="width: 100%; overflow: hidden; text-overflow: ellipsis;"></td>
                        <td><input type="text" min="0" max="9999" name="price" value="<%= i.getPrice()%>" style="width: 100%; overflow: hidden; text-overflow: ellipsis;"></td>
                        <td><%= i.getYearOfProduction()%></td>
                        <td><input type="text" name="quantity" min="0" max="100" value="<%= i.getQuantity()%>" style="width: 100%;"></td>
                        <td><input style="width: 80%" type="text" name="notSale" value="<%= i.getNotSale()%>" style="width: 100%;"></td>
                        <td><input type="text" name="image" value="<%= i.getImage()%>" style="width: 100%;"></td>
                        <td><img style="width: 60px;height: 60px" src="<%= i.getImage()%>" />
                        <td>
                            <input type="hidden" name="mobileId" value="<%=i.getMobileId()%>" />
                            <input style=";padding: 10px;background: #e0ffff;margin-left: 20px;border:1px white solid"
                                   type="submit" value="Update Product"/>
                            <input type="hidden" name="action" value="update" />
                </form>
                <form style="display: inline"action="MobileController" method="POST">

                    <div>
                        <input type="hidden" name="mobileId" value="<%= i.getMobileId()%>">
                        <a style="color: red; text-decoration: none" href="MobileController?action=delete&mobileId=<%= i.getMobileId()%>"></a>

                        <input style="background: #ff0000 ;color: white;display: inline-block;padding: 10px" type="submit" value="Remove Product"/>
                        <input  type="hidden" name="action" value="DELETE"/>
                </form>
        </div>
    </td>
</tr>

<% }
    }%>
</tbody>
</table>

</div>

</body>
</html>
