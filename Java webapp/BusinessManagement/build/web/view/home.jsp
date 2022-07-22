<%-- 
    Document   : home
    Created on : 06-03-2022, 14:22:44
    Author     : Quan
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Business Modern</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="img/d.png" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/home/styles.css" rel="stylesheet" />

        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <style>
            body {
                font-family: 'Varela Round', sans-serif;
            }
            .modal-login {		
                color: #636363;
                width: 350px;
            }
            .modal-login .modal-content {
                padding: 20px;
                border-radius: 5px;
                border: none;
            }
            .modal-login .modal-header {
                border-bottom: none;   
                position: relative;
                justify-content: center;
            }
            .modal-login h4 {
                text-align: center;
                font-size: 26px;
                margin: 30px 0 -15px;
            }
            .modal-login .form-control:focus {
                border-color: #70c5c0;
            }
            .modal-login .form-control, .modal-login .btn {
                min-height: 40px;
                border-radius: 3px; 
            }
            .modal-login .close {
                position: absolute;
                top: -5px;
                right: -5px;
            }	
            .modal-login .modal-footer {
                background: #ecf0f1;
                border-color: #dee4e7;
                text-align: center;
                justify-content: center;
                margin: 0 -20px -20px;
                border-radius: 5px;
                font-size: 13px;
            }
            .modal-login .modal-footer a {
                color: #999;
            }		
            .modal-login .avatar {
                position: absolute;
                margin: 0 auto;
                left: 0;
                right: 0;
                top: -70px;
                width: 95px;
                height: 95px;
                border-radius: 50%;
                z-index: 9;
                background: #60c7c1;
                padding: 15px;
                box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
            }
            .modal-login .avatar img {
                width: 100%;
            }
            .modal-login.modal-dialog {
                margin-top: 80px;
            }
            .modal-login .btn, .modal-login .btn:active {
                color: #fff;
                border-radius: 4px;
                background: #60c7c1 !important;
                text-decoration: none;
                transition: all 0.4s;
                line-height: normal;
                border: none;
            }
            .modal-login .btn:hover, .modal-login .btn:focus {
                background: #45aba6 !important;
                outline: none;
            }
            .trigger-btn {
                display: inline-block;
                margin: 100px auto;
            }
        </style>
    </head>
    <body class="d-flex flex-column h-100">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                <div class="container px-5">
                    <a class="navbar-brand" href="home">Business Modern</a>
                    
                </div>
            </nav>
            <!-- Header-->
            <header class="bg-dark py-5">
                <div class="container px-5">
                    <div class="row gx-5 align-items-center justify-content-center">
                        <div class="col-lg-8 col-xl-7 col-xxl-6">
                            <div class="my-5 text-center text-xl-start">
                                <h1 class="display-5 fw-bolder text-white mb-2">Digital solutions in the 4.0 technology era</h1>
                                <p class="lead fw-normal text-white-50 mb-4">Business Modern, mô hình kinh doanh thời đại mới!</p>
                                <div class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
                                    <a class="btn btn-primary btn-lg px-4 me-sm-3" 
                                       href="#myModal" 
                                       data-toggle="modal">Bắt đầu ngay</a>
                                    <a class="btn btn-outline-light btn-lg px-4" href="#features">Tìm hiểu thêm</a>
                                </div>
   
                            </div>
                        </div>
                        <div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center"><img class="img-fluid rounded-3 my-5" src="img/band.jpg" alt="..." /></div>
                    </div>
                </div>
            </header>
            <!-- Features section-->
<!--            <section class="py-5" id="features">
                <div class="container px-5 my-5">
                    <div class="row gx-5">
                        <div class="col-lg-4 mb-5 mb-lg-0"><h2 class="fw-bolder mb-0">Mô hình kinh doanh hiện đại.</h2></div>
                        <div class="col-lg-8">
                            <div class="row gx-5 row-cols-1 row-cols-md-2">
                                <div class="col mb-5 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-collection"></i></div>
                                    <h2 class="h5">Tối ưu</h2>
                                    <p class="mb-0">Tối ưu các thủ tục truyền thống, hiện đại hóa các quy trình.</p>
                                </div>
                                <div class="col mb-5 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-building"></i></div>
                                    <h2 class="h5">Lưu trữ</h2>
                                    <p class="mb-0">Ghi nhớ các quá trình bán hàng, nhập hàng và thu chi của cửa hàng.</p>
                                </div>
                                <div class="col mb-5 mb-md-0 h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                    <h2 class="h5">Tránh rủi ro</h2>
                                    <p class="mb-0">Kiểm soát các quy trình một cách khoa học, tránh được các thất thu về hàng và tiền.</p>
                                </div>
                                <div class="col h-100">
                                    <div class="feature bg-primary bg-gradient text-white rounded-3 mb-3"><i class="bi bi-toggles2"></i></div>
                                    <h2 class="h5">Bảo mật</h2>
                                    <p class="mb-0">Bảo mật kỹ càng các quá trình và thông tin của bạn, tránh khỏi việc người ngoài biết.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>-->

            <!-- Blog preview section-->
<!--            <section class="py-5">
                <div class="container px-5 my-5">


                     Call to action
                    <aside class="bg-primary bg-gradient rounded-3 p-4 p-sm-5 mt-5">
                        <div class="d-flex align-items-center justify-content-between flex-column flex-xl-row text-center text-xl-start">
                            <div class="mb-4 mb-xl-0">
                                <div class="fs-3 fw-bold text-white">Hãy để lại mail.</div>
                                <div class="text-white-50">Chúng tôi sẽ gửi thông tin vào mail cho bạn.</div>
                            </div>
                            <div class="ms-xl-4">
                                <div class="input-group mb-2">
                                    <input class="form-control" type="text" placeholder="Email address..." aria-label="Email address..." aria-describedby="button-newsletter" />
                                    <button class="btn btn-outline-light" id="button-newsletter" type="button">Nhận thông tin</button>
                                </div>
                                <div class="small text-white-50">Chúng tôi sẽ bảo mật mail của bạn, không chia sẻ cho ai khác.</div>
                            </div>
                        </div>
                    </aside>
                </div>
            </section>-->
        </main>
        <!-- Footer-->
        <footer class="bg-dark py-4 mt-auto">
            <div class="container px-5">
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
<!--                    <div class="col-auto"><div class="small m-0 text-white"></div></div>
                    <div class="col-auto">
                        <a class="link-light small" href="#!">Privacy</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Terms</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Contact</a>
                    </div>-->
                </div>
            </div>
        </footer>
        <!-- table login-->
        <div id="myModal" class="modal fade">
            <div class="modal-dialog modal-login">
                <div class="modal-content">
                    <div class="modal-header">

                        <h4 class="modal-title">Bạn là:</h4>	
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    </div>
                    <div class="modal-body" style="text-align: center">
                        <c:if test="${sessionScope.account==null}">
                        <a class="btn btn-primary btn-lg px-4 me-sm-3" href="login">Chủ kinh doanh</a>
                        </c:if>
                        <c:if test="${sessionScope.account!=null}">
                        <a class="btn btn-primary btn-lg px-4 me-sm-3" href="manage">Chủ kinh doanh</a>
                        </c:if>
                        <c:if test="${sessionScope.accountStaff==null}">
                        <a class="btn btn-primary btn-lg px-4 me-sm-3" style="margin-top: 20px; " href="slogin">Nhân viên</a>
                        </c:if>
                        <c:if test="${sessionScope.accountStaff!=null}">
                        <a class="btn btn-primary btn-lg px-4 me-sm-3" style="margin-top: 20px; " href="manage">Nhân viên</a>
                        </c:if>
                        
                    </div>
                    
                </div>
            </div>
        </div>     
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../js/home/scripts.js"></script>
    </body>


</html>
