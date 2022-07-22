


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <title>BoomCinema-Đồ ăn uống</title>
</head>

<body>
    <%@include file="template/header.jsp" %>
    <div class="content-wrapper"  style="margin-bottom: 50px; width: 90%;text-decoration: none;font-family: 'Merriweather Sans', sans-serif;">
        <div class="container-fluid">

            <div class="row">
                <div class="col-lg-12 " >
                    <a class="neon-button form-create" href="ainsertfd">Thêm sản phẩm</a>

                </div>


                <div class="col-lg-12">
                    <div class="card"  style="border-radius: 12px;background-color: #242424;" >
                        <div class="card-body" ">
                            <h3 class="card-title" style="margin: 30px;color: hsl(351, 69%, 50%)" >Danh sách thức ăn & nước uống</h3>
                            <div class="table-responsive"  style="margin-left: 0px; margin-right: 5%">
                                <form action="asearchmovie" style="width:40%;min-width: 200px; margin: 10px auto 25px auto " class="input-group rounded ">
                                    <input  name="movietxt" type="search" class="form-control rounded" placeholder="Tìm kiếm tên sản phẩm" aria-label="Search" aria-describedby="search-addon" />
                                    <button type="submit"  style="height:45px;" class="input-group-text border-0" id="search-addon">
                                        <i class="fas fa-search"></i></a>
                                    </button>
                                </form>
                                <h4 style="color:red; text-align: center">${error}</h4>
                                <table class="table ">
                                    <thead>
                                        <tr style="text-align: center;color: white;" >
                                            <th scope="col" style="width: 2%; text-align: center">#</th>
                                            <th scope="col" style="width: 10%">Thể loại</th>
                                            <th scope="col" style="width: 20%">Tên sản phẩm</th>
                                            <th scope="col" style="width: 10%">Giá</th>
                                            <th scope="col" style="width: 20%">Ảnh</th>
                                        </tr>
                                    </thead>
                                    <%Integer count = (Integer) request.getAttribute("pageIndex");%>
                                    <%count = (count - 1) * 5 + 1;%>
                                    <tbody>
                                        <c:forEach items="${foodList}" var="fad">
                                            <tr style="color: white;">
                                                <td scope="row" style="text-align: center">${fad.fadId}</td>
                                                <td style="text-align: center">${fad.category}</td>
                                                <td style="text-align: center">${fad.fadName}</td>
                                                <td style="text-align: center"><fmt:formatNumber type = "number" maxIntegerDigits = "10" value = "${fad.price*1000}"/> VNĐ</td>
                                                <td style="text-align: center"><img style=" height: 10%; width: 300px; text-align: center" 
                                                                                    src="${pageContext.request.contextPath}/${fad.image}"></td>
                                                <td style="text-align: center">
                                                    <a class="btn btn-success" href="aupdatefd?id=${fad.fadId}"><p  style="color: #ffffff; margin: 1px">Sửa</p></a>

                                                    <a  href="#" onclick="showMess(${fad.fadId})" class="btn btn-danger"><p  style="color: #ffffff; margin: 1px">Xóa</p>

                                                    </a>
                                                </td>

                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <!--Pagging-->
                        <nav style="margin-top: 30px" aria-label="Page navigation example" class="d-flex justify-content-center">
                            <ul class="pagination">
                                <c:if test="${pageIndex>1}">
                                    <li class="page-item "><a href="alistfd?pageIndex=${pageIndex-1}">Previous</a></li>
                                    <li class="page-item"><a class="page-link" href="alistfd?pageIndex=${pageIndex-1}">${pageIndex-1}</a></li>
                                    </c:if>
                                    <c:if test="${pageIndex!=null}">
                                    <li class="page-item active"><a class="page-link" href="alistfd?pageIndex=${pageIndex}">${pageIndex}</a></li>
                                    </c:if>
                                    <c:if test="${pageIndex<endPage}">
                                    <li class="page-item"><a class="page-link" href="alistfd?pageIndex=${pageIndex+1}">${pageIndex+1}</a></li>
                                    <li class="page-item"><a href="alistfd?pageIndex=${pageIndex+1}" class="page-link">Next</a></li>
                                    </c:if>
                                <!--Pagging-->
                            </ul>
                        </nav>
                    </div>

                </div>
            </div>
        </div>
        <div></div>

        <style>
            body a{
                text-decoration: none;
            }

            .form-create{
                margin: 50px 30px 10px 30px;
                border: 1px solid #000;
                width: 10%;
                text-align: center;
                padding: 5px 0;
                background-color: #000;
                color:#fff;
            }

            .form-create a{
                color: #fff;
            }


            .content-wrapper {
                margin-left: 5%;
                padding-left: 10px;
                padding-right: 10px;
                margin-right: 5%;
            }

            .card-body-icon {
                position: absolute;
                z-index: 0;
                top: -25px;
                right: -25px;
                font-size: 5rem;
                -webkit-transform: rotate(15deg);
                -ms-transform: rotate(15deg);
                transform: rotate(15deg);
            }

            .table-striped tbody tr:nth-of-type(odd) {
                background-color: rgba(0, 0, 0, 0.05);
            }
        </style>
    </div>
    <%@include file="template/footer.jsp" %>
</body>

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

<script>
    function showMess(id) {
        var option = confirm('Bạn có chắc muốn xóa không?');
        if (option === true) {
            window.location.href = 'adeletefd?id=' + id;
        }
    }
</script>


