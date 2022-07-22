<%-- 
    Document   : admincontrol
    Created on : 20-03-2022, 10:27:08
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Quản lý cửa hàng - BM</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="../img/d.png" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
        <!-- https://fonts.google.com/specimen/Roboto -->
        <link rel="stylesheet" href="../css/accountsetting/fontawesome.min.css">
        <!-- https://fontawesome.com/ -->
        <link rel="stylesheet" href="../css/accountsetting/bootstrap.min.css">
        <!-- https://getbootstrap.com/ -->
        <link rel="stylesheet" href="../css/accountsetting/templatemo-style.css">

        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>

    <body id="reportsPage">
        <div class="" id="home">
            <nav class="navbar navbar-expand-xl">
                <div class="container h-100">
                    <a class="navbar-brand" href="../home">
                        <img src="img/dwhite.png" alt=""/>
                        <h1 class="tm-site-title mb-0">Business Modern</h1>
                    </a>
                    <button class="navbar-toggler ml-auto mr-0" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="material-icons">
                            menu
                        </span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mx-auto h-100">
                            <li class="nav-item">
                                <a class="nav-link " href="../admincontrol">
                                    <span class="material-icons">groups</span> Nhân viên
                                    <span class="sr-only">(current)</span>
                                </a>
                            </li>
                            <!--                            <li class="nav-item">
                                                            <a class="nav-link" href="">
                                                                <span class="material-icons">storefront</span> Cửa hàng
                                                            </a>
                                                        </li>-->

                            <li class="nav-item">
                                <a class="nav-link active" href="/account">
                                    <span class="material-icons">account_circle</span> Tài khoản

                                </a>
                            </li>

                        </ul>
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link d-block" href="../manage">
                                    Về lại trang quản lý
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

            </nav>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <h4 class=" mt-5 mb-5">Xin chào, <b>${requestScope.account.displayname}</b></h4>
                    </div>
                </div>
                <!-- row -->

                <div class="row tm-content-row">

                    <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 tm-block-col">
                        <div class="tm-bg-primary-dark tm-block tm-block-settings">
                            <h2 class="tm-block-title">Thay đổi thông tin tài khoản</h2>
                            <form action="account" method="POST" class="tm-signup-form row" id="noww">
                                <div class="form-group col-lg-6">
                                    <label for="name">Tên hiển thị</label>
                                    <input
                                        id="name"
                                        name="name"
                                        type="text"
                                        value="${requestScope.account.displayname}"
                                        class="form-control validate"
                                        />
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="name">Tài khoản</label>
                                    <input
                                        id="email"
                                        name="username"
                                        type="text"
                                        readonly
                                        value="${requestScope.account.username}"
                                        class="form-control validate"
                                        />
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="password">Mật khẩu hiện tại</label>
                                    <input
                                        id="password"
                                        name="passcurrent"
                                        type="password"
                                        class="form-control validate"
                                        />
                                </div>
                                <div class="form-group col-lg-6">

                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="password">Mật khẩu mới</label>
                                    <input
                                        id="password2"
                                        name="password"
                                        type="password"
                                        class="form-control validate"
                                        />
                                </div>
                                <div class="form-group col-lg-6">
                                    <label for="password">Nhập lại mật khẩu mới</label>
                                    <input
                                        id="phone"
                                        name="password2"
                                        type="password"
                                        class="form-control validate"
                                        />
                                </div>
                                <div class="col-lg-12 text-center">
                                    <span id = "message" style="color:red">${requestScope.mess}</span>
                                </div>
                                <div class="form-group col-lg-12 row">
                                    <div class="col-lg-3"></div>
                                    <label class=" col-lg-6">
                                        <button
                                            type="button"
                                            onclick="checkvalue()"
                                            class="btn btn-primary btn-block text-uppercase"
                                            >
                                            Lưu thông tin
                                        </button>
                                    </label>
                                    <div class="col-lg-3"></div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>



            </div>
            <footer class="tm-footer row tm-mt-small">
                <div class="col-12 font-weight-light">
                    <p class="text-center text-white mb-0 px-4 small">

                    </p>
                </div>
            </footer>
        </div>

        <script src="../js/accountsetting/jquery-3.3.1.min.js"></script>
        <script src="../js/accountsetting/bootstrap.min.js"></script>
        <!-- https://getbootstrap.com/ -->
        <script src="../js/accountsetting/new.js" type="text/javascript"></script>
    </body>



</html>
