

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <title>BoomCinema-Thêm banner</title>
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


                <div class="modal-add modal-dialog-scrollable" style="height: 38rem;position: relative;">
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
                                    <input value="" type="file" id="uploadfile" name="new_Img" onchange="readURL(this);" required/>
                                </div>
                                <div id="thumbbox">
                                    <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbimage" style="display: none" />
                                    <a class="removeimg" href="javascript:"></a>
                                </div>
                                <div id="boxchoice">
                                    <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i>Tải ảnh lên</a>
                                    <p style="clear:both"></p>
                                </div>

                            </div>

                            <div class="form-group">
                                <label for="input-2" class="col-form-label">Nội dung</label>
                                <div>
                                    <textarea class="form-control" rows="3" id="input-17" name="new_desc" required>${banner.desc}</textarea>
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="input-2" class="col-form-label col-md-6">Ngày bắt đầu</label>
                                <label for="input-2" class="col-form-label col-md-6">Ngày kết thúc</label>
                                <div class="col-md-6">
                                    <input type="date" name="start" value="" required>
                                </div>
                                
                                <div class="col-md-6">
                                    <input type="date" name="finish" value="" required>
                                </div>
                            </div>
                            <p style="color: red;font-size: 14px">${error}</p>
                            <p style="color: red;font-size: 14px">${mess}</p>



                        </div>
                        <div class="modal-btn">
                            <a><button onclick="checkAdd()"  type="submit" class="custom-btn btn-crud"><span>Thêm ngay !</span><span>Thêm</span></button></a>
                            <a href="listbanner"><button type="button"  class="custom-btn btn-crud"><span>Đóng ngay !</span><span>Đóng</span></button></a>
                        </div> 
                    </form>
                </div>




                <!--paging-->


            </div>
            <!--footer-->
           
        </section>





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
        var option = confirm('Are you sure to delete?');
        if (option === true) {
            window.location.href = 'delete_banner?id=' + id;
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