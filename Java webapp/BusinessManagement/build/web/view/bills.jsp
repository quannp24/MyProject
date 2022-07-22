<%-- 
    Document   : bills
    Created on : 17-03-2022, 16:56:38
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css" integrity="sha256-3sPp8BkKUE7QyPSl6VfBByBroQbKxKG7tsusY2mhbVY=" crossorigin="anonymous" />

        <title>Hóa đơn - BM</title>
        <link rel="icon" type="image/x-icon" href="img/d.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="css/sell/bills.css" rel="stylesheet" type="text/css"/>
        
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">

        <script src="js/sell/bills.js" type="text/javascript"></script>
    </head>
    <body>
        <div >
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="padding: 0px">
                <div class="container px-5">
                    <a class="navbar-brand" href="home"><img src="img/dwhite.png" style="width: 20%" >Business Modern</a>
                    <a class="navbar-brand" href="manage" style="font-size: 16px">Trang quản lý</a>
                </div>
            </nav>

            <div class="row">
                <div class="col-lg-10 mx-auto">
                    <div class="career-search mb-60">

                        <form action="bills" id="noww" method="POST" class="career-form mb-60">   <!--phần filter -->
                            <div class="row">
                                <div class="col-md-6 col-lg-4 my-4">
                                    <div class="input-group position-relative">
                                        <input type="text" class="custom-select" name="name" placeholder="Nhập tên khách hàng" id="keywords">
                                    </div>
                                </div>
                                <div class="col-md-6 col-lg-4 my-4">
                                    <div class="select-container">

                                        <select name="filter" class="custom-select">
                                            <option value="0" <c:if test="${requestScope.filter==0}">selected</c:if>>Lọc theo</option>
                                            <option value="1" <c:if test="${requestScope.filter==1}">selected</c:if>>Chưa thanh toán</option>
                                            <option value="2" <c:if test="${requestScope.filter==2}">selected</c:if>>Trong tháng này</option>

                                        </select>

                                    </div>
                                </div>

                                <div class="col-md-12 col-lg-4 my-4">
                                    <button type="submit"   class="btn btn-lg btn-block btn-light btn-custom" >
                                        Tìm kiếm
                                    </button>
                                </div>
                            </div>
                        </form>
                        <!--phần content  -->
                        <div class="filter-result">
                            <p class="mb-30 ff-montserrat">Tổng hóa đơn : ${requestScope.totalrecords}</p>

                            <!--phần element  -->
                            <c:forEach items="${requestScope.bills}" var="b">
                                <div class="job-box d-md-flex align-items-center justify-content-between mb-30">
                                    <div class="job-left my-4 d-md-flex align-items-center flex-wrap">
                                        <div class="img-holder mr-md-4 mb-md-0 mb-4 mx-auto mx-md-0 d-md-none d-lg-flex">
                                            ${fn:substring(b.name,0,1)}
                                        </div>
                                        <div class="job-content">
                                            <h5 class="text-center text-md-left">${b.name}</h5>
                                            <ul class="d-md-flex flex-wrap text-capitalize ff-open-sans">
                                                <li class="mr-md-4">
                                                    <i class="zmdi zmdi-pin mr-2"></i> ${b.address}
                                                </li>
                                                <li class="mr-md-4">
                                                    <i class="zmdi zmdi-money mr-2"></i> ${b.total}
                                                </li>
                                                <li class="mr-md-4">
                                                    <i class="zmdi zmdi-time mr-2"></i> ${b.time}
                                                </li>
                                                <li class="mr-md-4">
                                                    <i class="zmdi zmdi-file mr-2"></i> ${b.billcode}
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="job-right my-4 flex-shrink-0">
                                        <a href="billdetail?billcode=${b.billcode}" class="btn d-block w-100 d-sm-inline-block btn-light">Xem và chỉnh sửa</a>
                                    </div>
                                </div>
                            </c:forEach>


                        </div>
                    </div>

                    <!-- START Pagination -->
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-reset justify-content-center">
                            <ul class="pagination mt-3 mb-0" id="paggerbot"></ul>
                    </nav>
                    <!-- END Pagination -->
                </div>
            </div>

        </div>
    </body>
</html>
<script>

    pagger('paggerbot',${requestScope.pageindex},${requestScope.totalpage},'${requestScope.name}',${requestScope.filter}, 3);
</script>