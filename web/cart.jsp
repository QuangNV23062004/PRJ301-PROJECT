<%@page import="dto.Mobile"%>
<%@page import="dto.Cart"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cart Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
                background-image:url('https://m-cdn.phonearena.com/images/article/64576-wide-two_1200/The-Best-Phones-to-buy-in-2024---our-top-10-list.webp?1709730284');background-size: cover; 
                padding-left: 20px;
                padding-right: 20px;
            }
            form{
                font-size: 150%;
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
            td {
                padding: 10px;
                border: 1px black solid #ddd;
            }

            .product-card {
                border: 1px solid #ddd;
                padding: 10px;
                margin: 10px;
                text-align: center;
            }


            .product-card h2 {
                font-size: 1.5em;
                color: #333;
            }

            .product-card p {
                color: #666;
            }
            .product-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                margin: 50px;
            }
            body{
                background-image: url('https://wallpapercave.com/wp/MQy6rhu.jpg');
                background-size: cover;
            }
            .viewCartButton {
                width: 150%;
                padding: 9px;
                border-radius: 5px;
                border: 1px solid #ddd;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div id="welcome">
                <h1 style="display: inline-block;color:#e0ffff;">Welcome, </h1>
                <h1 style="color: #1e90ff; font-size: 250%; display: inline-block;"><%= request.getSession().getAttribute("userId")%></h1>
                <form style="display: inline-block" action="LogoutController" method="POST">
                    <input style="background:#ff0000;color: whitesmoke" type="submit" value="Logout" />
                </form>
            </div>
            <br/>
            <br/>
            <div style="display: inline-block;width: 100%">
                <form style="display: inline-block;width: 85%"action="CartController" method="POST">
                    <input style="width: 75%"type="text" name="SearchValue" value="" />
                    <input type="submit" style="width: 15%" name="notaction" value="SEARCH" />
                    <input type="hidden" value="SEARCH2" name="action" />

                </form>
                <!-- "View Cart" button -->
                <form style="display: inline-block;width: 10%" id="viewCartForm" action="CartController">
                    <input type="hidden" name="userID" value="<%= request.getSession().getAttribute("userId")%>" />
                    <button class="viewCartButton" type="submit" name="action" id="viewCartButton" value="VIEWCART">
                        <i class="fa-solid fa-cart-shopping"></i>
                    </button>

                </form>
            </div>

            <br/><br/>
            <br/>

            <div style="background:#333;display: flex;justify-content: space-around;height: 50px;border: 1px yellow solid"class="topnav">
                <a style="color: white;font-size: 150%;margin: 5px" href="CartController">Home</a>
                <a style="color: white;font-size: 150%;margin: 5px" class="active" href="#form" onclick="toggleForm()">Price Range</a>

                <a style="color: white;font-size: 150%;margin: 5px" href="#contact" onclick="toggleP()">Contact Us</a>
            </div><br/>
            <p style="background-color:red;color:white;display:inline-block">${message}</p> 
            <br/>   
            <form id="myForm" style="padding-bottom: 100px; display: none;" action="CartController">
                <h4>Min price:</h4> <input style="height: 30px;width: 80px" type="number" min="0" name="minPrice" /><br/>
                <h4>Max price:</h4> <input style="height: 30px;width: 80px" type="number" min="0" name="maxPrice" /><br/>
                <input style="width: 100px;height:40px;padding: 0px;margin: 0px" type="submit" value="SEARCH" name="action" /> 
            </form>
            <p id="myP" style="display: none;background: #A9A9A9;color: white">For more information,contact us at:<a href="randomurl">Please dont try to contact us,this is a project</a> </p>


        </div>
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <h1 style="text-align: center;color: #FF760D">RECENT PRODUCT</h1>
            <ol  class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div style="border: 5px #e0ffff solid;width: 80%;margin-left: 10%;margin-right: 10%" class="carousel-inner">
                <div class="carousel-item active">
                    <img style="width: 300px;height: 600px" src="https://www.flashfly.net/wp/wp-content/uploads/2022/06/iPhone-15-Pro-concept-render-4RMD-1.jpg" class="d-block w-100" alt="First slide">
                </div>
                <div class="carousel-item">
                    <img style="width: 300px;height: 600px" src="https://th.bing.com/th/id/R.153e4fb855fc08512c190844f01bdc3f?rik=L8XXujoanSKu6Q&pid=ImgRaw&r=0" class="d-block w-100" alt="Second slide">
                </div>
                <div class="carousel-item">
                    <img style="width: 300px;height: 600px" src="https://www.theindianwire.com/wp-content/uploads/2018/05/lg-g7-thinq-render-android-headlines-1320x650.jpg" class="d-block w-100" alt="Third slide">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>

        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

        <table border="1">
            <div style="padding-top: 100px">
                <thead>
                    <tr>

                    </tr>
                </thead>
            </div>
            <tbody>
            <div class="product-container">
                <%
                    List<Mobile> list = (List) request.getAttribute("mobiles");
                    if (list != null) {
                        for (Mobile i : list) {
                %>
                <div style="width: 22%;background:#D3D3D3;border: 1px #333 solid" class="product-card">
                    <img  style="width: 220px;height:220px " src="<%= i.getImage()%>" alt="<%= i.getMobileName()%>">
                    <h2><%= i.getMobileName() + " " + i.getDescription()%></h2>

                    <p>Price: <%= i.getPrice()%></p>
                    <p>ID:<%= i.getMobileId()%></p>
                    <form action="CartController" method="POST">
                        <input type="hidden" name="mobileId" value="<%= i.getMobileId()%>">
                        <input style="background: #FF760D;color: white"type="submit" name="action" value="addToCart">
                    </form>
                </div>
                <%
                        }
                    }
                %>
            </div>



        </div>
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
        <script>
            // JavaScript to toggle the visibility of the cart table
            document.getElementById('viewCartButton').addEventListener('click', function () {
                var cartTable = document.getElementById('cartTable');
                if (cartTable.style.display === 'none') {
                    cartTable.style.display = 'block';
                } else {
                    cartTable.style.display = 'none';
                }
            });
        </script>

</body>
<script src="https://kit.fontawesome.com/5376fa8873.js" crossorigin="anonymous"></script>
</html>
