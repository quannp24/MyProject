<%-- 
    Document   : ChangePassword
    Created on : May 22, 2022, 7:27:19 PM
    Author     : senan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="css/changePass.css">
        <link rel="shortcut icon" href="image/logotitle.ico" type="image/x-icon">
        <title>BoomCinema-Đổi mật khẩu</title>
    </head>
    <body>
        <div class="home">
            <a href="home" class="home-user">Trang chủ</a>
        </div>
        <div class="container">
            <form action="changepass" method="POST" class="form-change">
                <div class="title">Đổi mật khẩu</div>
                <h3 style="color: red;font-weight: 200;margin: 10px">${mess}</h3>
                <h3 style="color:#3CB371;font-weight: 200;margin: 10px">${messSuccess}</h3>
                <div class="user-details">

                    <input type="hidden"  name="id" value="${requestScope.id}"/>
                    <div class="input-box">
                        <span class="details">Mật khẩu hiện tại</span>
                        <input value="${oldpass}" name="oldp" type="password" placeholder="" required>
                    </div>


                    <div class="input-box">
                        <span class="details">Nhập mật khẩu mới</span>
                        <input value="${newpass}" name="newp" type="password" placeholder="" required>
                    </div>


                    <div class="input-box">
                        <span class="details">Xác nhận mật khẩu mới</span>
                        <input value="${renewpass}" name="conp" type="password" placeholder="" required>
                    </div>
                </div>

                <div class="button">
                    <input type="submit" value="Lưu mật khẩu">
                </div>
            </form>
        </div>
    </body>
</html>

