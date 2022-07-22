<%-- 
    Document   : manage
    Created on : 11-03-2022, 22:53:44
    Author     : Quan
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>


<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý cửa hàng - BM</title>
        <link rel="icon" type="image/x-icon" href="img/d.png" />
        <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800,900" rel="stylesheet">
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet">
        <!-- https://fonts.google.com/ -->
        <!--        <link rel="stylesheet" href="css/manage/bootstrap.min.css" type="text/css">-->
        <!--<link rel="stylesheet" href="css/manage/templatemo-video-catalog.css" type="text/css">-->
        <link rel="stylesheet" href="css/manage/newcss.css" type="text/css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">

    </head>

    <body>

        <div class="" id="tm-video-container">
            <video autoplay muted loop id="tm-video">


                <source src="img/video.mp4" type="video/mp4">

            </video>
        </div>

        <a href="home" class="position-absolute" style="z-index: 3;">

            <img src="img/d.png">

        </a>

        <!-- <div class="position-absolute logout" style="z-index: 3;">
            <a>User:</a>|
            <a href="" style="text-decoration: none;"> Đăng xuất</a>
    
        </div> -->

        <div class="container-fluid">
            <div class="position-absolute" id="color">

                <div class="position-absolute logout" id="logout">
                    <a style="color: #0d6efd">Xin chào ${sessionScope.account.displayname}${sessionScope.accountStaff.displayname} </a>|
                    <a href="logout" style="text-decoration: none;"> Đăng xuất</a>

                </div>

                <div class="container-fluid">
                    <div class="row">

                        <div class="col-12 col-sm-6 col-md-4">
                            <a class="btn btn-success nut" id="button-link" href="import">
                                <span class="material-icons">production_quantity_limits</span>Nhập hàng</a>

                        </div>
                        <div class="col-12 col-sm-6 col-md-4">
                            <a class=" btn btn-success nut" id="button-link" href="#myModal" data-toggle="modal">
                                <span class="material-icons">sell</span>Bán hàng</a>
                        </div>
                        <div class="col-12 col-sm-6 col-md-4">

                            <a class=" btn btn-success nut" id="button-link" href="warehouse">
                                <span class="material-icons">warehouse</span>Kho</a>
                        </div>
                    </div>


                    <%if (request.getSession().getAttribute("account") != null) {%>

                    <div class="row" style="margin-top: 40px;" >
                        <div class="col-12 col-sm-6 admin" style="text-align: center;">
                            <a class=" btn btn-danger" id="button-link " href="expense">
                                <span class="material-icons">paid</span>Chi tiêu cửa hàng</a>
                        </div>
                        <div class="col-12 col-sm-6 admin" style="text-align: center;">
                            <a class=" btn btn-danger" id="button-link " href="admincontrol">
                                <span class="material-icons">manage_accounts</span>Cài đặt cửa hàng</a>
                        </div>

                    </div>
                    <%}%>


                </div>
            </div>
            <div id="myModal" class="modal fade">   <!--table sell  -->
                <div class="modal-dialog modal-login">
                    <div class="modal-content">
                        <div class="modal-header">


                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body" style="text-align: center">               
                            <a class="btn btn-primary btn-lg px-4 me-sm-3" href="writebill" style="width: 70%">Ghi hóa đơn</a>
                            <a class="btn btn-primary btn-lg px-4 me-sm-3" style="margin-top: 20px; width: 70% " href="bills">Kiểm tra hóa đơn</a>
                        </div>
                    </div>
                </div>
            </div> 

        </div>

        <style>
            body {
                font-family: 'Varela Round', sans-serif;
            }
            .modal-login {		
                color: #636363;
                width: 350px;
            }
            .modal-login .modal-content {
                padding: 20px;
                border-radius: 5px;
                border: none;
            }
            .modal-login .modal-header {
                border-bottom: none;   
                position: relative;
                justify-content: center;
            }
            .modal-login h4 {
                text-align: center;
                font-size: 26px;
                margin: 30px 0 -15px;
            }
            .modal-login .form-control:focus {
                border-color: #70c5c0;
            }
            .modal-login .form-control, .modal-login .btn {
                min-height: 40px;
                border-radius: 3px; 
            }
            .modal-login .close {
                position: absolute;
                top: -5px;
                right: -5px;
            }	
            .modal-login .modal-footer {
                background: #ecf0f1;
                border-color: #dee4e7;
                text-align: center;
                justify-content: center;
                margin: 0 -20px -20px;
                border-radius: 5px;
                font-size: 13px;
            }
            .modal-login .modal-footer a {
                color: #999;
            }		


            .modal-login.modal-dialog {
                margin-top: 80px;
            }
            .modal-login .btn, .modal-login .btn:active {
                color: #fff;
                border-radius: 4px;
                background: #60c7c1 !important;
                text-decoration: none;
                transition: all 0.4s;
                line-height: normal;
                border: none;
            }
            .modal-login .btn:hover, .modal-login .btn:focus {
                background: #45aba6 !important;
                outline: none;
            }
            .trigger-btn {
                display: inline-block;
                margin: 100px auto;
            }
        </style>

        <!-- .tm-page-wrap -->
        <!-- </div> -->


        <script src="js/manage/jquery-3.4.1.min.js"></script>
        <script src="js/manage/bootstrap.min.js"></script>
        <script>
            function setVideoSize() {
                const vidWidth = 1920;
                const vidHeight = 1080;
                let windowWidth = window.innerWidth;
                let newVidWidth = windowWidth;
                let newVidHeight = windowWidth * vidHeight / vidWidth;
                let marginLeft = 0;
                let marginTop = 0;

                if (newVidHeight < 500) {
                    newVidHeight = 500;
                    newVidWidth = newVidHeight * vidWidth / vidHeight;
                }

                if (newVidWidth > windowWidth) {
                    marginLeft = -((newVidWidth - windowWidth) / 2);
                }

                if (newVidHeight > 720) {
                    marginTop = -((newVidHeight - $('#tm-video-container').height()) / 2);
                }

                const tmVideo = $('#tm-video');

                tmVideo.css('width', newVidWidth);
                tmVideo.css('height', newVidHeight);
                tmVideo.css('margin-left', marginLeft);
                tmVideo.css('margin-top', marginTop);
            }

            $(document).ready(function () {
                /************** Video background *********/

                setVideoSize();

                // Set video background size based on window size
                let timeout;
                window.onresize = function () {
                    clearTimeout(timeout);
                    timeout = setTimeout(setVideoSize, 100);
                };

                // Play/Pause button for video background      
                const btn = $("#tm-video-control-button");

                btn.on("click", function (e) {
                    const video = document.getElementById("tm-video");
                    $(this).removeClass();

                    if (video.paused) {
                        video.play();
                        $(this).addClass("fas fa-pause");
                    } else {
                        video.pause();
                        $(this).addClass("fas fa-play");
                    }
                });
            })
        </script>
    </body>

</html>
