<%-- 
    Document   : UserProfile
    Created on : May 21, 2022, 10:56:45 PM
    Author     : senan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
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
            <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/button-neon.css" />

            <!-- Sakura -->
            <link href="${pageContext.request.contextPath}/css/jquery-sakura.css" rel="stylesheet" type="text/css">
            <title>BoomCinema-Profile</title>
        </head>



        <body>

            <!--        HEADER-->
            <%@include file="template/header.jsp" %>


            <!-- CONTAINER       -->
            <div class="container-xl px-4 mt-4">


                <hr class="mt-0 mb-4">
                <div class="row">
                    <div class="col-xl-4">
                        <!-- Profile picture card-->
                        <div class="card mb-4 mb-xl-0">
                            <div class="card-header">Ảnh đại diện</div>
                            <div class="card-body text-center">
                                <!-- Profile picture image-->
                                <img class="img-account-profile rounded-circle mb-2" src="${pageContext.request.contextPath}/${requestScope.account.img}" alt="">
                                <!-- Profile picture help block-->
                                <!--                            <div class="small font-italic text-muted mb-4">JPG or PNG no larger than 5 MB</div>-->
                                <!-- Profile picture upload button-->
                                <!--                            <button class="btn btn-primary" type="button">Upload new image</button>-->
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-8">
                        <!-- Account details card-->
                        <div class="card mb-4">
                            <div class="card-header">Thông tin chi tiết</div>
                            <div class="card-body">
                                <form action="accountedit" method="post" enctype="multipart/form-data">
                                    <!-- Form Group (fullname)-->
                                    <div class="mb-3">
                                        <label class="small mb-1">Họ tên</label>
                                        <input name="fullname" class="form-control" required type="text" placeholder="Enter your fullname" value="${requestScope.account.fullname}" required readonly>
                                    </div>
                                    <!-- Form Row-->
                                    <div class="row gx-3 mb-3">

                                        <div class="col-md-6">
                                            <label class="small mb-1">Email</label>
                                            <input name="email" class="form-control" type="email" placeholder="Enter your email address" value="${requestScope.account.email}" required readonly>
                                        </div>
                                        <!-- Form Group (password)-->

                                        <div class="col-md-12">
                                            <label class="small mb-1">Địa chỉ</label>
                                            <input name="address" class="form-control" type="text" placeholder="Nhập địa chỉ của bạn" value="${requestScope.account.address}" readonly="" >
                                        </div>
                                    </div>
                                    <!-- Form Row        -->
                                    <div class="row gx-3 mb-3">
                                        <!-- Form Group (avatar)-->
                                        <div class="col-md-6">
                                            <label class="small mb-1">Giới tính</label></br>
                    
                                            <c:if test="${requestScope.account.gender==true}">
                                                <label class="small mb-1">Nam</label>
                                            </c:if>
                                            <c:if test="${requestScope.account.gender==false}">
                                                <label class="small mb-1">Nữ</label>
                                            </c:if>
                                        </div>
                                        <!-- Form Group (role id)-->
                                        <div class="col-md-6">
                                            <input name="roleid" class="form-control" type="hidden" value="${sessionScope.account.role}" required>
                                        </div>
                                    </div>

                                    <!-- Form Row-->
                                    <div class="row gx-3 mb-3">
                                        <!-- Form Group (phone number)-->
                                        <div class="col-md-6">
                                            <label class="small mb-1">Số điện thoại</label>
                                            <input name="phone" class="form-control"   type="number" placeholder="Enter your phone number" value="${requestScope.account.phone}" required readonly>
                                        </div>
                                        <!-- Form Group (birthday)-->
                                        <div class="col-md-6">
                                            <label class="small mb-1">Ngày sinh</label>
                                            <input name="dob" class="form-control"  type="date" placeholder="Enter your birthday" value="${requestScope.account.dob}" required readonly>
                                        </div>
                                    </div>
                                    <!--                                Edit message    -->
                                    <p style="color: red;font-size: 14px">${failMessage}</p>
                                    <p style="color: red;font-size: 14px">${mess}</p>
                                    <p style="color: green;font-size: 14px">${successMessage}</p>
                                    <!-- Save changes button-->
                                    <a class="btn btn-primary" href="editaccount?id=${sessionScope.account.accId}">Thay đổi</a>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>


            </div>


            <!--                                    CSS-->
            <style>
                body{
                    background-color:#f2f6fc;
                    color:#69707a;
                }
                .img-account-profile {
                    height: 10rem;
                }
                .rounded-circle {
                    border-radius: 50% !important;
                }
                .card {
                    box-shadow: 0 0.15rem 1.75rem 0 rgb(33 40 50 / 15%);
                }
                .card .card-header {
                    font-weight: 500;
                }
                .card-header:first-child {
                    border-radius: 0.35rem 0.35rem 0 0;
                }
                .card-header {
                    padding: 1rem 1.35rem;
                    margin-bottom: 0;
                    background-color: rgba(33, 40, 50, 0.03);
                    border-bottom: 1px solid rgba(33, 40, 50, 0.125);
                }
                .form-control, .dataTable-input {
                    display: block;
                    width: 100%;
                    padding: 0.875rem 1.125rem;
                    font-size: 0.875rem;
                    font-weight: 400;
                    line-height: 1;
                    color: #69707a;
                    background-color: #fff;
                    background-clip: padding-box;
                    border: 1px solid #c5ccd6;
                    -webkit-appearance: none;
                    -moz-appearance: none;
                    appearance: none;
                    border-radius: 0.35rem;
                    transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
                }

                .nav-borders .nav-link.active {
                    color: #0061f2;
                    border-bottom-color: #0061f2;
                }
                .nav-borders .nav-link {
                    color: #69707a;
                    border-bottom-width: 0.125rem;
                    border-bottom-style: solid;
                    border-bottom-color: transparent;
                    padding-top: 0.5rem;
                    padding-bottom: 0.5rem;
                    padding-left: 0;
                    padding-right: 0;
                    margin-left: 1rem;
                    margin-right: 1rem;
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
            </script>

            <!--        FOOTER-->
            <%@include file="template/footer.jsp" %>


        </body>
    </html>
