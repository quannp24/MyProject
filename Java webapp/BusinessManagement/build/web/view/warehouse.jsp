<%-- 
    Document   : warehouse
    Created on : 15-03-2022, 15:38:34
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>



<html lang="en">

    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Kho - BM</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="img/d.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
        <script src="js/warehouse/pagger.js" type="text/javascript"></script>
    </head>

    <body class="d-flex flex-column h-100">
        <!-- <nav class="navbar navbar-light bg-light justify-content-between">
            <a class="navbar-brand">Navbar</a>
            <form class="form-inline">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
            </form>
        </nav> -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark" style="padding: 0px">
            <div class="container px-5">
                <a class="navbar-brand" href="home"><img src="img/dwhite.png" style="width: 20%" >Business Modern</a>

            </div>
        </nav>

        <div class="container">
            <div class="row flex-lg-nowrap">
                <div class="col-12 col-lg-auto mb-3" style="width: 200px;">
                    <div class="card p-3">
                        <div class="e-navlist e-navlist--active-bg">
                            <ul class="nav">
                                <li class="nav-item"><a class="nav-link px-2 active" href="manage"><i class="fa fa-fw fa-bar-chart mr-1"></i><span>Về trang quản lý</span></a></li>
                                <li class="nav-item"><a class="nav-link px-2" href="import" ><i class="fa fa-fw fa-th mr-1"></i><span>Nhập hàng</span></a></li>
                                <!--                                <li class="nav-item"><a class="nav-link px-2" href="" ><i class="fa fa-fw fa-cog mr-1"></i><span>Settings</span></a></li>-->
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="col">
                    <div class="e-tabs mb-3 px-3">
                        <ul class="nav nav-tabs">
                            <li class="nav-item"><a class="nav-link active" href="warehouse">Warehouse</a></li>

                        </ul>
                    </div>

                    <div class="row flex-lg-nowrap">


                        <div class="col mb-3">
                            <div class="e-panel card">
                                <div class="card-body">
                                    <div class="card-title">
                                        <h6 class="mr-2"><span>Kho</span><small class="px-1">Hàng hóa của cửa hàng</small></h6>
                                    </div>
                                    <div class="e-table">
                                        <div class="table-responsive table-lg mt-3">
                                            <table class="table table-bordered inventory" id="cutton">
                                                <thead>
                                                    <tr>

                                                        <th style="text-align: center">Sản phẩm</th>
                                                        <th class="max-width" style="text-align: center">Số lượng</th>
                                                        <th class="sortable" style="text-align: center">Thời gian</th>

                                                        <th></th>
                                                    </tr>

                                                </thead>
                                                <tbody id="geto">
                                                    <c:if test="${requestScope.wares!=null}" >
                                                        <c:forEach items="${requestScope.wares}" var="w" varStatus="l">
                                                            <c:if test="${requestScope.num==l.index}"> 
                                                                <tr> 
                                                            <form action="ewarehouse" method="POST">
                                                                <td class="text-nowrap align-middle" style="text-align: center"><input type="text" style="width: 80%" name="product" readonly value="${requestScope.edit.product}"></td>
                                                                <td class="text-nowrap align-middle" style="text-align: center"><input type="text" style="width: 80%" name="quantity" value="${requestScope.edit.quantity}"></td>
                                                                <td class="text-center align-middle"><input type="text" style="width: 80%" value="${requestScope.edit.time}" readonly></td>
                                                                <td class="text-center align-middle">
                                                                    <div class="btn-group align-top">
                                                                        <button class="btn btn-sm btn-outline-primary" type="submit" >Lưu</button>

                                                                    </div>
                                                                </td>
                                                            </form>
                                                            </tr>
                                                        </c:if>
                                                        <c:if test="${requestScope.num!=l.index}">
                                                            <tr>

                                                                <td class="text-nowrap align-middle" style="text-align: center">${w.product}</td>
                                                                <td class="text-nowrap align-middle" style="text-align: center">${w.quantity}</td>
                                                                <td class="text-center align-middle">${w.time}</td>
                                                                <td class="text-center align-middle">
                                                                    <div class="btn-group align-top">
                                                                        <a href="warehouse?edit=${l.index}"><button class="btn btn-sm btn-outline-secondary badge" type="button" >Edit</button></a>
                                                                        <a href="#"><button class="btn btn-sm btn-outline-secondary badge" onclick="deleteProduct(${w.num});" type="button"><i class="fa fa-trash"></i></button></a>

                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${requestScope.wares==null}" >
                                                    <tr>Danh sách trống</tr>
                                                </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                        <div class="d-flex justify-content-center">
                                            <ul class="pagination mt-3 mb-0" id="paggerbot">
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-lg-3 mb-3">
                            <div class="card">
                                <div class="card-body">

                                    <hr class="my-3">
                                    <div class="e-navlist e-navlist--active-bold">
                                        <ul class="nav">
                                            <li class="nav-item active"><a href="warehouse" class="nav-link"><span>Tất cả</span>&nbsp;<small>/&nbsp;${requestScope.totalrecords}</small></a></li>
                                                <jsp:useBean id="now" class="java.util.Date" />
                                                <fmt:formatDate var="month" value="${now}" pattern="MM" />
                                            
                                            <li class="nav-item"><a href="warehouse?month=${month}" class="nav-link"><span>Trong tháng</span></a></li>

                                        </ul>
                                    </div>
                                    <hr class="my-3">
                                    <div>

                                        <div class="form-group">
                                            <label>Tìm kiếm theo tên:</label>
                                            <form action="warehouse" method="POST">
                                                <div><input class="form-control w-100" type="text" placeholder="Name" name="search" value="${requestScope.search}"></div>

                                                <button class="btn btn-success btn-block" type="submit">Tìm kiếm</button>
                                            </form>
                                        </div>
                                    </div>                               
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- User Form Modal -->

                </div>
            </div>
        </div>

    </body>
    <script>

        pagger('paggerbot',${requestScope.pageindex},${requestScope.totalpage},'${requestScope.search}','${requestScope.month}', 3);
    </script>

</html>
