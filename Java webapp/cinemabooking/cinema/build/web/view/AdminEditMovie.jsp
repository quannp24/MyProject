<%-- 
    Document   : AdminEditMovie
    Created on : 02-06-2022, 20:18:10
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- Sakura -->
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
    <title>BoomCinema-Cập nhật phim</title>
</head>



<body>
    <%@include file="template/header.jsp" %>
    <div class="content-wrapper"  style="margin-bottom: 50px; width: 90%;text-decoration: none">
        <div class="container-fluid">

            <div class="row mt-3">
                <div class="col-lg-5" style="margin-left: auto;margin-right: auto">
                    <div class="card" style="background: #242424;color: white;">

                        <div class="card-body" >
                            <h2><a style="color: hsl(351, 69%, 50%);" href="alistmovie">Danh sách phim</a></h2>
                            <div class="card-title" style="margin: 10px;">Thêm phim chiếu</div>

                            <form action="aeditmovie" method="post" enctype="multipart/form-data">
                                <h3 style="color: red ">${error}</h3>
                                <h3 style="color: #18a665 ">${mess}</h3>
                                <div class="form-group">
                                    <label>Mã phim</label>
                                    <input value="${movie.movieId}" type="number" required class="form-control" readonly name="movieID">
                                </div>

                                <div class="form-group">
                                    <label>Tên phim</label>
                                    <input value="${movie.movieName}" type="text" class="form-control" required name="movieName">
                                </div>

                                <div>
                                    <p class="text-muted">Ảnh</p>
                                    <img class="rounded" height="20%" width="30%" id="image" src="${pageContext.request.contextPath}/${movie.image}" />
                                    <div id="myfileupload">
                                        <input value="" type="file" name="movieImage" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
                                    </div>
                                    <div id="thumbbox">
                                        <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbimage" style="display: none" />
                                        <a class="removeimg" href="javascript:"></a>
                                    </div>
                                    <div id="boxchoice">
                                        <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                                        <p style="clear:both"></p>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="input-1">Thể loại phim</label>
                                    <input value="${movie.category}" type="text" required class="form-control" id="input-1"  name="movieCategory">
                                </div>

                                <div class="form-group">
                                    <label for="input-2" class="col-form-label">Miêu tả nội dung phim</label>
                                    <div>
                                        <textarea  class="form-control" rows="2" required id="input-17" name="movieDescription">${movie.description}</textarea>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="input-1">Ngôn ngữ</label>
                                    <input value="${movie.language}" type="text" class="form-control" required id="input-1"  name="movieLanguage">
                                </div>

                                <div class="form-group">
                                    <label for="input-1">Rated</label>
                                    <input value="${movie.rate}" type="text" class="form-control" required id="input-1"  name="movieRated">
                                </div>

                                <div class="form-group">
                                    <label for="input-1">Thời lượng</label>
                                    <input value="${movie.duration}" type="text" required class="form-control" id="input-1"  name="movieDuration">
                                </div>

                                <div class="form-group row">
                                    <label for="input-1" class="col-md-6">Ngày khởi chiếu</label> 
                                    <label for="input-1" class="col-md-6">Ngày dừng chiếu</label> 
                                    <div class="col-md-6">
                                        <input value="${movie.startdate}" type="date" class="form-control" id="the-date" placeholder="Ngày công chiếu" name="startdate" required="">
                                    </div>
                                    <div class="col-md-6">
                                        <input value="${movie.enddate}" type="date" class="form-control" id="the-date" placeholder="Ngày công chiếu" name="enddate" >
                                    </div>
                                </div>
                                <div class="form-footer" style="margin-top: 10px">
                                    <button type="submit" class="btn btn-success"><i class="fa fa-check-square-o"></i>Cập nhật</button>
                                    <button class="btn btn-danger"><i class="fa fa-times"></i><a style="color: white;" href="${pageContext.request.contextPath}/alistmovie">Hủy</a></button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="overlay toggle-menu"></div>
        </div>
        <div></div>

    </div>
    <%@include file="template/footer.jsp" %>
</body>
<style>
    body a{
        text-decoration: none;
    }

    .form-create{
        margin: 50px 30px 10px 30px;
        border: 1px solid #000;
        width: 6%;
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
</style>
</div>
<!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>-->
<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery-sakura.js"></script>
<script>
             $(window).load(function () {
                 $('body').sakura();
             });
</script>
<script>
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
        $("#image").hide();
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
            $("#image").show();
            $(".Choicefile").show();
            $(".filename").text("");
        });
    })
</script>

