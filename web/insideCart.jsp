<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="dto.Cart"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Your Cart</title>
        <style>
            #welcome {
                font-size: 1em;
                font-weight: bold;
                margin: 20px 0;
                color: #333;
                padding-bottom: 5%;
                display:flex;
                justify-content: space-between;
                align-items: end;
                padding-top: 20px;
                border: 5px #00ffff solid;
                background: #e0ffff ;
                padding-left: 20px;
                padding-right: 20px;
                background-image:url('https://m-cdn.phonearena.com/images/article/64576-wide-two_1200/The-Best-Phones-to-buy-in-2024---our-top-10-list.webp?1709730284');background-size: cover; 
            }
            form{
                font-size: 150%
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
                background-color: #333;
                color: #fff;
                cursor: pointer;
            }


            th{
                background:  #333;
                color: white;
            }
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                width: 80%;
                margin: 0 auto;
            }
            h1 {
                color: #333;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th {
                background: #333;
                color: white;
                padding: 10px;
            }
            td {
                border: 1px solid #ddd;
                padding: 10px;
            }
            input[type=number] {
                width: 50px;
            }
            input[type=submit] {
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px;
                text-decoration: none;
                margin: 4px;
                cursor: pointer;
                border: 2px #00ffff solid;
            }
            #totalAmount {
                font-size: 1.2em;
                color: #333;
                font-weight: bold;
            }
            body{
                background-image: url('https://wallpapercave.com/wp/MQy6rhu.jpg');
                background-size: cover;
            }
            .search{
                 display: inline-block;width: 100%;
            }
            .containWelcome{margin-left:10%;margin-right: 10%;
            }
            
            .fh1{display: inline-block;color: #e0ffff;
            }
            .sh1{
                color: #1e90ff; font-size: 250%; display: inline-block;
            }
            #logout{
               display: inline-block
            }
            #logoutbutton{
                background:#ff0000;color: whitesmoke
            }
        </style>
    </head>
    <body>   
        <div class="containWelcome">
        <div id="welcome">
            <h1 class="fh1">Welcome, </h1>
            <h1 class="sh1"><%= request.getSession().getAttribute("userId")%></h1>
            <form id="logout" action="LogoutController" method="POST">
                <input id="logoutbutton" type="submit" value="Logout" />
            </form>
        </div>
        <br/>
        <br/>
        <div class="search">
            <form style="display: inline-block;width: 85%"action="CartController" method="POST">
                <input style="width: 75%"type="text" name="SearchValue" value="" />
                <input type="submit" style="width: 15%" name="notaction" value="SEARCH" />
                <input type="hidden" value="SEARCH2" name="action" />

            </form>
            <form action="cart.jsp" style="display: inline-block">
                <input style="width: 150px;height: 37px;border: 1px yellow solid"type="submit" value="Back">
            </form>
        </div>

        <br/><br/>
        <br/>

        <div style="background:#333;display: flex;justify-content: space-around;height: 50px;border: 1px yellow solid"class="topnav">
            <a style="color: white;font-size: 150%;margin: 10px;text-decoration: none" href="CartController">Home</a>
            <a style="color: white;font-size: 150%;margin: 10px;text-decoration: none" class="active" href="#form" onclick="toggleForm()">Price Range</a>

            <a style="color: white;font-size: 150%;margin: 10px;text-decoration: none" href="#contact" onclick="toggleP()">Contact Us</a>
        </div><br/>
        
        <br/>   
        <form id="myForm" style="padding-bottom: 100px; display: none;" action="CartController">
            <h4>Min price:</h4> <input style="height: 30px;width: 80px" type="number" min="0" name="minPrice" /><br/>
            <h4>Max price:</h4> <input style="height: 30px;width: 80px" type="number" min="0" name="maxPrice" /><br/>
            <input style="width: 100px;height:40px;padding: 0px;margin: 0px;border: 1px yellow solid" type="submit" value="SEARCH" name="action" /> 
        </form>
        <p id="myP" style="display: none;background: #A9A9A9;color: white">For more information,contact us at:<a href="randomurl">Please dont try to contact us,this is a project</a> </p>
        <script>
            function toggleForm() {
                var form = document.getElementById("myForm");
                if (form.style.display === "none") {
                    form.style.display = "block";
                } else {
                    form.style.display = "none";
                }
            }
            function toggleP() {
                var form = document.getElementById("myP");
                if (form.style.display === "none") {
                    form.style.display = "block";
                } else {
                    form.style.display = "none";
                }
            }
        </script>
</div>

        <div class="container">
            <div>
                <h1>Your Cart ,${sessionScope.userId}</h1>

                <br/>
                <br/>

                <table id="cartTable" style="padding-bottom: 100px;background: white" border="1">
                    <c:set var="carts" value="${requestScope.carts}" />
                    <c:if test="${not empty carts}">

                        <thead>
                            <tr>
                                <th style="width: 200px">No</th>
                                <th style="width: 200px">Mobile ID</th> 
                                <th style="width: 200px">Name</th> 
                                <th style="width: 200px">Quantity</th>

                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach var="items" items="${carts}" varStatus="no">


                                <tr>
                            <form action="CartController">
                                <input type="hidden" name="action" value="updateQuantity">
                                <input type="hidden" name="userId" value="${items.userId}">
                                <input type="hidden" name="mobileId" value="${items.mobileId}" />
                                <td style="width: 200px" >${no.count}</td>
                                <td style="width: 200px" >${items.mobileId}</td>
                                <td style="width: 200px">${items.name}</td>
                                <td style="width: 200px">
                                    <input type="number" name="quantity" value="${items.quantity}"/>
                                </td>

                                <td>

                                    <input style="background: #00ffff;color: #333   " type="submit" value="Update Quantity">
                            </form>


                            </td>
                            <td>
                                <form action="CartController" >

                                    <input type="hidden" name="action" value="removeFromCart">
                                    <input type="hidden" name="userId" value="${items.userId}">

                                    <input type="hidden" name="mobileId" value="${items.mobileId}">
                                    <input style="background: #ff0000"type="submit" value="Remove from Cart">
                                </form>
                            </td>

                            </tr>
                        </c:forEach>

                        </tbody>

                    </table>
                </c:if>
                <br/>
                <div style="display: block">
                    <h2 id="totalAmount">TOTAL: $${total} </h2>

                </div>
                <h3>${requestScope.message}</h3>
            </div>
    </body>
</html>
