<%-- 
    Document   : MyOrder
    Created on : 01-07-2022, 09:49:10
    Author     : Quan
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>BoomCinema-Vé của tôi</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">

        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>


        <link rel="stylesheet" href="css/myorder.css" />
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
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
        </script>
    </head>
    <body>
        <%@include file="template/header.jsp" %>
        <c:if test="${sessionScope.account ==null}">
            <div class="container mt-5 mb-3 p-3 cart-container" style="background:#e9ecef;font-family: 'Merriweather Sans', sans-serif;">
                <h4> Bạn phải đăng nhập để thực hiện tác vụ</h4>
            </div>
        </c:if>
        <c:if test="${sessionScope.account !=null}">
            <div class="container-xl" style="font-family: 'Merriweather Sans', sans-serif;">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div style="background-color: #212529" class="table-title">
                            <div class="row">
                                <div class="neon-title" style="width: auto;">
                                    <h2>Vé của tôi</h2>
                                </div>

                            </div>
                        </div>
                        <div class="table-filter">
                            <div class="row">

                                <div class="col-sm-12">
                                    <form action="searchorder" method="post">
                                        <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i></button>
                                        <div class="filter-group">
                                            <label>Ngày</label>
                                            <input value="${searchdate}" name="searchdate" value="" type="date" class="form-control"   placeholder="Tìm theo ngày" aria-label="Search" aria-describedby="search-addon" required/>
                                        </div>
                                    </form>


                                    <div class="filter-group">
                                        <form action ="orderfilter" method="get">
                                            <input type="hidden" name="pageIndex" value="${pageIndex1}"/>
                                            <select class="form-control"  name="status" onchange="this.form.submit()">

                                                <option value="2" ${status == 2 ? "selected" : ""}>Tất cả</option>
                                                <option value="1"${status == 1 ? "selected" : ""}>Còn hiệu lực</option>
                                                <option value="0"${status == 0 ? "selected" : ""}>Hết hiệu lực</option>

                                            </select>
                                        </form>
                                    </div>

                                    <span class="filter-icon"><i class="fa fa-filter"></i></span>
                                </div>
                            </div>
                        </div>
                        <!--                        <form action="SearchOrder" method="post" style="width:40%;min-width: 200px; margin: 10px auto 10px auto " class="input-group rounded">
                                                    <input value="" name="searchdate" value="" type="search" class="form-control rounded" placeholder="Search By Date" aria-label="Search" aria-describedby="search-addon" required/>
                                                    <button type="submit"  style="height:38px;" class="input-group-text border-0" id="search-addon">
                                                        <i class="fas fa-search"></i></a>
                                                    </button>
                                                </form>-->
                        <p style="color:red; text-align: center">${searchMess}</p>    
                        <table class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <!--<th>#</th>-->
                                    <th style="width: 20rem">Khách hàng</th>
                                    <th>Ngày</th>						
                                    <th>Trạng thái</th>						
                                    <th>Tổng giá</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${order}" var="o">
                                    <tr>
                                        <!--<td>${o.cartId}</td>-->
                                        <td><a href="#"> ${account.fullname}</a></td>   
                                        <td><fmt:formatDate pattern="EEEE, dd-MM-yyyy"  value = "${o.orderDate}"/></td>    
                                        <c:if test="${o.status == 1}">
                                            <td><span class="status text-success">&bull;</span>Còn hiệu lực</td>
                                        </c:if>

                                        <c:if test="${o.status == 0}">
                                            <td><span class="status text-danger">&bull;</span>Hết hiệu lực</td>
                                        </c:if>
                                        <td> <fmt:formatNumber type = "number" maxIntegerDigits = "10" value = "${o.totalPrice*1000}"/> VNĐ</td>
                                        <td><a href="${pageContext.request.contextPath}/orderdetail?cartId=${o.cartId}" class="view" title="Chi tiết" data-toggle="tooltip"><i class="material-icons">&#xE5C8;</i></a></td>

                                    </tr>


                                </c:forEach>
                            </tbody>
                        </table>
                        <c:if test="${searchdate==null && status == null}">
                            <div class="clearfix">
                                <div class="hint-text">Hiển thị <b>${order.size()}</b> trong tổng số <b>${total1}</b> </div>
                                <ul class="pagination">
                                    <c:if test="${pageIndex1>1}">
                                        <li class="page-item disabled"><a href="myorder?pageIndex=${pageIndex1-1}">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="myorder?pageIndex=${pageIndex1-1}">${pageIndex1-1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex1!=null}">
                                        <li class="page-item active"><a class="page-link" href="myorder?pageIndex=${pageIndex1}">${pageIndex1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex1<endPage1}">
                                        <li class="page-item"><a class="page-link" href="myorder?pageIndex=${pageIndex1+1}">${pageIndex1+1}</a></li>
                                        <li class="page-item"><a href="myorder?pageIndex=${pageIndex1+1}" class="page-link">Next</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${searchdate!=null}">
                            <div class="clearfix">
                                <div class="hint-text">Hiển thị <b>${order.size()}</b> trong tổng số <b>${total1}</b> </div>
                                <ul class="pagination">
                                    <c:if test="${pageIndex1>1}">
                                        <li class="page-item disabled"><a href="searchorder?pageIndex=${pageIndex1-1}&searchdate=${searchdate}">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="searchorder?pageIndex=${pageIndex1-1}&searchdate=${searchdate}">${pageIndex1-1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex1!=null}">
                                        <li class="page-item active"><a class="page-link" href="searchorder?pageIndex=${pageIndex1}&searchdate=${searchdate}">${pageIndex1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex1<endPage1}">
                                        <li class="page-item"><a class="page-link" href="searchorder?pageIndex=${pageIndex1+1}&searchdate=${searchdate}">${pageIndex1+1}</a></li>
                                        <li class="page-item"><a href="searchorder?pageIndex=${pageIndex1+1}&searchdate=${searchdate}" class="page-link">Next</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </c:if>
                        <c:if test="${status!=null}">
                            <div class="clearfix">
                                <div class="hint-text">Hiển thị <b>${order.size()}</b> trong tổng số <b>${total1}</b></div>
                                <ul class="pagination">
                                    <c:if test="${pageIndex1>1}">
                                        <li class="page-item disabled"><a href="orderfilter?pageIndex=${pageIndex1-1}&status=${status}">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="orderfilter?pageIndex=${pageIndex1-1}&status=${status}">${pageIndex1-1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex1!=null}">
                                        <li class="page-item active"><a class="page-link" href="orderfilter?pageIndex=${pageIndex1}&status=${status}">${pageIndex1}</a></li>
                                        </c:if>
                                        <c:if test="${pageIndex1<endPage1}">
                                        <li class="page-item"><a class="page-link" href="orderfilter?pageIndex=${pageIndex1+1}&status=${status}">${pageIndex1+1}</a></li>
                                        <li class="page-item"><a href="orderfilter?pageIndex=${pageIndex1+1}&status=${status}" class="page-link">Next</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </c:if>

                    </div>
                </div>        
            </div> 
        </c:if>       
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
    </body>
</html>
