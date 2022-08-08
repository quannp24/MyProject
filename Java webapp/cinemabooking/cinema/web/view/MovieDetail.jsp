<%-- 
    Document   : MovieDetail
    Created on : 24-07-2022, 12:16:15
    Author     : MSI
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1" />
        <!-- icon -->
        <link rel="shortcut icon" href="image/logotitle.ico" type="image/x-icon">
        <!-- link Fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap"
            rel="stylesheet"
            />
        <!--BOOTSTRAP5-->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous"
            />
        <!--FONTAWESOME-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
            integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <!-- CSS -->
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/new1.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/new2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/button-neon_1.css" />

        <!-- Sakura -->
        <link href="${pageContext.request.contextPath}/css/jquery-sakura.css" rel="stylesheet" type="text/css">
        <title>BoomCinema-Phim chi tiết</title>
    </head>
    <body>
        <%@include file="template/header.jsp" %>

        <div class="container" style="height:  40rem;margin-top: 15px;">
            <section style="background-color: #242424;height: 100%" class="member-details" style="padding-top:50px;padding-bottom: 50px;">
                <div class="container" >
                    <div class="row" style="padding-top: 15px">
                        <div class="col-lg-3 col-md-4">
                            <div class="img-container">
                                <img src="${pageContext.request.contextPath}/${movie.image}" width="400px" height="auto;" alt="" class="img-full">
                            </div>
                        </div>
                        <div class="col-lg-9 col-md-8" style="display: block">

                            <div class="col-md-5" style="text-align: center;margin: 5px auto">
                                <h4 class="modal-add-title" style="font-weight: bold ; margin-left:-10%;font-size: 2rem;color: white">${movie.movieName}</h4>
                                <c:if test="${check==true}">
                                    <a style="margin-right: 200px;margin-top: 10px;margin-bottom: 10px" type="button" class="btn btn-outline-danger" onclick="Quickbooking(${movie.getMovieId()})" >Đặt vé ngay</a>
                                </c:if>
                                <div class="clearfix mb-3" style="font-family: 'Merriweather Sans', sans-serif;margin-left:  -44% ;display: inline"> 
                                    <h4 class="currency price-hp" style="font-size: 20px; margin-left: -10.6%;color: white"><label style="color: hsl(351, 69%, 50%)">Thể loại</label>: ${movie.category} </h4> 
                                    <h4 class="currency price-hp" style="font-size: 20px; margin-left: -10.6%;color: white"><label style="color: hsl(351, 69%, 50%)">Thời lượng</label>: ${movie.duration} phút</h4> 
                                    <h4 class="currency price-hp" style="font-size: 20px; margin-left: -5%;color: white"><label style="color: hsl(351, 69%, 50%)">Khởi chiếu</label>: ${movie.startdate}</h4> 
                                    <h4 class="currency price-hp" style="font-size: 20px; margin-left: 14%;color: white"><label style="color: hsl(351, 69%, 50%)">Ngôn ngữ</label>: ${movie.language}</h4>
                                    <h4 class="currency price-hp" style="font-size: 20px; margin-left: 20%;color: white"><label style="color: hsl(351, 69%, 50%)">Rated</label>: ${movie.rate}</h4>
                                    <div class="form-group" style="text-align: center;margin: 5px auto">
                                        <h4 class="modal-add-title" style="font-weight: bold">Mô tả bộ phim</h4>
                                    </div>
                                    <div class="form-group">
                                        <label style="color: white">${movie.description}</label>
                                    </div>
                                </div>
                            </div>
                            <!--tag để biết đường dẫn thôi nhé -->
           





                        </div>

                    </div>
                </div>
            </section>
        </div>

        <div class="modal-nofi" id="admin-add-modal" style="font-family: 'Merriweather Sans', sans-serif;" >
            <div class="modal-nofi-overlay"></div>  
            <!--<button type="button" id="cboxClose">close</button>-->
            <div class="modal-add modal-dialog-scrollable" role="document"  >
                <button onclick="closeModal()"  id="cboxClose" ></button>
                <div class="modal-body row" style="padding: 0.5rem">  

                    <div class="body-modal">

                        <div class="row" style="margin-top: 10px;">

                            <div style="width: 29%">
                                <img src="${pageContext.request.contextPath}/image/movie/minions.jpg" alt="poster" width="100%" height="auto">
                            </div>
                            <div id="left-modal" style="width: 71%;">
                                <div class="title-body-modal"  >
                                    <h3 style="margin-bottom: auto;margin-top: auto;text-align: center">PHIM BLACK ADAM</h3>
                                </div>
                                <div id="cboxLoadedContent" style=" overflow: auto;margin-top: 5px;">
                                    <ul class="toggle-tabs">
                                        <li class="current" >
                                            <div class="day" onclick="SelectDay(movieId, date)">
                                                <span>07</span>
                                                <em>Hai</em>
                                                <strong>06</strong>
                                            </div>

                                        </li>
                                        <li  >
                                            <div class="day" onclick="SelectDay(movieId, date)">
                                                <span>  07</span>
                                                <em>Ba</em>
                                                <strong>10</strong>
                                            </div>

                                        </li>
                                        <li  >
                                            <div class="day" onclick="SelectDay(movieId, date)">
                                                <span>  07</span>
                                                <em>Ba</em>
                                                <strong>11</strong>
                                            </div>

                                        </li>
                                        <li  >
                                            <div class="day" onclick="SelectDay(movieId, date)">
                                                <span>  07</span>
                                                <em>Ba</em>
                                                <strong>11</strong>
                                            </div>

                                        </li>

                                    </ul>
                                </div>

                                <div class="choice-room " >
                                    <div id="cboxLoadedContent" style=" overflow: auto;">
                                        <ul class="toggle-tabs" >
                                            <li class="current" style="margin: 5px;" >
                                                <div class="day" onclick="SelectRoom(movieId, date)" style="width: 100px;height: 35px;text-align: center;font-weight: bold;font-size: 20px;">
                                                    <span>Phòng 2D</span>
                                                </div>
                                            </li >
                                            <li style="margin: 5px;">
                                                <div class="day" onclick="SelectRoom(movieId, date)" style="width: 100px;height: 35px;text-align: center">
                                                    <span >Phòng 3D</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="choice-slot " >
                                    <div id="cboxLoadedContent" style=" overflow: auto;height: 100%;">
                                        <ul class="toggle-tabs" >
                                            <li class="current" style="margin: 5px;" >
                                                <form action="bookseat" method="post">
                                                    <input type="text" name="movieId" value="" hidden>
                                                    <input type="text" name="date" value="" hidden>
                                                    <input type="text" name="typeRoom" value="" hidden>
                                                    <input type="text" name="movietimeId" value="" hidden>
                                                    <button class="time" style="border:1px;"  type="submit" >
                                                        <span>12:10</span>
                                                    </button>
                                                </form>
                                            </li >
                                            <li style="margin: 5px;">
                                                <div class="time" onclick="SelectRoom(movieId, date)" >
                                                    <span >14:15</span>
                                                </div>
                                            </li>
                                            <li style="margin: 5px;">
                                                <div class="time" onclick="SelectRoom(movieId, date)" >
                                                    <span >16:20</span>
                                                </div>
                                            </li>
                                            <li style="margin: 5px;">
                                                <div class="time" onclick="SelectRoom(movieId, date)" >
                                                    <span >21:10</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>


                        </div>

                    </div>
                </div>  

            </div>


        </div>

        <%@include file="template/footer.jsp" %>
        <style>
            #cboxClose{
                position:absolute;
                z-index: 99;
                top:5%;
                right:1%;
                display:block;
                background:url("${pageContext.request.contextPath}/image/close.png") no-repeat top center;
                width:32px;
                height:32px;
                overflow: visible;
                padding: 0;
                margin: 0;
                border: 0;
                cursor: pointer;
            }
            #cboxClose:hover{

                text-shadow: 0 0 0.125em hsl(0 0% 100% / 0.3), 0 0 0.24em currentColor;
            }

            #cboxClose-banner{
                position:absolute;
                z-index: 99;
                top:2%;
                right:1%;
                display:block;
                background:url("${pageContext.request.contextPath}/image/close-white.png") no-repeat top center;
                width:32px;
                height:32px;
                overflow: visible;
                padding: 0;
                margin: 0;
                border: 0;
                cursor: pointer;
            }
            #cboxClose-banner:hover{

                text-shadow: 0 0 0.125em hsl(0 0% 100% / 0.3), 0 0 0.24em currentColor;
            }



            #admin-add-modal .title-body-modal{
                border: 2px solid black;
                color: var(--clr-neon);
                text-shadow: 0 0 0.125em hsl(0 0% 100% / 0.3), 0 0 0.24em currentColor;

            }

            .body-modal .choice-room{
                border-top: 2px solid black;
                border-bottom: 2px solid black;
                margin-top: 5px;
            }

            .body-modal .choice-slot{
                /*                border-top: 2px solid black;*/
                border-bottom: 2px solid black;

                margin-top: 5px;
            }


            .cboxContent{
                margin-top: 3px;
                position: relative;


            }
            #admin-add-modal .current{
                background: var(--clr-neon);
                color: white;
                text-shadow: none;
            }
            #admin-add-modal .day {
                /*border: 2px solid hsl(351, 69%, 50%);*/

                border-radius: 5px;
                color: black;
                border: hsl(351, 69%, 50%) 0.125em solid;
                box-shadow: inset 0 0 0.5em 0 hsl(351, 69%, 50%), 0 0 0.5em 0 hsl(351, 69%, 50%);
                cursor: pointer;
                height: 48px;
                position: relative;
                width: 77px;
                margin: 2px;
            }

            #admin-add-modal .time{
                /*border: 2px solid hsl(351, 69%, 50%);*/

                border-radius: 5px;
                color: black;
                border: hsl(351, 69%, 50%) 0.125em solid;
                box-shadow: inset 0 0 0.5em 0 hsl(351, 69%, 50%), 0 0 0.5em 0 hsl(351, 69%, 50%);
                cursor: pointer;
                height: 35px;
                position: relative;
                width: 100px;
                margin: 2px;
                text-align: center;
                padding-top: 2px;
            }

            #admin-add-modal .time:hover,
            #admin-add-modal .time:focus{
                background: var(--clr-neon);
                color: white;
                text-shadow: none;
            }



            #admin-add-modal .day:hover,
            #admin-add-modal .day:focus{
                background: var(--clr-neon);
                color: white;
                text-shadow: none;
            }
            #admin-add-modal .day > span {
                /*color: #717171;*/
                font-size: 11px;
                left: 4px;
                position: absolute;
                top: 4px;
            }
            #admin-add-modal .day > em {
                /*color: #717171;*/
                font-size: 11px;
                font-style: normal;
                left: 4px;
                position: absolute;
                top: 20px;
            }
            #admin-add-modal .day > strong {
                /*color: #717171;*/
                font-size: 32px;
                font-weight: normal;
                left: 31px;
                line-height: 32px;
                position: absolute;
                top: 8px;
            }
            #admin-add-modal ul,ol,li{
                list-style:none;
                float:left;
                border-radius: 6px;
            }



            #admin-add-modal ul{
                margin-top: 5px;
                margin-bottom: 7px;
                /*                border-bottom:2px solid black;*/
            }


            #admin-add-modal{
                display: none;
            }
            #admin-banner-modal{
                display: none;
            }

            #admin-load-modal{
                display: none;

                justify-content: center;
                align-items: center;
                text-align: center;
                min-height: 100vh;

            }

            .modal-nofi{
                position:fixed;
                top:0;
                right:0;
                left:0;
                bottom:0;
                z-index: 9999999;
                display: flex;

            }
            .banner-modal-nofi{
                position:fixed;
                top:0;
                right:0;
                left:0;
                bottom:0;
                height: auto;
                z-index: 9999999;
                display: flex;


            }
            .image-banner{
                height: 100%;
                /*border-bottom: 1px solid #f5f5f5;*/

                display: flex;
            }
            .image-banner img{
                height: auto;
                width: 100%;
            }

            .modal-nofi-overlay{
                position: absolute;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.7);
            }

            .loader img{
                width: 50px;
                height: auto;
            }


            .modal-nofi-overlay-load{
                position: absolute;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.4);
            }
            .modal-add{
                width: 68%;

                /* modal height here*/
                height: auto;
                top: 48%;
                left: 33%;
                transform: translate(-50%, -50%);
                margin: auto;
                position: relative;
                /*background-color: rgba(231, 231, 231, 1);*/
                background-image: url("${pageContext.request.contextPath}/image/d.jpg");
                /*                border-radius:5px;*/
            }
            .modal-add-banner{
                width: 68%;

                /* modal height here*/
                height: auto;
                top: 21rem;
                left: 33%;
                transform: translate(-50%, -50%);
                margin: auto;
                position: relative;
                /*background-color: rgba(231, 231, 231, 1);*/
                background-image: url("${pageContext.request.contextPath}/image/d.jpg");
                border-radius:3px;
            }
        </style>
        <!-- BOOTSTRAP5-->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"
        ></script>
        <!-- SCRIPT -->
        <script src="${pageContext.request.contextPath}/js/script.js"></script>
        <!-- SAKURA -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/jquery-sakura.js"></script>
        <script>
                                                    $(window).load(function () {
                                                        $('body').sakura();
                                                    });
                                                    function openAddModal() {
                                                        document.getElementById("admin-add-modal").style.display = "flex";
                                                    }
                                                    function closeModal() {
                                                        var x = document.querySelectorAll(".modal-nofi");
                                                        for (var i = 0; i < x.length; i++) {
                                                            if (x[i].style.display !== "none") {
                                                                x[i].style.display = "none";
                                                            }
                                                        }
                                                    }

                                                    function closeBannerModal() {
                                                        document.getElementById("admin-banner-modal").style.display = "none";
                                                    }

                                                    function Quickbooking(movieId) {
                                                        $.ajax({
                                                            url: "${pageContext.request.contextPath}/bookmovie",
                                                            type: "get",
                                                            data: {
                                                                movieId: movieId
                                                            },
                                                            beforeSend: function () {
                                                                $("#loading-mask").show();
                                                            },
                                                            success: function (data) {
                                                                $("#loading-mask").hide();
                                                                $("#admin-add-modal").show();
                                                                var c = document.getElementById("admin-add-modal");
                                                                c.innerHTML = data;

                                                            }
                                                        });
                                                    }

                                                    function SelectDay(movieId, date) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "${pageContext.request.contextPath}/bookmovie",
                                                            data: {
                                                                movieId: movieId,
                                                                dateChoice: date
                                                            },
                                                            beforeSend: function () {
                                                                $("#loading-mask").show();
                                                            },
                                                            success: function (data) {
                                                                $("#loading-mask").hide();
                                                                var c = document.getElementById("left-modal");
                                                                c.innerHTML = data;

                                                            }
                                                        });
                                                    }
                                                    function SelectRoom(movieId, date, type) {
                                                        $.ajax({
                                                            type: "POST",
                                                            url: "${pageContext.request.contextPath}/bookmovie",
                                                            data: {
                                                                movieId: movieId,
                                                                dateChoice: date,
                                                                typeRoom: type
                                                            },
                                                            beforeSend: function () {
                                                                $("#loading-mask").show();
                                                            },
                                                            success: function (data) {
                                                                $("#loading-mask").hide();
                                                                var c = document.getElementById("left-modal");
                                                                c.innerHTML = data;

                                                            }
                                                        });
                                                    }
                                                    function openBannerModal(bannerId) {
                                                        $.ajax({
                                                            type: "get",
                                                            url: "${pageContext.request.contextPath}/bannerdetail",
                                                            data: {
                                                                bannerId: bannerId
                                                            },
                                                            beforeSend: function () {
                                                                $("#loading-mask").show();
                                                            },
                                                            success: function (data) {
                                                                $("#loading-mask").hide();
                                                                $("#admin-banner-modal").show();

                                                                var c = document.getElementById("admin-banner-modal");
                                                                c.innerHTML = data;

                                                            }
                                                        });
                                                    }

                                                    function openEditSchedule(bannerId) {
                                                        $.ajax({
                                                            type: "get",
                                                            url: "${pageContext.request.contextPath}/editslot",
                                                            data: {
                                                                timeroomId: bannerId
                                                            },
                                                            beforeSend: function () {
                                                                $("#loading-mask").show();
                                                            },
                                                            success: function (data) {
//                        $("#loading-mask").hide();
                                                                $("#admin-banner-modal").show();

//                        var c = document.getElementById("admin-banner-modal");
//                        c.innerHTML = data;

                                                            }
                                                        });
                                                    }

        </script>

    </body>
</html>
