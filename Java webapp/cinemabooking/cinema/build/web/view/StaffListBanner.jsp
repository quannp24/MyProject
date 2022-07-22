

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
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
        <title>BoomCinema-Banner</title>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/new2.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css" />
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/button-neon_1.css" />
    </head>

    <body>

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

                        </a>
                    </h5>
                </div>
            </div>

            <!-- search input-->
            <div class="search position-relative text-center py-3 mt-2">
                <form action="adminsearchbanner" method="post" class="input-group rounded">
                    <input oninput="checkSearch()" name="searchtxt" value="${searchtxt}" 
                           type="search" class="form-control" placeholder="Tìm kiếm theo tiêu đề" aria-label="Search" aria-describedby="search-addon"/>
                    <button type="submit"  style="height:38px;background-color: #252636;" class="input-group-text border-0" id="search-addon">
                        <i class="fas fa-search" style="color: #FFF"></i></a>
                    </button>
                </form>
                <p style="color:red; text-align: center">${searchMess}</p>  
            </div>

            <!-- main sidebar -->
            <c:if test="${account.role=='1'}">
                <%@include file="template/adminMenu.jsp" %>
            </c:if>
            <c:if test="${account.role=='2'}">
                <%@include file="template/StaffMenu.jsp" %>
            </c:if>
        </aside>

        <!--main content-->
        <section id="wrapper">
            <%@include file="template/adminNewHeader.jsp" %>
            <div class="p-4">
                <div class="welcome">
                    <div class="content rounded-3 p-3">
                        <h1 class="fs-3"><i class="fa fa-users" aria-hidden="true"></i> Quản lý banner</h1>
                    </div>
                </div>
                <div style="display: flex; justify-content: end; margin: 10px">
                    <a href="addbanner"  class="custom-btn btn-crud"><span>Thêm !</span><span>Thêm banner</span></a>
                </div>

                <div class="admin-table table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th style="width: 15%; text-align: center" >Tiêu đề</th>
                                <th style="width: 30%; text-align: center" >Ảnh</th>
                                <th style="width: 15%; text-align: center" >Nội dung</th>
                                <th style="width: 15%; text-align: center" >Ngày bắt đầu</th>
                                <th style="width: 15%; text-align: center" >Ngày kết thúc</th>
                                <th style="width: 15%; text-align: center" ></th>
                                <th style="width: 15%; text-align: center" ></th>

                            </tr>
                        </thead>
                        <% Integer count = (Integer) request.getAttribute("pageIndex");%>
                        <% count = (count - 1) * 5 + 1;%>
                        <tbody>
                            <c:forEach items="${bannerList}" var="banner">
                                <tr>
                                    <td scope="row"><%=count%></td>
                                    <td style="text-align: center; font-size: 15px">${banner.title}</td>

                                    <td style="text-align: center ; font-size: 15px">

                                        <style>
                                            .row img {
                                                border: 1px solid #ddd;
                                                border-radius: 4px;
                                                padding: 5px;
                                                width: 150px;
                                            }

                                            img:hover {
                                                box-shadow: 0 0 2px 1px rgba(0, 140, 186, 0.5);
                                            }
                                        </style>
                                        <a target="_blank" href="${pageContext.request.contextPath}/${banner.getImg()}">
                                            <img src="${pageContext.request.contextPath}/${banner.getImg()}" alt="Forest" style="width:80%">
                                        </a>

                                    </td>

                                    <td style="text-align: center; font-size: 15px">${banner.desc}</td>

                                    <td style="text-align: center; font-size: 15px">${banner.start}</td>
                                    <td style="text-align: center; font-size: 15px">${banner.finish}</td>
                                    <td style="text-align: center; font-size: 15px">                    
                                        <a href="editbanner?id=${banner.id}"  class="custom-btn btn-crud"><span>Sửa ngay!</span><span>Sửa</span></button></a>
                                    </td>
                                    <td style="text-align: center">                                    
                                        <button onclick="showMess(${banner.getId()})"  class="custom-btn btn-crud"><span>Xóa ngay !</span><span>Xóa</span></button>
                                    </td>
                                </tr>
                                <% count = count + 1;%> 

                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!--paging-->
                <c:if test="${searchtxt==null}">
                    <div class="clearfix">
                        <div class="hint-text">Showing <b>${bannerList.size()}</b> out of <b>${total}</b> entries</div>
                        <ul class="pagination">
                            <c:if test="${pageIndex>1}">
                                <li class="page-item disabled"><a href="listbanner?pageIndex=${pageIndex-1}">Previous</a></li>
                                <li class="page-item"><a class="page-link" href="listbanner?pageIndex=${pageIndex-1}">${pageIndex-1}</a></li>
                                </c:if>
                                <c:if test="${pageIndex!=null}">
                                <li class="page-item active"><a class="page-link" href="listbanner?pageIndex=${pageIndex}">${pageIndex}</a></li>
                                </c:if>
                                <c:if test="${pageIndex<endPage}">
                                <li class="page-item"><a class="page-link" href="listbanner?pageIndex=${pageIndex+1}">${pageIndex+1}</a></li>
                                <li class="page-item"><a href="listbanner?pageIndex=${pageIndex+1}" class="page-link">Next</a></li>
                                </c:if>
                        </ul>
                    </div>
                </c:if>
                <c:if test="${searchtxt!=null}">
                    <div class="clearfix">
                        <div class="hint-text">Showing <b>${bannerList.size()}</b> out of <b>${total}</b> entries</div>
                        <ul class="pagination">
                            <c:if test="${pageIndex>1}">
                                <li class="page-item disabled"><a href="adminsearchbanner?pageIndex=${pageIndex-1}$searchtxt=${searchtxt}">Previous</a></li>
                                <li class="page-item"><a class="page-link" href="adminsearchbanner?pageIndex=${pageIndex-1}&searchtxt=${searchtxt}">${pageIndex-1}</a></li>
                                </c:if>
                                <c:if test="${pageIndex!=null}">
                                <li class="page-item active"><a class="page-link" href="adminsearchbanner?pageIndex=${pageIndex}&searchtxt=${searchtxt}">${pageIndex}</a></li>
                                </c:if>
                                <c:if test="${pageIndex<endPage}">
                                <li class="page-item"><a class="page-link" href="adminsearchbanner?pageIndex=${pageIndex+1}&searchtxt=${searchtxt}">${pageIndex+1}</a></li>
                                <li class="page-item"><a href="adminsearchbanner?pageIndex=${pageIndex+1}&searchtxt=${searchtxt}" class="page-link">Next</a></li>
                                </c:if>
                        </ul>
                    </div>
                </c:if>

        </section>

        <!--add modal-->
        <div class="modal-nofi" id="admin-add-modal" <c:if test="${requestScope.errorAdd!=null}">style="display: flex;"</c:if>>
                <div class="modal-nofi-overlay"></div>
                <div class="modal-add modal-dialog-scrollable" style="height: 38rem;">
                    <form class="full-width" action="addbanner" method="post" enctype="multipart/form-data">
                        <h5 class="modal-add-title">Thêm banner</h5>
                        <div class="modal-body row" style="padding-bottom: 0;">
                            <div class="form-group ">
                                <label>Tiêu đề</label>
                                <input value="${banner.title}" type="text" class="form-control" required name="new_title">

                        </div>
                        <div class="form-group">

                            <p class="text-muted">Ảnh</p>

                            <div id="myfileupload">
                                <input value="${pageContext.request.contextPath}/${banner.img}" type="file" id="uploadfile" name="new_Img" onchange="readURL(this);" />
                            </div>
                            <div id="thumbbox">
                                <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbimage" style="display: none" />
                                <a class="removeimg" href="javascript:"></a>
                            </div>
                            <div id="boxchoice">
                                <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i>Browse</a>
                                <p style="clear:both"></p>
                            </div>

                        </div>

                        <div class="form-group">
                            <label for="input-2" class="col-form-label">Nội dung</label>
                            <div>
                                <textarea class="form-control" rows="3" id="input-17" name="new_desc">${banner.desc}</textarea>
                            </div>
                        </div>
                        <p style="color: red;font-size: 14px">${error}</p>
                        <p style="color: red;font-size: 14px">${mess}</p>



                    </div>
                    <div class="modal-btn">
                        <button onclick="checkAdd()"  type="submit" class="custom-btn btn-crud"><span>Thêm ngay !</span><span>Thêm</span></button>
                        <button type="button" onclick="closeModal()" class="custom-btn btn-crud"><span>Đóng ngay !</span><span>Đóng</span></button>
                    </div> 
                </form>
            </div>
        </div>




        <style>
            .Choicefile{
                display: block;
                background: #396CF0;
                border: 1px solid #fff;
                color: #fff;
                width: 150px;
                text-align: center;
                text-decoration: none;
                cursor: pointer;
                padding: 5px 0px;
                border-radius: 5px;
                font-weight: 500;
                align-items: center;
                justify-content: center;
            }

            .Choicefile:hover {
                text-decoration: none;
                color: white;
            }

            #uploadfile,
            .removeimg {
                display: none;
            }

            #thumbbox {
                position: relative;
                width: 100%;
                margin-bottom: 20px;
            }

            .removeimg {
                height: 25px;
                position: absolute;
                background-repeat: no-repeat;
                top: 5px;
                left: 5px;
                background-size: 25px;
                width: 25px;
                border-radius: 50%;

            }

            .removeimg::before {
                -webkit-box-sizing: border-box;
                box-sizing: border-box;
                content: '';
                border: 1px solid red;
                background: red;
                text-align: center;
                display: block;
                margin-top: 11px;
                transform: rotate(45deg);
            }

            .removeimg::after {
                content: '';
                background: red;
                border: 1px solid red;
                text-align: center;
                display: block;
                transform: rotate(-45deg);
                margin-top: -2px;
            }

            .content-wrapper {
                margin-left: 10%;
                padding-left: 10px;
                padding-right: 10px;
                margin-right: 10%;
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
            window.location.href = 'deletebanner?id=' + id;
        }
    }
    function openAddModal() {
        document.getElementById("admin-add-modal").style.display = "flex";
    }
//    function openEditModal() {
//        document.getElementById("admin-edit-modal").style.display = "flex";
//    }
    function closeModal() {
        var x = document.querySelectorAll(".modal-nofi");
        for (var i = 0; i < x.length; i++) {
            if (x[i].style.display !== "none") {
                x[i].style.display = "none";
            }
        }
    }
    function readURL(input, thumbimage) {
        if (input.files && input.files[0]) { //Sử dụng  cho Firefox - chrome
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#thumbimage").attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        } else { // Sử dụng cho IE
            $("#thumbimage").attr('src', input.value);

        }
        $("#thumbimage").show();
        $('.filename').text($("#uploadfile").val());
        $(".Choicefile").hide();
        $(".removeimg").show();
    }
    $(document).ready(function () {
        $(".Choicefile").bind('click', function () {
            $("#uploadfile").click();

        });
        $(".removeimg").click(function () {
            $("#thumbimage").attr('src', '').hide();
            $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
            $(".removeimg").hide();
            $(".Choicefile").show();
            $(".filename").text("");
        });
    });
</script>