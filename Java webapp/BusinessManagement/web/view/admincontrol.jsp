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
        <link rel="icon" type="image/x-icon" href="img/d.png" />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,700">
        <!-- https://fonts.google.com/specimen/Roboto -->
        <link rel="stylesheet" href="../css/admincontrol/fontawesome.min.css">
        <!-- https://fontawesome.com/ -->
        <link rel="stylesheet" href="../css/admincontrol/bootstrap.min.css">
        <!-- https://getbootstrap.com/ -->
        <link rel="stylesheet" href="../css/admincontrol/templatemo-style.css">

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
                                <a class="nav-link active" href="../admincontrol">
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
                                <a class="nav-link" href="../admincontrol/account">
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
                        <h6 class=" mt-5 mb-5">Mã cửa hàng của bạn: <b>${requestScope.account.bid}</b></h6>
                    </div>
                </div>
                <!-- row -->
                <div class="row tm-content-row">
                    <div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 tm-block-col">
                        <div class="tm-bg-primary-dark tm-block">
                            <h2 class="tm-block-title">Thêm nhân viên</h2>
                            <form action="staff" method="POST" id="noww">
                                <div class="row">
                                    <a class="col-5 col-lg-3 text-center">Tên nhân viên:</a>
                                    <input class="col-7 col-lg-5 form-control form-control-plaintext"  style="border-radius: 4px" name="name" type="text" value="">
                                </div>
                                <div class="row mt-2">
                                    <a class="col-5 col-lg-3 text-center">Tên đăng nhập:</a>
                                    <input class="col-7 col-lg-5 form-control form-control-plaintext"  style="border-radius: 4px" name="username" type="text" value="">
                                </div>
                                <div class="row mt-2">
                                    <a class="col-5 col-lg-3 text-center">Mật khẩu đăng nhập:</a>
                                    <input class="col-7 col-lg-5 form-control form-control-plaintext"  style="border-radius: 4px" name="password" type="text" value="">
                                </div>
                                <div class="row mt-2 ">

                                    <a class="col-5 col-lg-3 text-center"></a>

                                    <div class="col-7 col-lg-5 text-center">

                                        <span id = "message" style="color:red">${requestScope.mess} </span>
                                    </div>
                                </div>
                                <div class="row mt-2 ">
                                    <a class="col-5 col-lg-3 text-center"></a>

                                    <div class="col-7 col-lg-5 text-center">

                                        <input class=" btn btn-secondary mt-4 " style="border-radius: 10px" type="button" onclick="checkvalue()" value="Thêm nhân viên">
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>

                    <div class="col-12 tm-block-col">
                        <div class="tm-bg-primary-dark tm-block tm-block-taller tm-block-scroll">
                            <h2 class="tm-block-title">Nhân viên cửa hàng</h2>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th class="text-center" scope="col">Tên nhân viên</th>
                                        <th class="text-center" scope="col">Tên đăng nhập</th>
                                        <th class="text-center">Mật khẩu <input style="background-color: gray" type="checkbox" onclick="myFunction()"></th>
                                        <th class="text-center" scope="col"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.staffs}" var="s" varStatus="i">
                                        <tr>
                                            <td class="text-center">${s.displayname}</td>
                                            <td class="text-center">${s.userStaff}</td>
                                            <td class="text-center">
                                                <input type="password" id="myInput" class="text-center" value="${s.passStaff}" readonly>
                                            </td>
                                            <td><a href="" onclick="del(${i.index})" class="btn btn-danger btn-sm">Xóa</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
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

        <script src="../js/admincontrol/jquery-3.3.1.min.js"></script>
        <!-- https://jquery.com/download/ -->
        <script src="../js/admincontrol/moment.min.js"></script>

        <!-- http://www.chartjs.org/docs/latest/ -->
        <script src="../js/admincontrol/bootstrap.min.js"></script>
        <!-- https://getbootstrap.com/ -->
        <script src="../js/admincontrol/tooplate-scripts.js"></script>
        <script src="../js/admincontrol/new.js" type="text/javascript"></script>
    </body>
    


</html>
