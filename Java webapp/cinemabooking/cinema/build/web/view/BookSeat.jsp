
<%@page import="model.SeatRoom"%>
<%@page import="model.Seat"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <!--get session--> 
        <%ArrayList<Seat> listSeat = (ArrayList<Seat>) request.getAttribute("listSeat"); %>   
        <%ArrayList<SeatRoom> listSeatChecked = (ArrayList<SeatRoom>) request.getAttribute("listSeatChecked"); %>   
        <%ArrayList<String> listCharSeat = (ArrayList<String>) request.getAttribute("listCharSeat");%>
        <title>BoomCinema-Đặt vé</title>
    </head>
    <body id="bodybook" onbeforeunload="return reloadPage(${timeroomId})">
        <%@include file="template/header.jsp" %>
        <div class="main-container co11-layout">
            <div class="main">
                <div class="col-main">
                    <div class="booking-progress">
                        <div class="page-title">
                            <h1 style="font-family: 'Merriweather Sans', sans-serif;font-weight: bold">ĐẶT VÉ ONLINE</h1>
                        </div>
                        <!--top content-->
                        <form id="bookve" action="payment" method="post">
                            <input name="timeroomId" value="${timeroomId}" hidden>
                            <!--movie info-->
                            <input name="movieId" value="${movie.movieId}" hidden>
                            <input name="roomId" value="${room.roomId}" hidden>
                            <input name="movietimeId" value="${movietimeId}" hidden>
                            <input id="seatId" name="listseatId" value="" hidden>
                            <div class="top-content">
                                <ol class="products-list " style="display: flex;">
                                    <li class="item" style="width: 80%">
                                        <div class="product-shop">
                                            <div class="f-fix">
                                                <div class="product-primary">
                                                    <p>
                                                        Rạp BOOMCINEMA Thạch Thất | ${room.roomName} | <%=listSeat.size() - listSeatChecked.size()%>/<%=listSeat.size()%> Ghế

                                                    </p>
                                                    <p><fmt:formatDate pattern="dd/MM/yyyy" value = "${date}"/>  | từ  <fmt:formatDate type="time" pattern="HH:mm aa" value="${slot.start}"/> đến  <fmt:formatDate type="time" pattern="HH:mm aa" value="${slot.finish}"/></p>

                                                </div>
                                            </div>
                                        </div>
                                    </li>

                                    <li id="countdown" style="width: 20%;height: auto;display: none;" >
                                        <span style="width: 30px">Quá trình đặt vé còn</span>
                                        <div style="display: flex">
                                            <div class="time-count" style="margin-left: 40px ;margin-top: 5px;"><span id="minute" style="line-height: 2.7">05</span></div>
                                            <div class="time-count" style="margin: 5px ;"><span id="seconds" style="line-height: 2.7">00</span></div>
                                        </div>

                                    </li>
                                </ol>
                            </div>
                            <!--main content-->
                            <div class="modal-nofi" id="admin-load-modal"  >
                                <div class="modal-nofi-overlay-load"></div> 
                                <div id="loading-mask" style="left: -2px; top: 0px;z-index: 999999;">
                                    <p class="loader" id="loading_mask_loader" style="color: black;font-weight: bold">
                                        <img src="${pageContext.request.contextPath}/image/load.gif" alt="Loading...">
                                        <br >Đang tải thông tin...		</p>
                                </div>
                            </div>
                            <div id="main-body" class="main-content">

                                <ul id="bookghe" class="progress">
                                    <li class="booking-step" >              
                                        <label class="h2" style="font-family: 'Merriweather Sans', sans-serif;font-weight: bold">Người / Ghế</label>
                                        <div class="ticketbox">
                                            <div class="screen">
                                                <span class="text-screen">Phòng chiếu</span>
                                            </div>
                                            <table class="seat-matrix"  >
                                                <%int location = 0;%>
                                                <%for (int i = 0; i < listCharSeat.size(); i++) {%>
                                                <tr  >
                                                    <%for (int j = location; j < listSeat.size(); j++) {%>
                                                    <%if (listCharSeat.get(i).equals(listSeat.get(j).getSeatRow())) {%>
                                                    <td >
                                                        <%boolean check = false;%>
                                                        <%for (SeatRoom c : listSeatChecked) {
                                                                if (c.getSeatId() == listSeat.get(j).getSeatId()) {%>

                                                        <span style="background: #D00202"><%=listSeat.get(j).getSeatRow()%><%=listSeat.get(j).getSeatNumber()%></span>
                                                        <%check = true;
                                                                }
                                                            }%>
                                                        <% if (!check) {%>
                                                        <input onchange="addPrice()" type="checkbox" name="seatId" value="<%=listSeat.get(j).getSeatId()%>">
                                                        <input hidden onchange="addPrice()" id="seatPrice" value="<%=listSeat.get(j).getSeatPrice()%>">
                                                        <span><%=listSeat.get(j).getSeatRow()%><%=listSeat.get(j).getSeatNumber()%></span>
                                                        <%}%>
                                                        <%location++;%>
                                                    </td>
                                                    <%} else {%>
                                                    <%break;%>
                                                    <%}%>
                                                    <%}%>
                                                </tr>
                                                <%}%>
                                            </table>
                                            <div class="ticketbox-notice" style="margin: 3rem 15rem;">
                                                <div class="iconlist">
                                                    <div class="icon checked" style="display: flex;" >
                                                        <div style="background-color: rgba(245, 193, 39, 0.82);width: 20px;height: 20px; margin: 0 10px"></div> Ghế trống
                                                    </div>
                                                    <div class="icon checked" style="display: flex;" >
                                                        <div style="background-color: black;width: 20px;height: 20px; margin: 0 10px"></div> Ghế bạn chọn
                                                    </div>
                                                    <div class="icon checked" style="display: flex;" >
                                                        <div style="background-color: #D00202;width: 20px;height: 20px; margin: 0 10px"></div> Ghế đã chọn
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div id="seat-alert">
                                <p>Hãy chọn ghế ngồi của bạn</p>
                            </div>
                            <div id="seat-mess" >
                                <p>Ghế bạn chọn đã có ai đó chọn rồi</p>
                            </div>

                            <!--bottom content-->
                            <div class="bottom-content">
                                <!--button go back-->
                                <div class="format-bg-top"></div> 
                                <a id="button-back" class="btn-pre-left" style="cursor: pointer" href="${pageContext.request.contextPath}/home" title="Previous"><img height="100%" width="100%" src="${pageContext.request.contextPath}/image/Previous.png" alt="alt"/></a>
                                <div class="minicart">
                                    <ul>
                                        <!--movie info-->
                                        <li class="item first">
                                            <div class="product-details">
                                                <table class ="info-wrapper">
                                                    <colgroup>
                                                        <col width="40%">
                                                        <col>
                                                    </colgroup>                                             
                                                    <tbody>
                                                        <tr>
                                                            <td>
                                                                <img src="${pageContext.request.contextPath}/${movie.image}" alt="alt"/>
                                                            </td>
                                                            <td>
                                                                <table>
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="label" style="font-weight: bold">${movie.movieName}</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td><c:if test="${typeRoom!=1}">3D</c:if><c:if test="${typeRoom==1}">2D</c:if></td>
                                                                            </tr>
                                                                            <tr>
                                                                                    <td>${movie.rate}</td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>  
                                                            </td>
                                                        </tr>
                                                    </tbody>

                                                </table>
                                            </div>
                                        </li>
                                        <!--movie schedule-->
                                        <li class="item">
                                            <div class="product-details">
                                                <table class ="info-wrapper">
                                                    <colgroup>
                                                        <col width="30%">
                                                        <col>
                                                    </colgroup>
                                                    <tbody>
                                                        <tr style="height: 43px">
                                                            <td class="label">Suất chiếu</td>
                                                            <td style="font-weight: bold;font-size:16px;">      
                                                                <fmt:formatDate type="time" pattern="HH:mm aa" value="${slot.start}"/>,<br><fmt:formatDate pattern="dd/MM/yyyy" value = "${date}"/> 
                                                            <td>
                                                        </tr>
                                                        <tr style="height: 43px">
                                                            <td class="label">Phòng chiếu</td>
                                                            <td style="font-weight: bold;font-size:16px;">${room.roomName}<td>
                                                        </tr>
                                                    </tbody>
                                                </table> 
                                            </div>
                                        </li>
                                        <!--movie ticket price-->
                                        <li class="item">
                                            <div class="product-details">
                                                <table class ="info-wrapper">
                                                    <thead>
                                                        <tr class="block-box" style="height: 20px">
                                                            <td class="label">Giá vé</td>
                                                            <td id="price-ticket" style="font-weight: bold;">0 VND</td>
                                                    <input id="ticketPrice" value="0" hidden="" >
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr class="block-box" style="height: 23px">
                                                            <td class="label">Combo</td>
                                                            <td id="price-combo" style="font-weight: bold;">0 VND</td>
                                                    <input id="comboPrice" value="0" hidden="">
                                                    <input id="status-time" value="0" hidden>
                                                    </tr>

                                                    </tbody>
                                                    <tfoot>
                                                        <tr class="block-box">
                                                            <td class="label" style="font-weight: bold">TỔNG</td>
                                                            <td id="price-total" style="font-weight: bold;">0 VND</td>
                                                    <input id="totalInput" name="total" value="0" hidden="">
                                                    </tr>   
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <!--button go next-->                        


                                <a id="button-next" class="btn-next-right" style="cursor: pointer"  onclick="submit(${timeroomId})" title="Next"><img height="100%" width="100%" src="${pageContext.request.contextPath}/image/next.png" alt="alt"/></a>

                                <div class="format-bg-bottom"></div>           
                            </div>
                        </form>
                    </div>
                </div>
            </div> 
        </div>
        <%@include file="template/footer.jsp" %>

        <style>

            .seat-matrix{
                margin: 0 auto;
            }
            .seat-matrix td{
                position: relative;
                width: 30px;
                height: 30px;
                margin: 130px;
                box-sizing: border-box;
                cursor: pointer;
                padding: 0.1em;

            }
            #seat-mess{
                width: 100%;
                text-align: center;
                font-size: 20px;
                font-weight:bold;
                color:#eb3b5a;
                display:none;
            }
            .seat-matrix td:hover{
                background-color: #FF0000;
            }
            .seat-matrix span{
                background-color: rgba(245, 193, 39, 0.82);
                width: 99%;
                height: 99%;
                display: flex;
                justify-content: center;
                align-items: center;
                line-height: 100%;
                transition: .9s ease;

            }

            .seat-matrix input{
                position: absolute !important;
                width: 100%;
                height: 100%;
                opacity: 0;
                cursor: pointer;
            }
            .seat-matrix input[type=checkbox]:checked ~ span {
                background-color: black;
                color: white;
            }

            .loader img{
                width: 50px;
                height: auto;
            }
            #admin-load-modal{
                display: none;
                background: rgba(224, 224, 224, 0.69) ;
                justify-content: center;
                align-items: center;
                text-align: center;
                min-height: 100vh;

            }
            .time-count{
                text-align: center;
                background: #D00202;
                width: 45px;
                height: 45px;
                border-radius: 6px;
                color: white;
            }
        </style>
        <!-- BOOTSTRAP5-->
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"
        ></script>
        <!-- SCRIPT -->
        <script src="${pageContext.request.contextPath}js/script.js"></script>
        <!-- SAKURA -->
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="${pageContext.request.contextPath}js/jquery-sakura.js"></script>
        <script>

                                    function submit(timeroomId) {
                                        var total = 0;
                                        var cells, total, a, i, j;
                                        var check = 0;
                                        var list = document.getElementById("seatId").value;
                                        for (var a = document.querySelectorAll('table.seat-matrix tr'), i = 0; a[i]; ++i) {
                                            // get inventory row cells
                                            cells = a[i].getElementsByTagName('input');
                                            for (let j = 0; j < cells.length; j++) {

                                                if (cells[j].checked) {
                                                    check = 1;
                                                }
                                            }
                                        }
                                        if (check == 1) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/bookfood",
                                                data: {
                                                    listSeat: list,
                                                    timeroomId: timeroomId
                                                },
                                                beforeSend: function () {
                                                    $("#bookghe").hide();
                                                    $("#loading-mask").show();
                                                },
                                                success: function (data) {
                                                    $("#seat-mess").hide();
                                                    $("#seat-alert").hide();
                                                    $("#loading-mask").hide();
                                                    var c = document.getElementById("main-body");
                                                    c.innerHTML = data;
                                                    document.getElementById("status-time").value = 0;
                                                    count(5, timeroomId);
                                                    $("#countdown").show();
                                                    $("#button-back").removeAttr("href");
                                                    $("#button-back").attr('onclick', 'previous(' + timeroomId + ')');
                                                    $("#button-next").attr("onclick", "submitBook()");

                                                },
                                                error: function (xhr) {
                                                    $("#bookghe").show();
                                                    location.reload();
                                                    window.onload = sessionStorage.setItem("reloading", "1");
                                                }
                                            });
                                        } else {
                                            document.getElementById("seat-alert").style.display = "block";
                                        }
                                    }

                                    window.onload = function () {
                                        var check = sessionStorage.getItem("reloading");
                                        sessionStorage.removeItem("reloading");
                                        if (check == 1)
                                            document.getElementById("seat-mess").style.display = "block";
                                    }

                                    function addPrice() {
                                        var total = 0;
                                        var cells, price, total, a, i, j;
                                        var seat = "";
//                                        var seatNew;

                                        for (var a = document.querySelectorAll('table.seat-matrix tr'), i = 0; a[i]; ++i) {
                                            // get inventory row cells
                                            cells = a[i].getElementsByTagName('input');
                                            for (let j = 0; j < cells.length; j++) {

                                                if (cells[j].checked) {
                                                    if (seat.length < 1) {
                                                        seat += String(cells[j].value);
                                                    } else {
                                                        seat += ',' + String(cells[j].value);
                                                    }

                                                    price = parseFloat(cells[j + 1].value);
                                                    total += price;
                                                }
                                            }
                                        }

                                        document.getElementById('seatId').value = seat;
                                        document.getElementById('totalInput').value = total;
                                        document.getElementById('ticketPrice').value = total;
                                        document.getElementById('price-ticket').innerHTML = (total * 1000).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                        document.getElementById('price-total').innerHTML = (total * 1000).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                    }

                                    function addQuantity(num) {
                                        var total = 0;
                                        var cells, price, total, a, i, j;
                                        for (var a = document.querySelectorAll('.item-quantity'), i = 0; a[i]; ++i) {
                                            if (i == num) {

                                                a[i].value = Number(a[i].value) + 1;
                                                break;
                                            }
                                        }

                                        for (var a = document.querySelectorAll('.products-list li'), i = 0; a[i]; ++i) {
                                            cells = a[i].getElementsByTagName('input');
                                            for (let j = 0; j < cells.length; j++) {
                                                if (Number(cells[0].value) != 0) {
                                                    price = parseFloat(cells[2].value) * Number(cells[0].value);
                                                    total += price;
                                                    break;
                                                }
                                            }
                                        }

                                        var ticket = document.getElementById('ticketPrice').value;
                                        document.getElementById("price-combo").innerHTML = (total * 1000).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                        document.getElementById("comboPrice").value = total;
                                        document.getElementById("totalInput").value = total + parseFloat(ticket);
                                        document.getElementById('price-total').innerHTML = ((total + parseFloat(ticket)) * 1000).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                    }


                                    function minusQuantity(num) {
                                        var total = 0;
                                        var cells, price, total, a, i, j;
                                        for (var a = document.querySelectorAll('.item-quantity'), i = 0; a[i]; ++i) {
                                            if (i == num) {
                                                if (Number(a[i].value) > 0)
                                                    a[i].value = Number(a[i].value) - 1;
                                                break;
                                            }
                                        }

                                        for (var a = document.querySelectorAll('.products-list li'), i = 0; a[i]; ++i) {
                                            cells = a[i].getElementsByTagName('input');
                                            for (let j = 0; j < cells.length; j++) {
                                                if (Number(cells[0].value) != 0) {
                                                    price = parseFloat(cells[2].value) * Number(cells[0].value);
                                                    total += price;
                                                    break;
                                                }
                                            }
                                        }
                                        var ticket = document.getElementById('ticketPrice').value;
                                        document.getElementById("price-combo").innerHTML = (total * 1000).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                        document.getElementById("comboPrice").value = total;
                                        document.getElementById("totalInput").value = total + parseFloat(ticket);
                                        document.getElementById('price-total').innerHTML = ((total + parseFloat(ticket)) * 1000).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                    }

                                    function count(a, timeroomId) {
                                        var time = a * 60;
                                        const check = setInterval(function () {
                                            var seconds = time % 60;
                                            var minutes = (time - seconds) / 60;
                                            if (seconds.toString().length == 1) {
                                                seconds = "0" + seconds;
                                            }
                                            if (minutes.toString().length == 1) {
                                                minutes = "0" + minutes;
                                            }
                                            document.getElementById("minute").innerHTML = minutes
                                            document.getElementById("seconds").innerHTML = seconds;
                                            time--;
                                            var status = document.getElementById("status-time").value;
                                            if (time == 0 && Number(status) == 0) {
                                                previous(timeroomId);
                                            }
                                            if (Number(status) == 1)
                                                clearInterval(check);
                                        }, 1000);
                                    }

                                    function previous(timeroomId) {
                                        $.ajax({
                                            type: "post",
                                            url: "${pageContext.request.contextPath}/bookfood",
                                            data: {
                                                timeroomId: timeroomId
                                            },
                                            beforeSend: function () {
                                                $("#bookghe").hide();
                                                $("#bookfood").hide();
                                                $("#loading-mask").show();
                                            },
                                            success: function (data) {
                                                $("#countdown").hide();
                                                document.getElementById("status-time").value = 1;
                                                $("#loading-mask").hide();
                                                var c = document.getElementById("main-body");
                                                c.innerHTML = data;
                                                $("#button-back").attr("href", "${pageContext.request.contextPath}/home");
                                                $("#button-back").removeAttr("onclick");
                                                $("#button-next").attr("onclick", "submit(" + timeroomId + ")");
                                                document.getElementById("price-combo").innerHTML = (0).toLocaleString('it-IT', {style: 'currency', currency: 'VND'});
                                                document.getElementById("comboPrice").value = 0;
                                                addPrice();
                                            },
                                            error: function (xhr) {

                                            }
                                        });
                                    }

//                                    window.addEventListener("beforeunload", function (e) {
//                                        previous();
//                                        return showADialog(e);
//                                    });
                                    function reloadPage(timeroomId) {
                                        previous(timeroomId);
                                    }
                                    function submitBook() {
                                        $("#bodybook").removeAttr("onbeforeunload");
                                        document.getElementById("bookve").submit();
                                    }

        </script>
    </body>

</html>
