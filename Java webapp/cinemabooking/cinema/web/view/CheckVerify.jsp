<%-- 
    Document   : CheckVerify
    Created on : May 21, 2022, 7:28:50 PM
    Author     : cloudy_place
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/changePass.css">
        <title>BoomCinema-Kiểm tra mã</title>
        <link rel="shortcut icon" href="image/logotitle.ico" type="image/x-icon">
    </head>
    <body>

        <div class="home">
            <a href="home" class="home-user">Trang chủ</a>
        </div>
        <div class="container">
            <form action="checkverify" method="POST" class="form-change">
                <div class="title">Kiểm tra mã</div>
                <h3 style="color: red;font-weight: 200;margin: 10px">${mess}</h3>
                <h3 style="color:#3CB371;font-weight: 200;margin: 10px">${messSuccess}</h3>
                <div class="user-details">

                    <div class="input-box">
                        <span class="details">Nhập mã xác thực</span>
                        <div class="email">
                            <p>Chúng tôi đã gửi cho bạn mã đến: </p>
                            <p>${existEmail}
                        </div>
                        <input name="verify" type="text" placeholder="Nhập mã xác thực" required>
                    </div>
                </div>

                <div class="button">
                    <input type="submit" value="Xác thực">
                </div>
            </form>
        </div> 


    </body>
</html>
