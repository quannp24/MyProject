

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <title>BoomCinema-Phòng chiếu</title>
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
                        <h1 class="fs-3"><i class="fa fa-users" aria-hidden="true"></i> Quản lý phòng chiếu</h1>
                    </div>
                </div>


            </div>
            <div style="display: flex;">
                <div class=" " style="width: 38%;margin: 2%;background-color: rgba(225, 225, 225, 0.8);border-radius:5px;height: 18rem;">
                    <form  action="aeditroom" method="post" >
                        <h5 class="modal-add-title">Sửa phòng</h5>
                        <div class="modal-body" style="padding-bottom: 0;">
                            <div class="form-group ">
                                <label>Tên phòng</label>
                                <input value="${room.roomName}" name="roomName" type="text" class="form-control" required>
                                <input hidden value="${room.roomId}" name="roomId" type="text" class="form-control" required>

                            </div>

                        </div>
                        <p style="color: red;font-size: 14px;margin-left: 20px;">${error}</p>
                        <p style="color: rgba(45, 145, 0, 0.83);font-size: 14px;margin-left: 20px;">${mess}</p>
                        <div class="modal-btn">
                            <button onclick="checkAdd()"  type="submit" class="custom-btn btn-crud"><span>Cập nhật !</span><span>Cập nhật</span></button>

                        </div> 
                    </form>
                    <!--</div>-->
                </div>


                <div class="admin-table table-responsive" style="width: 58%; margin: 2%;background-color: rgba(225, 225, 225, 0.8); border-radius:5px; ">
                    <table class="table table-hover">
                        <thead>
                            <tr>

                                <th style="width: 20%;text-align: center;">ID Phòng</th>
                                <th style="width: 50%;text-align: center;">Tên Phòng</th>
                                <th style="width: 15%"></th>
                                <th style="width: 15%"></th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${rooms}" var="r" varStatus="i" >
                                <tr>

                                    <td style="width: 20%;text-align: center;">${r.roomId}</td>
                                    <td style="width: 50%;text-align: center;">${r.roomName}</td>
                                    <td>                    
                                        <a href="aeditroom?id=${r.roomId}"  class="custom-btn btn-crud"><span>Sửa ngay!</span><span>Sửa</span></a>
                                    </td>
                                    <td>                                
                                        <a href="#" onclick="showDelMess(${r.roomId})"  class="custom-btn btn-crud"><span>Xóa ngay !</span><span>Xóa</span></a>
                                    </td>
                                </tr>

                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <!--pagging-->


                <!--static-->

            </div>
            <!--footer-->


        </section>





        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"
        ></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
            crossorigin="anonymous"
        ></script>
        <script>
                                            function dropdown() {
                                                if (document.getElementById("dropdown-menu").style.display === "none") {
                                                    document.getElementById("dropdown-menu").style.display = "block";
                                                } else {
                                                    document.getElementById("dropdown-menu").style.display = "none";
                                                }
                                            }


                                            function showDelMess(id) {
                                                var result = confirm("Bạn có chắc muốn xóa phòng này?");
                                                if (result === true) {
                                                    window.location.href = 'adeleteroom?id=' + id;
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


        </script>
    </body>
</html>
