<%-- 
    Document   : billdetail
    Created on : 18-03-2022, 13:10:04
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>



<html lang="en">

    <head>
        <meta charset="utf-8" />
        <title>Chi tiết hóa đơn - BM</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="img/d.png" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.0/dist/js/bootstrap.bundle.min.js"></script>
        <link href="css/import/ImportDetail.css" rel="stylesheet" type="text/css" />
        <script src="js/import/ImportDetail.js" type="text/javascript"></script>
    </head>

    <body>
        <div class="container">
            <div class="row gutters">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12 col-12">
                    <div class="card">
                        <div class="card-body p-0">
                            <div class="invoice-container">
                                <form action="editimport" method="POST" class="form-group">
                                    <div class="invoice-header">
                                        <!-- Row start -->
                                        <div class="row gutters">
                                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                                <div class="custom-actions-btns mb-5">
                                                    <!--                                                    <a href="#" class="btn btn-primary">
                                                                                                            <i class="icon-download"></i> Lưu hóa đơn
                                                                                                        </a>-->
                                                    <input type="submit" class="custom-actions-btns mb-5 btn btn-primary" value="Lưu hóa đơn">
                                                    <a href="" onclick="del(${requestScope.import.iid})" class="custom-actions-btns mb-5 btn btn-danger">
                                                        <i class="icon-printer"></i> Xóa
                                                    </a>
                                                    <a href="invoiceimport" class="custom-actions-btns mb-5 btn btn-secondary">
                                                        <i class="icon-printer"></i> Quay lại
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Row end -->
                                        <!-- Row start -->
                                        <div class="row gutters">
                                            <div class="col-xl-6 col-lg-6 col-md-6 col-sm-6">
                                                <a href="" class="invoice-logo">
                                                    Hóa đơn nhập hàng
                                                </a>
                                            </div>
                                        </div>
                                        <!-- Row end -->
                                        <!-- Row start -->

                                        <div class="row gutters">
                                            <div class="col-xl-9 col-lg-9 col-md-12 col-sm-12 col-12">
                                                <div class="invoice-details">
                                                    <address class="row">
                                                        <input class="col-12 form-control form-control-plaintext"  style="margin-bottom: 0.1em" name="name" type="text" value="${requestScope.import.iname}">
                                                        <input class="col-12 form-control form-control-plaintext" name="address" type="text" value="${requestScope.import.iaddress}">
                                                        <a class="col-5">SĐT <input class="form-control form-control-plaintext" name="phone" type="text" value="${requestScope.import.iphone}"></a>
                                                        <a class="col-7">Người nhận hàng: <input class="form-control form-control-plaintext" name="confirm" type="text" value="${requestScope.import.iconfirm}"></a>

                                                    </address>
                                                </div>
                                            </div>
                                            <div class="col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12">
                                                <div class="invoice-details">
                                                    <div class="invoice-num">
                                                        <div>Số hóa đơn <input class="form-control form-control-sm " id="exampleFormControlInput1" name="iid" readonly type="text" value="${requestScope.import.iid}"></div>
                                                        <div>Thời gian<input class="form-control form-control-sm " name="time" readonly type="text" value="${requestScope.import.time}"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Row end -->
                                    </div>
                                    <div class="invoice-body">
                                        <!-- Row start -->
                                        <div class="row gutters">
                                            <div class="col-lg-12 col-md-12 col-sm-12">
                                                <div class="table-responsive">
                                                    <table class="table custom-table m-0 inventory">
                                                        <thead>
                                                            <tr>
                                                                <th>Tên hàng</th>
                                                                <th>Số lượng</th>
                                                                <th>Đơn giá</th>
                                                                <th>Tổng</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${requestScope.details}" var="d">
                                                                <tr>
                                                                    <td>
                                                                        <input class="form-control form-control-sm form-control-plaintext" style="font-weight: bold" name="product" type="text" value="${d.iproduct}">
                                                                        <p class="m-0 text-muted" >
                                                                            <input class="form-control form-control-sm form-control-plaintext"  name="describe" type="text" value="${d.idescribe}">
                                                                        </p>
                                                                    </td>
                                                                    <td><input class="form-control form-control-sm form-control-plaintext" onkeyup="myadd()"  name="quantity" type="text" value="${d.iquantity}"></td>
                                                                    <td><input class="form-control form-control-sm form-control-plaintext" onkeyup="myadd()" name="unitprice" type="text" value="${d.iunitprice}"></td>
                                                                    <td><input class="form-control form-control-sm form-control-plaintext" readonly  name="price" type="text" value="${d.iprice}"></td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                    <table class="table custom-table m-0 balance">

                                                        <tr>
                                                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                                            <td colspan="5">
                                                                <p>
                                                                    <a>Tổng</a><br> 
                                                                    <a>Đã đưa</a><br> 
                                                                    <a>Còn lại</a><br>
                                                                </p>
                                                                <c:if test="${requestScope.import.idebt!=0}">
                                                                    <h5 class="text-danger"><strong>Chưa thanh toán</strong></h5>
                                                                    <a href="importdebt?iid=${requestScope.import.iid}&total=${requestScope.import.itotal}" class=" btn btn-danger">Xác nhận thanh toán</a>

                                                                </c:if>
                                                                <c:if test="${requestScope.import.idebt==0}">
                                                                    <h5 class="text-success"><strong>Đã thanh toán</strong></h5>
                                                                    <c:if test="${requestScope.importdebt.time!=null}">
                                                                        <a class="text-success">Ngày ${requestScope.importdebt.time}</a>
                                                                    </c:if>

                                                                </c:if>
                                                            </td>
                                                            <td>

                                                                <input class="form-control form-control-sm form-control-plaintext" readonly  name="total" type="text" value="${requestScope.import.itotal}">
                                                                <input class="form-control form-control-sm form-control-plaintext" onkeyup="myadd()"  name="payment" type="text" value="${requestScope.import.payment}"> 
                                                                <input class="form-control form-control-sm form-control-plaintext" readonly  name="debt" type="text" value="${requestScope.import.idebt}">


                                                            </td>
                                                        </tr>

                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Row end -->
                                    </div>
                                </form>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>


</html>
