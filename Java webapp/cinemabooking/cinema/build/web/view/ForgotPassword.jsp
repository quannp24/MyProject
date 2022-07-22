<%-- 
    Document   : ForgotPassword
    Created on : May 21, 2022, 6:04:52 PM
    Author     : cloudy_place
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/changePass.css">
        <title>BoomCinema - Quên mật khẩu</title>
        <link rel="shortcut icon" href="image/logotitle.ico" type="image/x-icon">
    </head>
    <body>


        <div class="home">
            <a href="home" class="home-user">Trang chủ</a>
        </div>
        <div class="container">
            <form action="forgotpassword" method="POST" class="form-change">
                <div class="title">Quên mật khẩu</div>
                <h3 style="color: red;font-weight: 200;margin: 10px">${mess}</h3>
                <h3 style="color:#3CB371;font-weight: 200;margin: 10px">${messSuccess}</h3>
                <div class="user-details">

                    <div class="input-box">
                        <span class="details">Email</span>
                        <input name="email" type="text" placeholder="Nhập email của bạn" required>
                    </div>
                </div>

                <div class="button">
                    <input type="submit" value="Gửi">
                </div>
            </form>
        </div>
    </body>
</html>
