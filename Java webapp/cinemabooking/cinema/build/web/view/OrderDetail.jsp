
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BoomCinema-Vé chi tiết</title>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1" />
        <!-- icon -->
        <link rel="shortcut icon" href="${pageContext.request.contextPath}/image/logotitle.ico" type="image/x-icon">
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




    </head>
    <body >
        <%@include file="template/header.jsp" %>
        <div class="container-fluid my-5 d-flex justify-content-center" style="font-family: 'Merriweather Sans', sans-serif;">
            <div class="card card-1" style="width: 880px;background-color: #212529;">
                <div class="card-header">
                    <div class="media flex-sm-row flex-column-reverse justify-content-between ">
                        <div class="col my-auto">
                            <h4 class="neon-title" style="color: white;">Chi tiết vé </h4>
                        </div>

                    </div>
                </div>
                <div class="card-body">
                    <div class="row justify-content-between mb-3">
                        <h6 style="color: white; ">PHIM</h6>

                    </div>

                    <div >
                        <div class="ticket">
                            <div class="image" > <img style="background-size: contain;height: 300px;" src="${pageContext.request.contextPath}/${movie.image}"/> </div>
                            <div class="left">
                                <div class="ticket-info">
                                    <p class="date">
                                        <span><fmt:formatDate pattern="EEEE" value = "${date}"/></span>
                                        <span class="june-29">THÁNG <fmt:formatDate pattern="M" value = "${date}"/> NGÀY <fmt:formatDate pattern="dd" value = "${date}"/></span>
                                        <span><fmt:formatDate pattern="YYYY" value = "${date}"/></span>
                                    </p>
                                    <div class="show-name">
                                        <h1>${fn:toUpperCase(movie.movieName)}</h1>

                                    </div>
                                    <div class="time">
                                        <p>SUẤT CHIẾU LÚC <fmt:formatDate pattern="HH:mm" value = "${slot.start}"/></p>

                                    </div>
                                    <p class="location"><span>Rạp phim BoomCinema, Thạch Thất, Hà Nội</span>

                                    </p>
                                </div>

                            </div>

                            <div class="right" style="width: 30%;">
                                <p class="admit-one" style="font-size: 11px;">
                                    <span>BOOM CINEMA</span>
                                    <span>BOOM CINEMA</span>
                                    <span>BOOM CINEMA</span>
                                </p>
                                <div class="right-info-container" >
                                    <div class="show-name" >
                                        <h1 style="font-size: 15px">Phòng <span>${room.roomName}</span></h1>

                                    </div>
                                    <div class="time">
                                        <p style="font-size: 15px">Ghế <span>
                                                <c:forEach items="${listSeat}" var="s" varStatus="i">
                                                    <c:if test="${i.index==0 && i.last==true}">
                                                        ${s.seatRow}${s.seatNumber}
                                                    </c:if>
                                                    <c:if test="${i.index==0 && i.last==false}">
                                                        ${s.seatRow}${s.seatNumber}
                                                    </c:if>
                                                    <c:if test="${i.index!=0}">
                                                        ,${s.seatRow}${s.seatNumber}
                                                    </c:if>
                                                </c:forEach>

                                            </span>

                                        </p>

                                    </div>
                                    <div class="barcode">

                                        <img src="${pageContext.request.contextPath}/${fn:trim(order.QRcode)}" alt="QR code">
                                    </div>

                                </div>
                            </div>
                        </div>
                        <table class="table" >
                            <tr>
                                <th style="width: 50%;color: white">Ghế</th>
                                <th style="width: 50%;color: white">Giá</th>
                            </tr>
                            <c:forEach items="${listSeat}" var="d">
                            <tr>
                                
                                <td style="color: white"> ${d.seatRow}${d.seatNumber}</td>
                                <td style="color: white"><fmt:formatNumber type = "number" maxIntegerDigits = "10" value = "${d.seatPrice*1000}"/> VNĐ</td>
                            </tr>
                            </c:forEach>
                        </table>
                        

                        <hr class="my-3 " style="color: white;">

                    </div>



                    <div class="row mt-4">
                        <h6 style="color: white; ">DỊCH VỤ KHÁC</h6>
                        <div class="col">
                            <div class="card card-2">

                                <div class="card-body" style="background: gainsboro">
                                    <div class="media">
                                        <table class="table ">
                                            <thead>
                                                <tr>
                                                    <th style="width: 20%;text-align: center">#</th>
                                                    <td style="width: 40%;text-align: center">Sản phẩm</td>
                                                    <td style="width: 20%;text-align: center">Số lượng</td>
                                                    <td style="width: 20%;text-align: center">Giá</td>

                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${listFD}" var="f">
                                                    <tr>
                                                        <td style="text-align: center;">
                                                            <div style="width: 250px;height: auto;border-radius: 5px">
                                                                <img style="border-radius: 8px" src="${pageContext.request.contextPath}/${f.image}" alt="product">
                                                            </div>
                                                        </td>
                                                        <td style="text-align: center">${f.fadName}</td>
                                                        <c:forEach items="${listFood}" var="food" >
                                                            <c:if test="${food.fastfoodId==f.fadId}">
                                                                <td style="text-align: center">${food.quantity}</td>
                                                            </c:if>
                                                        </c:forEach>

                                                        <td style="text-align: center"><fmt:formatNumber type = "number" maxIntegerDigits = "10" value = "${f.price*1000}"/> VNĐ</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>

                                    </div>
                                    <hr class="my-3 ">

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4" style="color: white;">
                        <h6 style="color: white; ">TỔNG</h6>
                        <div class="col">
                            <div class="row justify-content-between">

                                <div class="flex-sm-col text-right col">
                                    <p class="mb-1" ><b>Ngày lập hóa đơn</b></p>
                                </div>
                                <div class="flex-sm-col col-auto">
                                    <p class="mb-1" > <fmt:formatDate pattern="EEEE, dd-MM-yyyy" value = "${order.orderDate}"/></p>
                                </div>
                            </div>
                            <div class="row justify-content-between">

                                <div class="flex-sm-col text-right col">
                                    <p class="mb-1" ><b>Tổng tiền</b></p>
                                </div>
                                <div class="flex-sm-col col-auto">
                                    <p class="mb-1" ><fmt:formatNumber type = "number" maxIntegerDigits = "10" value = "${order.totalPrice*1000}"/>VNĐ</p>
                                </div>
                            </div>
                            <div class="row justify-content-between">

                                <div class="flex-sm-col text-right col">
                                    <p class="mb-1" ><b>Trạng thái</b></p>
                                </div>
                                <div class="flex-sm-col col-auto">
                                    <c:if test="${order.status == 1}">
                                        <p ><span class="status text-success">&bull;</span>Còn hiệu lực</p>
                                    </c:if>

                                    <c:if test="${order.status == 0}">
                                        <p ><span class="status text-danger">&bull;</span>Hết hiệu lực</p>
                                    </c:if>

                                </div>
                            </div>
                            <div class="row justify-content-between">

                                <div class="flex-sm-col text-right col">

                                </div>
                                <div class="flex-sm-col col-auto">
                                    <a  href="${pageContext.request.contextPath}/myorder"><button  class="custom-btn btn-watch"><span>Quay lại !</span><span>Quay lại</span></button></a>
                                </div>
                            </div>


                        </div>
                    </div>

                </div>

            </div>


        </div>
        <%@include file="template/footer.jsp" %>
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
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Merriweather+Sans&display=swap');



            .ticket {

                height: 300px;
                width: 100%;
                margin: auto;
                display: flex;
                background: gainsboro;
                box-shadow: rgba(0, 0, 0, 0.3) 0px 19px 38px, rgba(0, 0, 0, 0.22) 0px 15px 12px;
            }

            .left {
                display: flex;
                height: 300px;
                width: 430px;

            }

            .image {
                height: 300px;
                /*                width: 250px;*/
                /*background-image: url("https://media.pitchfork.com/photos/60db53e71dfc7ddc9f5086f9/1:1/w_1656,h_1656,c_limit/Olivia-Rodrigo-Sour-Prom.jpg");*/
                background-size: contain;
                /*                opacity: 0.85;*/
            }

            .admit-one {
                position: absolute;
                color: darkgray;
                height: 300px;
                padding: 0 10px;
                letter-spacing: 0.15em;
                display: flex;
                text-align: center;
                justify-content: space-around;
                writing-mode: vertical-rl;
                transform: rotate(-180deg);
            }

            .admit-one span:nth-child(2) {
                color: white;
                font-weight: 700;
            }

            .left .ticket-number {
                height: 300px;
                width: auto;
                display: flex;
                justify-content: flex-end;
                align-items: flex-end;
                padding: 5px;
            }

            .ticket-info {
                padding: 8px 15px;
                display: flex;
                width: 100%;
                flex-direction: column;
                text-align: center;
                justify-content: space-between;
                align-items: center;
            }

            .date {
                border-top: 1px solid gray;
                border-bottom: 1px solid gray;
                padding: 5px 0;
                font-weight: 700;
                display: flex;
                align-items: center;
                justify-content: space-around;
            }

            .date span {
                width: 100px;
            }

            .date span:first-child {
                text-align: left;
            }

            .date span:last-child {
                text-align: right;
            }

            .date .june-29 {
                color: #d83565;
                font-size: 17px;
            }

            .show-name {
                font-size: 20px;
                /*font-family: "Send Flowers", cursive;*/
                color: #d83565;
            }

            .show-name h1 {
                font-size: 20px;
                font-weight: 700;
                letter-spacing: 0.1em;
                color: #4a437e;
            }

            .time {
                padding: 10px 0;
                color: #4a437e;
                text-align: center;
                display: flex;
                width: 100%;
                flex-direction: column;
                gap: 10px;
                font-weight: 700;
            }

            .time span {
                font-weight: 400;
                color: gray;
            }

            .left .time {
                font-size: 14px;
            }


            .location {
                display: flex;
                justify-content: space-around;
                align-items: center;
                width: 100%;
                padding-top: 8px;
                border-top: 1px solid gray;
            }

            .location .separator {
                font-size: 20px;
            }

            .right {
                width: 180px;
                border-left: 1px dashed #404040;
                height: 300px;
            }

            .right .admit-one {
                color: darkgray;
            }

            .right .admit-one span:nth-child(2) {
                color: gray;
            }

            .right .right-info-container {
                height: 300px;
                padding: 10px 10px 10px 35px;
                /*width: 100%;*/
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                align-items: center;
            }

            .right .show-name h1 {
                font-size: 18px;
            }

            .barcode {
                height: 100px;
            }

            .barcode img {
                height: 100%;
            }

            .right .ticket-number {
                color: gray;
            }

        </style>
    </body>
</html>