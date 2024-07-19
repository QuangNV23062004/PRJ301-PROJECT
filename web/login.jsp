<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            h1 {
                color: #00ffff ;
            }
            h2 {
                color: #e7feff;
            }
            .container {
                display: flex;
                justify-content: space-around;
                padding: 2%;
                align-items: centre;
            }
            .login-form {
                display: flex;
                flex-direction: column;
                justify-content: center;
                background: white;
                width: 30%;
                padding: 2%;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            }
            .login-form input[type="submit"] {
                width: 100%;
                height: 60px;
                background: #1e90ff ;
                color: white;
                font-size: 150%;
                border: none;
                cursor: pointer;
                border-radius: 5px;
            }
            .login-form input[type="submit"]:hover {
                background: #1e90ff ;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body style="background-image:url('https://m-cdn.phonearena.com/images/article/64576-wide-two_1200/The-Best-Phones-to-buy-in-2024---our-top-10-list.webp?1709730284');background-size: cover ">     
        <div class="container">
            <div style="width: 30%; " >
                
            </div>      
            <form style="font-size: 120%;height: 300px;margin-top: 150px;border: 8px #555555 solid;"class="login-form" action="LoginController" method="POST">
                <h2 style="color: #1e90ff ">Login information</h2>
                User ID: <input type="text" name="userId" required placeholder="position-name"/> 
                <br>
                Password: <input type="password" name="password" required placeholder="******"/>
                <br>
                <p style="color:red;display:inline-block">${message}</p>
                <input name="action" type="submit" value="LOGIN" /> 
            </form>
        </div>
    </body>
    
</html>
