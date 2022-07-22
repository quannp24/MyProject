<%-- 
    Document   : CreateNewPass
    Created on : May 22, 2022, 2:45:46 PM
    Author     : cloudy_place
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BoomCinema-Tạo mật khẩu</title>
        <link rel="stylesheet" href="css/changePass.css">
        <link rel="shortcut icon" href="image/logotitle.ico" type="image/x-icon">
    </head>
    <body>

        <div class="home">
            <a href="home" class="home-user">Trang chủ</a>
        </div>
        <div class="container">
            <form action="newpass" method="POST" class="form-change">
                <div class="title">Tạo mật khẩu mới</div>
                <h3 style="color: red;font-weight: 200;margin: 10px">${mess}</h3>
                <h3 style="color:#3CB371;font-weight: 200;margin: 10px">${messSuccess}</h3>
                <div class="user-details">

                    <input type="hidden"  name="id" value="${requestScope.id}"/>
                    <div class="input-box">
                        <span class="details">Mật khẩu mới</span>
                        <input value="" name="newPass" type="password" placeholder="" required>
                    </div>


                    <div class="input-box">
                        <span class="details">Xác nhận mật khẩu mới</span>
                        <input value="" name="rePass" type="password" placeholder="" required>
                    </div>



                </div>

                <div class="button">
                    <input type="submit" value="Lưu mật khẩu">
                </div>
            </form>
        </div>

    </body>
</html>
