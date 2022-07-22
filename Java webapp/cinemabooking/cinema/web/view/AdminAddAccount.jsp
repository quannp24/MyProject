<%-- 
    Document   : AdminAddAccount
    Created on : 04-06-2022, 19:30:08
    Author     : Quan
--%>



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
        <title>BoomCinema-Quản lý tài khoản</title>
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
                    width="65"
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
                        <h1 class="fs-3"><i class="fa fa-users" aria-hidden="true"></i> Quản lý tài khoản người dùng</h1>
                    </div>
                </div>
                <div style="display: flex; justify-content: end; margin: 10px">
                    <div class="dropdown" style="margin-right: 20px">

                        <c:if test="${requestScope.role=='3'}">
                            <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                Người dùng
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item " href="usermanagement?role=2">Nhân viên</a>
                                <a class="dropdown-item" href="usermanagement?role=0">Tất cả</a>
                            </c:if>
                            <c:if test="${requestScope.role=='2'}">
                                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Nhân viên
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                    <a class="dropdown-item" href="usermanagement?role=3">Người dùng</a>
                                    <a class="dropdown-item " href="usermanagement?role=0">Tất cả</a>
                                </c:if>
                                <c:if test="${requestScope.role=='0'}">
                                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        Chọn chức năng người dùng
                                    </button>
                                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                        <a class="dropdown-item" href="usermanagement?role=3">Người dùng</a>
                                        <a class="dropdown-item" href="usermanagement?role=2">Nhân viên</a>
                                    </c:if>


                                </div>
                            </div>
                            <!--<button onclick="openAddModal()"  class="custom-btn btn-crud"><span>Add !</span><span>Add more</span></button>-->
                            <a href="adminaccountadd" class="custom-btn btn-crud"><span>Thêm ngay !</span><span>Thêm user</span></a>

                        </div>
                        <div class="admin-table table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th>Email</th>
                                        <th>Họ tên</th>
                                        <th>Địa chỉ</th>
                                        <th>Số điện thoại</th>
                                        <th></th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <% Integer count = (Integer) request.getAttribute("pageIndex");%>
                                <% count = (count - 1) * 5 + 1;%>
                                <tbody>
                                    <c:forEach items="${accountList}" var="account" varStatus="i" >
                                        <tr>
                                            <th scope="row"><%=count%></th>
                                            <td>${account.email}</td>
                                            <td>${account.fullname}</td>
                                            <td>${account.address}</td>
                                            <td>${account.phone}</td>
                                            <td>                    
                                                <a href="adminaccountedit?email=${account.email}"  class="custom-btn btn-crud"><span>Sửa!</span><span>Chỉnh sửa</span></button></a>
                                            </td>
                                            <td>                                    
                                                <button onclick="showDelMess('${account.email}',${account.role})"  class="custom-btn btn-crud"><span>Xóa ngay !</span><span>Xóa</span></button>
                                            </td>
                                        </tr>
                                        <% count = count + 1;%>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <!--pagging-->
                        <c:if test="${searchtxt!=null}">
                            <div class="clearfix">
                                <div class="hint-text">Hiển thị <b>${accountList.size()}</b> người dùng trong tổng số <b>${total}</b> người dùng</div>
                                <ul class="pagination">
                                    <c:if test="${pageIndex>1}">
                                        <li class="page-item disabled"><a href="adminaccountsearch?pageIndex=${pageIndex-1}&searchtxt=${searchtxt}">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="adminaccountsearch?pageIndex=${pageIndex-1}&searchtxt=${searchtxt}">${pageIndex-1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex!=null}">
                                        <li class="page-item active"><a class="page-link" href="adminaccountsearch?pageIndex=${pageIndex}&searchtxt=${searchtxt}">${pageIndex}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex<endPage}">
                                        <li class="page-item"><a class="page-link" href="adminaccountsearch?pageIndex=${pageIndex+1}&searchtxt=${searchtxt}">${pageIndex+1}</a></li>
                                        <li class="page-item"><a href="adminaccountsearch?pageIndex=${pageIndex+1}&searchtxt=${searchtxt}" class="page-link">Next</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${searchtxt==null}">
                            <div class="clearfix">
                                <div class="hint-text">Hiển thị <b>${accountList.size()}</b> người dùng trong tổng số <b>${total}</b> người dùng</div>
                                <ul class="pagination">
                                    <c:if test="${pageIndex>1}">
                                        <li class="page-item disabled"><a href="adminaccountlist?pageIndex=${pageIndex-1}&roleId=${accountList.get(0).role}">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="adminaccountlist?pageIndex=${pageIndex-1}&roleId=${accountList.get(0).role}">${pageIndex-1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex!=null}">
                                        <li class="page-item active"><a class="page-link" href="adminaccountlist?pageIndex=${pageIndex}&roleId=${accountList.get(0).role}">${pageIndex}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex<endPage}">
                                        <li class="page-item"><a class="page-link" href="adminaccountlist?pageIndex=${pageIndex+1}&roleId=${accountList.get(0).role}">${pageIndex+1}</a></li>
                                        <li class="page-item"><a href="adminaccountlist?pageIndex=${pageIndex+1}&roleId=${accountList.get(0).role}" class="page-link">Next</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </c:if>

                        <!--static-->
                        <%@include file="template/adminStatics.jsp" %>
                    </div>
                    <!--footer-->

                    </section>



                    <!--add modal-->
                    <div class="modal-nofi" id="admin-add-modal">
                        <div class="modal-nofi-overlay"></div>
                        <div class="modal-add modal-dialog-scrollable">
                            <form class="full-width" action="adminnotificationadd" method="post">
                                <h5 class="modal-add-title">Add movie</h5>
                                <div class="modal-body">
                                    <div class="form-group">
                                        <label>Notification Image</label>
                                        <input value="" name="addimg" type="text" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Notification Title</label>
                                        <input value="${successMessage==null? notification.notificationTitle:""}" name="addtitle" type="text" class="form-control" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Notification Description</label>
                                        <textarea value="${successMessage==null? notification.notificationDescription:""}" name="addescription" type="text" class="form-control">${successMessage==null? notification.notificationDescription:""}</textarea>
                                    </div>
                                    <div class="form-group">
                                        <!--<label>Notification Date</label>-->
                                        <input value="${currentdate}" name="adddate" type="date" class="form-control" hidden>
                                    </div>
                                    <p style="color: red;font-size: 14px">${failMessage}</p>
                                    <p style="color: red;font-size: 14px">${mess}</p>
                                    <p style="color: green;font-size: 14px">${successMessage}</p>                                

                                </div>
                                <div class="modal-btn">
                                    <button onclick="checkAdd()"  type="submit" class="custom-btn btn-crud"><span>Add now !</span><span>Add more</span></button>
                                    <button type="button" onclick="closeModal()" class="custom-btn btn-crud"><span>Close !</span><span>Close</span></button>
                                </div> 
                            </form>
                        </div>
                    </div>

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

                                        function showDelMess(username, roleId) {
                                            var result = confirm("Are you sure to delete?");
                                            if (result === true) {
                                                window.location.href = 'adminaccountdelete?username=' + username + '&roleId=' + roleId;
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

