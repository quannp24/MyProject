

<%@page import="java.time.LocalDate"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalTime"%>
<%@page import="java.sql.Time"%>
<%@page import="model.Room"%>
<%@page import="model.Movie"%>
<%@page import="model.TimeRoom"%>
<%@page import="model.MovieTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<% Date curdate = (Date) request.getAttribute("date");%>
<%ArrayList<MovieTime> listSlot = (ArrayList<MovieTime>) request.getAttribute("listSlot");%>
<%ArrayList<TimeRoom> listTimeRoom = (ArrayList<TimeRoom>) request.getAttribute("listTimeRoom");%>
<%ArrayList<Movie> listMovie = (ArrayList<Movie>) request.getAttribute("listMovie");%>
<%ArrayList<Room> listroom = (ArrayList<Room>) request.getAttribute("listroom");%>
<% ZoneId zid = ZoneId.of("Asia/Ho_Chi_Minh");
    LocalDate ld = LocalDate.now(zid);
    Date currentDate = Date.valueOf(ld);
    Calendar c = Calendar.getInstance();
    c.setTime(currentDate);
    c.add(Calendar.DATE, 9);
    Date addDate = new Date(c.getTimeInMillis());
    int displaybook = 0;%>

<jsp:useBean id="getMovie" class="DAL.MovieDAO"/>
<jsp:useBean id="getRoom" class="DAL.RoomDAO"/>
<!DOCTYPE html>
<html>
    <head>
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <!--FONTAWESOME-->
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
            integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>-->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <title>BoomCinema-Lịch trình</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/new2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/button-neon_1.css" />



    </head>

    <body>
        <!--side bar-->
        <aside class="sidebar position-fixed top-0 left-0 overflow-auto h-100 float-left" id="show-side-navigation1">
            <i class="fas fa-bars close-aside d-md-none d-lg-none" data-close="show-side-navigation1"></i>
            <div class="sidebar-header d-flex justify-content-center align-items-center px-3 py-4">
                <img
                    class="rounded-pill img-fluid"
                    width="150"
                    src="${pageContext.request.contextPath}/image/logo.png"
                    alt="">
                <div class="ms-2">
                    <h5 class="fs-6 mb-0">
                        <a class="text-decoration-none" href="${pageContext.request.contextPath}/home">Trang chủ                        
                            <i class="fas fa-house"></i> 
                        </a>
                    </h5>
                </div>
            </div>
            <!--search input-->
            <div class="search position-relative text-center py-3 mt-2">
                <form action="asearchaccount" method="post" class="input-group rounded">
                    <input oninput="checkSearch()" name="searchtxt" value="${searchtxt}" type="search" class="form-control" placeholder="Tìm kiếm người dùng" aria-label="Search" aria-describedby="search-addon" />
                    <button type="submit"  style="height:38px;background-color: #252636;" class="input-group-text border-0" id="search-addon">
                        <i class="fas fa-search" style="color: #FFF"></i></a>
                    </button>
                </form>
                <p style="color:red; text-align: center">${searchMess}</p>  
            </div>
            <!--menu sidebar-->
            <%@include file="template/adminMenu.jsp" %>
        </aside>
        <!--main content-->
        <section id="wrapper">
            <!--header-->
            <%@include file="template/adminNewHeader.jsp" %>
            <!--content-->
            <div class="p-4" >
                <!--header table-->
                <div class="welcome" >
                    <div class="content rounded-3 p-3">
                        <h1 class="fs-3"><i class="far fa-calendar-alt" aria-hidden="true"></i> Quản lý lịch chiếu</h1>
                    </div>
                </div>


            </div>
            <div >
                <div style="display: flex; justify-content: end; margin: 10px;">
                    <%if (curdate.after(addDate)) {%>
                    <div >

                        <button onclick="openAddSchedule('${date}')"  class="custom-btn btn-crud"><span>Thêm ngay !</span><span>Thêm</span></button>
                    </div>
                    <%} else {%>
                    <%}%>
                    <div  style="margin: auto;display: flex">

                        <p  style="font-size: 30px;font-weight:bold">                               
                            <fmt:formatDate pattern="EEEE, dd-MM-yyyy" value = "${date}"/>  
                        </p>
                        <i onclick="openTool()"  class="fas fa-hashtag button-icon neon-button" aria-hidden="true"></i>
                    </div>
                    <div style="display: flex;">
                        <label style="font-size: 20px;">Chọn ngày: </label>
                        <form  action="setupschedule" method="post">
                            <input onchange="this.form.submit()" class="neon-button" type="date" name="date" value="${date}">
                        </form>
                    </div>

                </div>

                <c:if test="${mess!=null ||mess!=''}">
                    <div style="display: flex; justify-content: end; margin: 10px" >
                        <div style="margin: auto">

                            <p style="font-size: 25px;color: red;">                               
                                ${mess}
                            </p>

                        </div>

                    </div>
                </c:if>
                <c:if test="${messAdd!=null ||messAdd!='' || messError!=null}">
                    <div style="display: flex; justify-content: end; margin: 10px" >
                        <div style="margin: auto">
                            <p style="font-size: 25px;color: #20bf6b;">                               
                                ${messAdd}
                            </p>
                            <p style="font-size: 25px;color: #FF0000;">                               
                                ${messError}
                            </p>
                        </div>

                    </div>
                </c:if>
            </div>
            <c:if test="${check}">
                <div>
                    <div class="admin-table table-responsive">

                        <table class="table">
                            <thead>
                                <tr>
                                    <th style="width: 150px" scope="col">Phòng</th>

                                    <c:forEach var="s" begin="1" end="${lastSlot}" >


                                        <th scope="col" style="background-color: #1B1111;color: white;border: solid #FFF;text-align: center;width: auto;">Slot ${s}</th>
                                        </c:forEach>


                                </tr> 
                            </thead>
                            <tbody>



                                <% for (int i = 0; i < listroom.size(); i++) {%>
                                <tr>


                                    <th scope="row" style="background-color: hsl(351, 69%, 50%);color: white"><%=listroom.get(i).getRoomName()%></th>
                                        <% for (int j = 1; j <= listSlot.get(listSlot.size() - 1).getSlot(); j++) {%>

                                    <%boolean checkc = false;%>
                                    <%for (MovieTime s : listSlot) {%>
                                    <%if (s.getSlot() == j) {%>
                                    <% boolean check = false;%>


                                    <% for (int k = 0; k < listTimeRoom.size(); k++) {%>

                                    <%if (listTimeRoom.get(k).getMovieTimeId() == s.getMovieTimeId() && listroom.get(i).getRoomId() == listTimeRoom.get(k).getRoomId()) {%>

                                    <%for (int g = 0; g < listMovie.size(); g++) {%>

                                    <% if (listMovie.get(g).getMovieId() == listTimeRoom.get(k).getMovieId()) {%>
                                    <td style="border: solid black;"> 
                                        <div style="display: flex;flex-direction: row; justify-content: space-between;"> 
                                            <div style="display: flex;flex-direction:column;margin-right: 12px">
                                                <h5 style="color: #ffc107"><i class="fas fa-film" style="color: #ffc107"></i> <%=listMovie.get(g).getMovieName()%>
                                                    <%if (listTimeRoom.get(k).isStatus()) {%><img width="13px" height="13px" src="${pageContext.request.contextPath}/image/green.png">
                                                    <%} else {%>
                                                    <%displaybook = 1;%>
                                                    <img width="10px" height="10px" src="${pageContext.request.contextPath}/image/red.png">
                                                    <%}%>


                                                </h5>                                 
                                                [<fmt:formatDate pattern="HH:mm" type="time" value="<%=s.getStart()%>"/> - <fmt:formatDate pattern="HH:mm" type="time" value="<%=s.getFinish()%>"/>]
                                                <!--<button onclick=" showDelMess()"  class="btn-movie " style="width: 6em">Xóa</button>-->

                                            </div>
                                        </div>
                                        <%if (curdate.after(addDate)) {%>
                                        <%if (!listTimeRoom.get(k).isStatus()) {%>
                                        <div style="text-align: center">
                                            <a ><button onclick="openEditSchedule(<%=listTimeRoom.get(k).getTimeRoomId()%>)" class="btn-movie " style="width: 5em">Sửa</button></a>
                                        </div>
                                        <%}%>
                                        <%} else {%>
                                        <%}%>
                                    </td>
                                    <%check = true;%>
                                    <%checkc = true;%>
                                    <%}//ket thuc if listMovie%>
                                    <% if (check) {
                                            break;
                                        }%>
                                    <%}//ket thuc for g%>
                                    <%check = true;%>
                                    <%}//ket thuc if%>
                                    <% if (check) {
                                            break;
                                        }%>
                                    <%}//ket thuc for k%>





                                    <%}if(checkc)break; %>
                                    <%}%>
                                    <%if (!checkc) {%>
                                    <td style="text-align: center ;border: solid black;">

                                        Trống

                                    </td>
                                    <%}%>
                                    <%}%> 
                                </tr>
                                <%}//ket thuc cau lenh for i%>


                            </tbody>
                        </table>

                    </div>

                </div>
                <!--footer-->


            </section>
        </c:if>

        <!--add modal-->
        <div id="modal-add-schedule">
            <div class="modal-nofi" id="admin-add-modal" >
                <div class="modal-nofi-overlay"></div>
                <div class="modal-add modal-dialog-scrollable">
                    <form class="full-width" action="updateschedule" method="post">
                        <h5 class="modal-add-title">Thêm lịch chiếu phim</h5>
                        <div class="modal-add-body">
                            <div class="add-input-option">


                                <label>Phim chiếu </label>                              
                                <input class="" name="" value="${getMovie.getMovieById(movieId).movieName}" placeholder="" readonly required="">
                                <button type="button" onclick="openChooseMovie()" class="btn-change-option">Chọn</button>
                            </div>
                            <div class="add-input-option">
                                <label>Phòng </label>  
                                <input class="" value="${getRoom.getRoomsByID(roomId).roomName}" type="" placeholder=""readonly required="">
                                <button type="button" onclick="openchooseRoom()" class="btn-change-option">Chọn</button>
                            </div>
                            <div class="add-input-option">
                                <label>Slot </label>  
                                <c:if test="${slot!=null}">
                                    <input class=""  value="Slot ${slot.slot} từ <fmt:formatDate pattern="HH:mm" type="time" value="${slot.start}"/> đến <fmt:formatDate pattern="HH:mm" type="time" value="${slot.finish}"/>  " type="text" placeholder="" readonly required="">
                                </c:if>
                                <c:if test="${slot==null}">
                                    <input class=""  value="" type="" placeholder="" readonly>
                                </c:if>
                                <c:if test="${roomId!=0}"><button type="button" onclick="openChooseTime()" class="btn-change-option">Chọn</button></c:if>
                                <c:if test="${roomId==0}"><button type="button" class="btn-change-option">Chọn</button></c:if>
                                </div>

                                <div class="text-center">
                                    <label id="mess-text" style="color: red">${messAddErr} </label>  

                            </div>


                        </div>
                        <div class="modal-btn">
                            <button type="submit" onclick="this.form.submit()" class="custom-btn btn-crud"><span>Thêm ngay !</span><span>Thêm</span></button>
                            <button type="button" onclick="closeModal()" class="custom-btn btn-crud"><span>Đóng ngay !</span><span>Đóng</span></button>
                        </div> 
                    </form>
                </div>
            </div>




            <!--modal add movie-->
            <div class="modal-nofi modal-choose" id="modal-choose-movie">
                <div class="modal-nofi-overlay"></div>
                <div class="modal-add-movie modal-dialog-scrollable">
                    <form class="full-width" action="" method="post">
                        <h5 class="modal-add-title">Chọn phim chiếu</h5>
                        <div class="modal-add-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>

                                            <th scope="col">Tên phim</th>
                                            <th scope="col" style="width: 20%">Thể loại</th>
                                            <th scope="col" style="width: 15%">Thời lượng</th>
                                            <th scope="col" style="width: 20%">Khởi chiếu</th>
                                            <th scope="col" style="width: 5%"></th>
                                        </tr>
                                    </thead>
                                    <tbody>


                                        <c:forEach items="${listMovie}" var="m">
                                            <tr>

                                                <td style="font-weight: bold">${m.movieName}</td>
                                                <td>${m.category}</td>
                                                <td>${m.duration}</td>
                                                <td>${m.startdate}</td>
                                                <c:if test="${edit==null}">
                                                    <td><a href="updateschedule?movieId=${m.movieId}&roomId=${roomId}&date=${date}&add=true">Chọn</a></td>
                                                </c:if>
                                                <c:if test="${edit==true}">
                                                    <td><a href="editslot?movieId=${m.movieId}&roomId=${roomId}&date=${date}&slot=${slot.slot}&timeroomId=${timeroomId}">Chọn</a></td>
                                                </c:if>

                                            </tr>

                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-btn">
                            <button type="button" onclick="closeModalChoose()" class="custom-btn btn-crud"><span>Đóng !</span><span>Đóng</span></button>
                        </div> 
                    </form>
                </div>
            </div>



            <!--modal choose room-->
            <div class="modal-nofi modal-choose" id="modal-choose-room">
                <div class="modal-nofi-overlay"></div>
                <div class="modal-add-small modal-dialog-scrollable">
                    <form class="full-width" action="" method="post">
                        <h5 class="modal-add-title">Chọn phòng</h5>
                        <div class="modal-add-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Phòng</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%for (int n = 0; n < listroom.size();n++) {%>
                                        <tr>
                                            <td><%=listroom.get(n).getRoomName()%></td>
                                            <c:if test="${add==true}">
                                                <td><a href="updateschedule?roomId=<%=listroom.get(n).getRoomId()%>&movieId=${movieId}&date=${date}&add=true">Chọn</a></td>
                                            </c:if>
                                            <c:if test="${edit==true}">
                                                <td><a href="editslot?roomId=${roomId}&movieId=${movieId}&date=${date}&slot=${slot.slot}&timeroomId=${timeroomId}&roomIdNew=<%=listroom.get(n).getRoomId()%>">Chọn</a></td>
                                            </c:if>

                                        </tr>
                                        <%}%>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-btn">
                            <button type="button" onclick="closeModalChoose()" class="custom-btn btn-crud"><span>Close !</span><span>Close</span></button>
                        </div> 
                    </form>
                </div>
            </div>
            <!--modal choose slot-->   

            <div class="modal-nofi modal-choose" id="modal-choose-slot">
                <div class="modal-nofi-overlay"></div>
                <div class="modal-add-medium modal-dialog-scrollable">
                    <!--<form class="full-width" action="updateschedule" method="get">-->
                    <div class="full-width">
                        <h5 class="modal-add-title">Chọn slot</h5>
                        <div class="modal-add-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Slot</th>
                                            <th scope="col">Bắt đầu</th>
                                            <th scope="col">Kết thúc</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%ArrayList<MovieTime> slots = (ArrayList<MovieTime>) request.getAttribute("slots");%>
                                        <c:if test="${slots!=null}">
                                            <%Time min = null;%>
                                            <%Time max = null;%>
                                            <%for (int k = 1; k <= 10; k++) {%>
                                            <%boolean check = false;%>

                                            <%for (int g = 0; g < slots.size(); g++) {%>
                                            <%if (slots.get(g).getSlot() == k) {%>
                                            <tr>
                                                <td><%=slots.get(g).getSlot()%></td>
                                                <td><fmt:formatDate pattern="HH:mm" type="time" value="<%=slots.get(g).getStart()%>"/></td>
                                                <td><fmt:formatDate pattern="HH:mm" type="time" value="<%=slots.get(g).getFinish()%>"/></td>

                                                <td><a>Đã chọn</a></td>
                                            </tr>


                                            <%check = true;%>
                                            <%min = slots.get(g).getFinish();%>
                                            <%}
                                                    if (check) {
                                                        break;
                                                    }
                                                }
                                                if (!check) {%>

                                            <tr>

                                        <form class="full-width" <c:if test="${add==true}">action="updateschedule"</c:if><c:if test="${edit==true}">action="editslot"</c:if> id="form-submit" method="get">
                                            <c:if test="${add==true}">
                                                <td><input type="text" name="slot" value="<%=k%>" hidden=""><%=k%></td>
                                                <input type="text" name="add" value="true" hidden="">
                                            </c:if>
                                            <input type="text" name="roomId" value="${roomId}" hidden="">
                                            <c:if test="${edit==true}">


                                                <td> <input type="text" name="slotNew" value="<%=k%>" hidden=""><%=k%></td>
                                                <input type="text" name="slot" value="${slot.slot}" hidden="">


                                                <input type="text" name="roomIdNew" value="${roomIdNew}" hidden="">
                                                <input type="text" name="timeroomId" value="${timeroomId}" hidden="">
                                            </c:if>
                                            <input type="text" name="date" value="${date}" hidden="">
                                            <input type="text" name="movieId" value="${movieId}" hidden="">

                                            <td><input style="margin-top: 5px;" type="time" name="start"  required></td>
                                            <td><input style="margin-top: 5px;" type="time" name="finish" required></td>

                                            <td><button class="btn-movie " type="submit"><a>Chọn</a></button></td>
                                        </form>

                                        </tr>

                                        <%}
                                            }%>



                                    </c:if>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-btn">
                            <button type="button" onclick="closeModalChoose()" class="custom-btn btn-crud"><span>Close !</span><span>Close</span></button>
                        </div> 

                    </div>
                </div>
            </div>

        </div>

        <!--edit modal-->
        <div id="modal-edit-schedule">
            <div class="modal-edit-nofi" id="admin-edit-modal" >
                <div class="modal-nofi-overlay"></div>
                <div class="modal-edit-movieroom modal-dialog-scrollable">
                    <form class="full-width" action="editslot" method="post">
                        <h5 class="modal-edit-title">Sửa lịch chiếu phim</h5>
                        <div class="modal-edit-body">
                            <div class="add-input-option">

                                <label>Phim chiếu </label>                              
                                <input class="" name="" value="${getMovie.getMovieById(movieId).movieName}" placeholder="" readonly required="">
                                <button type="button" onclick="openChooseMovie()" class="btn-change-option">Chọn</button>
                            </div>
                            <div class="add-input-option">
                                <label>Phòng </label>  
                                <input class="" value="${getRoom.getRoomsByID(roomId).roomName}" type="" placeholder=""readonly required="">
                                <button onclick="openchooseRoom()" type="button" class="btn-change-option">Chọn</button>
                            </div>
                            <div class="add-input-option">
                                <label>Slot </label>  

                                <input class=""  value="" type="" placeholder="" readonly>
                                <button type="button" class="btn-change-option">Chọn</button>
                            </div>
                            <c:if test="${messEditErr!=null}">
                                <div class="text-center">
                                    <label style="color: red">${messEditErr} </label>  

                                </div>
                            </c:if>

                        </div>
                        <div class="modal-btn">
                            <button type="submit" onclick="this.form.submit()" class="custom-btn btn-crud"><span>Sửa ngay !</span><span>Sửa</span></button>
                            <button type="button" class="custom-btn btn-crud"><span>Xóa slot!</span><span>Xóa</span></button>
                            <button type="button" onclick="closeModal()" class="custom-btn btn-crud"><span>Đóng ngay !</span><span>Đóng</span></button>
                        </div> 
                    </form>
                </div>
            </div>

            <!--modal add movie-->
            <div class="modal-edit-nofi modal-choose" id="modal-edit-choose-movie">
                <div class="modal-nofi-overlay"></div>
                <div class="modal-edit-movie modal-dialog-scrollable">
                    <form class="full-width" action="" method="post">
                        <h5 class="modal-edit-title">Chọn phim chiếu</h5>
                        <div class="modal-edit-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>

                                            <th scope="col">Tên phim</th>
                                            <th scope="col" style="width: 20%">Thể loại</th>
                                            <th scope="col" style="width: 15%">Thời lượng</th>
                                            <th scope="col" style="width: 20%">Khởi chiếu</th>
                                            <th scope="col" style="width: 5%"></th>
                                        </tr>
                                    </thead>
                                    <tbody>


                                        <c:forEach items="${listMovie}" var="m">
                                            <tr>

                                                <td style="font-weight: bold">${m.movieName}</td>
                                                <td>${m.category}</td>
                                                <td>${m.duration}</td>
                                                <td>${m.startdate}</td>


                                                <td><a href="editslot?movieId=${m.movieId}&roomId=${roomId}&date=${date}&slot=${slot.slot}&timeroomId=${timeroomId}">Chọn</a></td>


                                            </tr>

                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-btn">
                            <button type="button" onclick="closeModalChoose()" class="custom-btn btn-crud"><span>Đóng !</span><span>Đóng</span></button>
                        </div> 
                    </form>
                </div>
            </div>



            <!--modal choose room-->
            <div class="modal-edit-nofi modal-choose" id="modal-edit-choose-room">
                <div class="modal-nofi-overlay"></div>
                <div class="modal-edit-small modal-dialog-scrollable">
                    <form class="full-width" action="" method="post">
                        <h5 class="modal-edit-title">Chọn phòng</h5>
                        <div class="modal-edit-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Phòng</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <%for (int n = 0; n < listroom.size(); n++) {%>
                                        <tr>
                                            <td><%=listroom.get(n).getRoomName()%></td>
                                            <c:if test="${add==true}">
                                                <td><a href="updateschedule?roomId=<%=listroom.get(n).getRoomId()%>&movieId=${movieId}&date=${date}&add=true">Chọn</a></td>
                                            </c:if>
                                            <c:if test="${edit==true}">
                                                <td><a href="editslot?roomId=${roomId}&movieId=${movieId}&date=${date}&slot=${slot.slot}&timeroomId=${timeroomId}&roomIdNew=<%=listroom.get(n).getRoomId()%>">Chọn</a></td>
                                            </c:if>

                                        </tr>
                                        <%}%>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-btn">
                            <button type="button" onclick="closeModalChoose()" class="custom-btn btn-crud"><span>Close !</span><span>Close</span></button>
                        </div> 
                    </form>
                </div>
            </div>
            <!--modal choose slot-->   

            <div class="modal-edit-nofi modal-choose" id="modal-edit-choose-slot">
                <div class="modal-nofi-overlay"></div>
                <div class="modal-edit-medium modal-dialog-scrollable">
                    <!--<form class="full-width" action="updateschedule" method="get">-->
                    <div class="full-width">
                        <h5 class="modal-edit-title">Chọn slot</h5>
                        <div class="modal-edit-body">
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Slot</th>
                                            <th scope="col">Bắt đầu</th>
                                            <th scope="col">Kết thúc</th>
                                            <th scope="col"></th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                        <% //ArrayList<MovieTime> slots = (ArrayList<MovieTime>) request.getAttribute("slots");%>
                                        <c:if test="${slots!=null}">
                                            <%Time min = null;%>
                                            <%Time max = null;%>
                                            <%for (int k = 1; k <= 10; k++) {%>
                                            <%boolean checkd = false;%>

                                            <%for (int g = 0; g < slots.size(); g++) {%>
                                            <%if (slots.get(g).getSlot() == k) {%>
                                            <tr>
                                                <td><%=slots.get(g).getSlot()%></td>
                                                <td><fmt:formatDate pattern="HH:mm" type="time" value="<%=slots.get(g).getStart()%>"/></td>
                                                <td><fmt:formatDate pattern="HH:mm" type="time" value="<%=slots.get(g).getFinish()%>"/></td>

                                                <td><a>Đã chọn</a></td>
                                            </tr>


                                            <%checkd = true;%>
                                            <%min = slots.get(g).getFinish();%>
                                            <%}
                                                    if (checkd) {
                                                        break;
                                                    }
                                                }
                                                if (!checkd) {%>

                                            <tr>

                                        <form class="full-width" <c:if test="${add==true}">action="updateschedule"</c:if><c:if test="${edit==true}">action="editslot"</c:if> id="form-submit" method="get">
                                            <c:if test="${add==true}">
                                                <td><input type="text" name="slot" value="<%=k%>" hidden=""><%=k%></td>
                                                <input type="text" name="add" value="true" hidden="">
                                            </c:if>
                                            <input type="text" name="roomId" value="${roomId}" hidden="">
                                            <c:if test="${edit==true}">


                                                <td> <input type="text" name="slotNew" value="<%=k%>" hidden=""><%=k%></td>
                                                <input type="text" name="slot" value="${slot.slot}" hidden="">


                                                <input  type="text" name="roomIdNew" value="${roomIdNew}" hidden="">
                                                <input type="text" name="timeroomId" value="${timeroomId}" hidden="">
                                            </c:if>
                                            <input type="text" name="date" value="${date}" hidden="">
                                            <input type="text" name="movieId" value="${movieId}" hidden="">

                                            <td><input onchange="valueSubmit()" style="margin-top: 5px;" type="time" id="start"  required></td>
                                            <td><input onchange="valueSubmit()" style="margin-top: 5px;" type="time" id="finish" required></td>

                                            <td><button id="submit-time" class="btn-movie " ><a>Chọn</a></button></td>
                                        </form>

                                        </tr>

                                        <%}
                                            }%>



                                    </c:if>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-btn">
                            <button type="button" onclick="closeModalChoose()" class="custom-btn btn-crud"><span>Close !</span><span>Close</span></button>
                        </div> 

                    </div>
                </div>
            </div>
        </div>

        <div >
            <div class="modal-tool-nofi" id="admin-tool-modal" >
                <div class="modal-nofi-overlay"></div>
                <div class="modal-tool modal-dialog-scrollable">
                    <div class="full-width">
                        <img style="position: absolute;right: 0;cursor: pointer" onclick="closeTool()" src="${pageContext.request.contextPath}/image/close-white.png">
                        <h5 class="modal-add-title">Hộp tiện ích</h5>
                        <div class="modal-add-body" style="text-align: center">
                            <div class="add-input-option">

                                <button style="margin: 0  auto;width: 70%" type="button" onclick="setupLongDay()" class="neon-button">Áp dụng lịch 7 ngày tới</button>
                            </div>
                            <div class="add-input-option">
                                <form id="displaybook" action="displaybook" method="post" style="width: 100%;height: 100%">
                                    <input name="date" value="${date}" hidden>
                                    <button style="margin: 0  auto;width: 70%;height: 100%" type="button" <%if(displaybook!=0){%> onclick="displayBook()" <%}else{%>  onclick="displayBookMess()" <%}%> class="neon-button">Hiển thị tất cả trên đặt vé</button>
                                </form>
                            </div>

                                <label id="messDisplaybook" style="color: #FF0000;margin: 10px auto"></label>
                        </div>

                        </dic>
                    </div>
                </div>
            </div>
            <style>
                #admin-edit-modal{
                    display: none;
                }
                #admin-tool-modal{
                    display: none;
                }
                #modal-edit-choose-movie{
                    display: none;
                }
                #modal-edit-choose-slot{
                    display: none;
                }
                #modal-edit-choose-room{
                    display: none;
                }


                .modal-edit-nofi{
                    position:fixed;
                    top:0;
                    right:0;
                    left:0;
                    bottom:0;
                    z-index: 9999999;
                    display: flex;
                }

                .modal-tool-nofi{
                    position:fixed;
                    top:0;
                    right:0;
                    left:0;
                    bottom:0;
                    z-index: 9999999;
                    display: flex;
                }
                .modal-edit-nofi-overlay{
                    position: absolute;
                    width: 100%;
                    height: 100%;
                    background-color: rgba(0,0,0,0.2);
                }
                .modal-edit{
                    width: 30rem;
                    /* modal height here*/
                    height: 21rem;
                    top: 48%;
                    left: 20%;
                    transform: translate(-50%, -50%);
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                }
                .modal-add{
                    width: 30rem;
                    /* modal height here*/
                    height: 21rem;
                    top: 48%;
                    left: 20%;
                    transform: translate(-50%, -50%);
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                }
                .modal-tool{
                    width: 20rem;
                    /* modal height here*/
                    height: 15rem;
                    top: 0;
                    left: 0;
                    bottom: 0;
                    right: 0;
                    /*transform: translate(-50%, -50%);*/
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                }
                .modal-edit-movieroom{
                    width: 29rem;
                    /* modal height here*/
                    height: 25rem;
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                }
                .modal-edit-movie{
                    width: 49rem;
                    /* modal height here*/
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                    max-height: calc(100vh - 200px);
                    overflow-y: auto;
                }

                .full-width{
                    width: 100%;
                }
                .modal-edit-medium{
                    width: 26rem;
                    /* modal height here*/
                    max-height: 32rem;
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                    overflow-y: auto;
                }
                .modal-edit-small{
                    width: 20rem;
                    /* modal height here*/
                    max-height: 28rem;
                    margin: auto;
                    position: relative;
                    background-color: #fff;
                    border-radius:5px;
                    overflow-y: auto;
                }
                .button-icon{
                    font-size: 1.2rem;
                    padding: 0 8px;
                    line-height: 1.5rem;
                    height: 2rem;
                    margin: 5px 10px;
                    /*border: none;*/
                    cursor: pointer;
                }


            </style>

            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"
            ></script>
            <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
            <script
                src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
                crossorigin="anonymous"
            ></script>
            <script>
                                        function displayBook() {
                                            var result = confirm("Bạn có chắc muốn hiển thị tất cả lịch ngày này trên đặt vé không? Khi đã hiển thị sẽ không thể thay đổi lại.");
                                            if (result) {
                                                document.getElementById("displaybook").submit();
                                            }
                                        }

                                        function displayBookMess() {
                                            document.getElementById("messDisplaybook").innerHTML="Không còn suất chiếu nào chưa hiển thị."
                                        }

                                        function openTool() {
                                            document.getElementById("admin-tool-modal").style.display = "flex";
                                            if (document.getElementById("modal-edit-small") !== null) {
                                                document.getElementById("modal-edit-small").style.display = "none";
                                            }
                                        }
                                        function closeTool() {
                                            document.getElementById("admin-tool-modal").style.display = "none";
                                        }

                                        function dropdown() {
                                            if (document.getElementById("dropdown-menu").style.display === "none") {
                                                document.getElementById("dropdown-menu").style.display = "block";
                                            } else {
                                                document.getElementById("dropdown-menu").style.display = "none";
                                            }
                                        }


                                        function showDelMess(id) {
                                            var result = confirm("Bạn có chắc muốn xóa slot này?");
                                            if (result === true) {
                                                window.location.href = 'deleteslot?timeroomId=' + id;
                                            }
                                        }


                                        function closeModalChoose() {
                                            var x = document.querySelectorAll(".modal-choose");
                                            for (var i = 0; i < x.length; i++) {
                                                if (x[i].style.display !== "none") {
                                                    x[i].style.display = "none";
                                                }
                                            }
                                            if (document.getElementById("modal-add-movie") !== null) {
                                                document.getElementById("modal-add-movie").style.display = "flex";
                                            } else if (document.getElementById("modal-update-movie") !== null) {
                                                document.getElementById("modal-update-movie").style.display = "flex";
                                            }
                                        }



                                        function checkAdd() {
                                            var mess1 = document.querySelector('input[name=addimg]');
                                            var mess1Trim = mess1.value.trim();
                                            var mess1ReplaceSpace = mess1Trim.replace(/\s\s+/g, ' ');
                                            console.log(mess1ReplaceSpace);
                                            if (mess1ReplaceSpace.length > 50 || mess1ReplaceSpace.length < 6) {
                                                mess1.setCustomValidity('Description nằm trong khoảng 6 đến 50 ký tự');
                                            } else {
                                                mess1.setCustomValidity('');
                                            }

                                            var mess2 = document.querySelector('input[name=addtitle]');
                                            var mess2Trim = mess2.value.trim();
                                            var mess2ReplaceSpace = mess2Trim.replace(/\s\s+/g, ' ');
                                            console.log(mess2ReplaceSpace);
                                            if (mess2ReplaceSpace.length > 250 || mess2ReplaceSpace.length < 6) {
                                                mess2.setCustomValidity('Description nằm trong khoảng 6 đến 250 ký tự');
                                            } else {
                                                mess2.setCustomValidity('');
                                            }

                                            var mess3 = document.querySelector('textarea[name=adddescription]');
                                            var mess3Trim = mess3.value.trim();
                                            var mess3ReplaceSpace = mess3Trim.replace(/\s\s+/g, ' ');
                                            console.log(mess3ReplaceSpace);
                                            if (mess3ReplaceSpace.length > 2500 || mess3ReplaceSpace.length < 6) {
                                                mess3.setCustomValidity('Description nằm trong khoảng 6 đến 2500 ký tự');
                                            } else {
                                                mess3.setCustomValidity('');
                                            }
                                        }

                                        function openChooseMovie() {
                                            document.getElementById("modal-choose-movie").style.display = "flex";
                                            if (document.getElementById("modal-add-movie") !== null) {
                                                document.getElementById("modal-add-movie").style.display = "none";
                                            }
                                        }

                                        function openchooseRoom() {
                                            document.getElementById("modal-choose-room").style.display = "flex";
                                            if (document.getElementById("modal-edit-small") !== null) {
                                                document.getElementById("modal-edit-small").style.display = "none";
                                            }
                                        }
                                        function openChooseTime() {
                                            document.getElementById("modal-choose-slot").style.display = "flex";
                                            if (document.getElementById("modal-edit-medium") !== null) {
                                                document.getElementById("modal-edit-medium").style.display = "none";
                                            }
                                        }

                                        function checkSearch() {
                                            var mess = document.querySelector('input[name=searchtxt]');
                                            var messTrim = mess.value.trim();
                                            var messReplaceSpace = messTrim.replace(/\s\s+/g, ' ');
                                            console.log(messReplaceSpace);
                                            if (messReplaceSpace.length == 0) {
                                                mess.setCustomValidity('Can not be empty!');
                                            } else {
                                                mess.setCustomValidity('');
                                            }
                                        }


                                        function openEditModal() {
                                            document.getElementById("admin-edit-modal").style.display = "flex";
                                        }
                                        function closeModal() {
                                            var x = document.querySelectorAll(".modal-nofi");
                                            for (var i = 0; i < x.length; i++) {
                                                if (x[i].style.display !== "none") {
                                                    x[i].style.display = "none";
                                                }
                                            }
                                        }

                                        function openEditchooseRoom() {
                                            document.getElementById("modal-edit-choose-room").style.display = "flex";
                                            if (document.getElementById("modal-edit-small") !== null) {
                                                document.getElementById("modal-edit-small").style.display = "none";
                                            }

                                        }
                                        function openEditChooseMovie() {
                                            document.getElementById("modal-edit-choose-movie").style.display = "flex";
                                            if (document.getElementById("modal-edit-movie") !== null) {
                                                document.getElementById("modal-edit-movie").style.display = "none";
                                            }
                                        }

                                        function openEditChooseSlot() {
                                            document.getElementById("modal-edit-choose-slot").style.display = "flex";
                                            if (document.getElementById("modal-edit-medium") !== null) {
                                                document.getElementById("modal-edit-medium").style.display = "none";
                                            }
                                        }
                                        function ChooseMovie(roomId, movieId, date) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/updateschedule",
                                                data: {
                                                    movieId: movieId,
                                                    date: date,
                                                    roomId: roomId
                                                },
                                                beforeSend: function () {
                                                    $("#modal-choose-movie").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-add-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-add-modal").show();
                                                }
                                            });
                                        }

                                        function ChooseRoom(movieId, date, roomId) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/updateschedule",
                                                data: {
                                                    movieId: movieId,
                                                    date: date,
                                                    roomId: roomId
                                                },
                                                beforeSend: function () {
                                                    $("#modal-choose-room").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-add-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-add-modal").show();
                                                }
                                            });
                                        }

                                        function ChooseTime(date, slot, start, finish, roomId, movieId) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/updateschedule",
                                                data: {
                                                    movieId: movieId,
                                                    date: date,
                                                    roomId: roomId,
                                                    start: start,
                                                    finish: finish,
                                                    slot: slot
                                                },
                                                beforeSend: function () {
                                                    $("#modal-choose-slot").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-add-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-add-modal").show();
                                                }
                                            });
                                        }


                                        function closeEditModalChoose() {
                                            var x = document.querySelectorAll(".modal-choose");
                                            for (var i = 0; i < x.length; i++) {
                                                if (x[i].style.display !== "none") {
                                                    x[i].style.display = "none";
                                                }
                                            }
                                            if (document.getElementById("modal-add-movie") !== null) {
                                                document.getElementById("modal-add-movie").style.display = "flex";
                                            }
                                        }
                                        function valueSubmit(timeroomId, index, slot, roomId, movieId) {
                                            var start = document.querySelectorAll("#start");
                                            var finish = document.querySelectorAll("#finish");
                                            var cell = document.querySelectorAll("#submit-time");
                                            for (var i = 0; i < cell.length; i++) {
                                                if (index == i)
                                                    cell[i].setAttribute("onclick", "selectTime(" + timeroomId + "," + slot + ",'" + start[i].value + ":00','" + finish[i].value + ":00'," + roomId + "," + movieId + ")");
                                            }

                                        }

                                        function valueSubmitAdd(date, index, slot, roomId, movieId) {
                                            var start = document.querySelectorAll("#start");
                                            var finish = document.querySelectorAll("#finish");
                                            var cell = document.querySelectorAll("#submit-time");
                                            for (var i = 0; i < cell.length; i++) {
                                                if (index == i)
                                                    cell[i].setAttribute("onclick", "ChooseTime('" + date + "'," + slot + ",'" + start[i].value + ":00','" + finish[i].value + ":00'," + roomId + "," + movieId + ")");
                                            }

                                        }

                                        function checkSubmitForm() {
                                            var movieId = document.getElementsByName("movieId");
                                            var timeroomId = document.getElementsByName("timeroomId");
                                            var slot = document.getElementsByName("slot");
                                            var start = document.getElementsByName("start");
                                            var finish = document.getElementsByName("finish");
                                            var roomId = document.getElementsByName("roomId");
                                            if (movieId[0].value.length > 0 && timeroomId[0].value.length > 0 && slot[0].value.length > 0 && start[0].value.length > 0 && finish[0].value.length > 0 && roomId[0].value.length > 0) {
                                                document.getElementById("edit-slotForm").submit();
                                            } else {
                                                document.getElementById("mess-test").innerHTML = "Thiếu thông tin cập nhật!";
                                            }
                                        }

                                        function checkSubmitFormAdd() {
                                            var movieId = document.getElementsByName("movieId");
                                            var dateroom = document.getElementsByName("dateRoom");
                                            var slot = document.getElementsByName("slot");
                                            var start = document.getElementsByName("start");
                                            var finish = document.getElementsByName("finish");
                                            var roomId = document.getElementsByName("roomId");
                                            if (movieId[0].value.length > 0 && dateroom[0].value.length > 0 && slot[0].value.length > 0 && start[0].value.length > 0 && finish[0].value.length > 0 && roomId[0].value.length > 0) {
                                                document.getElementById("Add-form").submit();
                                                //                                        document.getElementById("mess-text").innerHTML = "oke!";
                                            } else {
                                                document.getElementById("mess-text").innerHTML = "Thiếu thông tin cập nhật!";
                                            }

                                        }

                                        function selectTime(timeroomId, slotnew, startd, finishd, roomID, movieID) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/editslot",
                                                data: {
                                                    timeroomId: timeroomId,
                                                    slot: slotnew,
                                                    start: startd,
                                                    finish: finishd,
                                                    roomId: roomID,
                                                    movieId: movieID
                                                },
                                                beforeSend: function () {
                                                    $("#admin-add-modal ").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-edit-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-edit-modal").show();
                                                }
                                            });
                                        }

                                        function selectRoom(movieId, timeroomId, roomId) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/editslot",
                                                data: {
                                                    timeroomId: timeroomId,
                                                    movieId: movieId,
                                                    roomId: roomId
                                                },
                                                beforeSend: function () {
                                                    $("#admin-add-modal ").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-edit-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-edit-modal").show();
                                                }
                                            });
                                        }

                                        function closeEditModal() {
                                            var x = document.querySelectorAll(".modal-edit-nofi");
                                            for (var i = 0; i < x.length; i++) {
                                                if (x[i].style.display !== "none") {
                                                    x[i].style.display = "none";
                                                }
                                            }
                                        }


                                        function openEditSchedule(timeroomID) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/editslot",
                                                data: {
                                                    timeroomId: timeroomID
                                                },
                                                beforeSend: function () {
                                                    $("#admin-add-modal ").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-edit-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-edit-modal").show();
                                                }
                                            });
                                        }

                                        function openAddSchedule(date) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/updateschedule",
                                                data: {
                                                    date: date
                                                },
                                                beforeSend: function () {
                                                    $("#admin-edit-modal ").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-add-schedule");
                                                    c.innerHTML = data;
                                                    //                                            document.getElementById("mess-text").innerHTML=date;
                                                    $("#admin-add-modal").show();
                                                }
                                            });
                                        }
                                        function selectMovie(movieId, timeroomID) {
                                            $.ajax({
                                                type: "get",
                                                url: "${pageContext.request.contextPath}/editslot",
                                                data: {
                                                    timeroomId: timeroomID,
                                                    movieId: movieId
                                                },
                                                beforeSend: function () {
                                                    $("#modal-edit-choose-movie").hide();
                                                },
                                                success: function (data) {
                                                    var c = document.getElementById("modal-edit-schedule");
                                                    c.innerHTML = data;
                                                    $("#admin-edit-modal").show();
                                                }
                                            });
                                        }


            </script>
    </body>
</html>
