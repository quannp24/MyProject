<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <title>Nhân viên - BM</title>

        <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
        <meta name="viewport" content="width=device-width" />

        <link rel="apple-touch-icon" sizes="75x75" href="img/d.png" />
        <link rel="icon" type="image/png" href="img/d.png" />

        <!--     Fonts and icons     -->
        <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />

        <!-- CSS Files -->
        <!--<link href="assets/css/bootstrap.min.css" rel="stylesheet" />-->
        <link href="css/login/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <!--<link href="assets/css/material-bootstrap-wizard.css" rel="stylesheet" />-->
        <link href="css/login/material-bootstrap-wizard.css" rel="stylesheet" type="text/css"/>
        <!-- CSS Just for demo purpose, don't include it in your project -->
        <link href="css/login/demo.css" rel="stylesheet" type="text/css"/>
        <%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
    </head>

    <body>
        <div class="image-container set-full-height" style="background-image: url('img/background_1.jpg')">
            <!--   Creative Tim Branding   -->
            <a href="home">
                <div class="logo-container">
                    <div class="logo">
                        <img src="img/dwhite.png">
                    </div>
                    <div class="brand">
                        Business Modern
                    </div>
                </div>
            </a>

            <!--   Big container   -->
            <div class="container">
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2">
                        <!--      Wizard container        -->
                        <div class="wizard-container">
                            <div class="card wizard-card" data-color="red" id="wizard">
                                <form id="myform" action="slogin" method="POST" >
                                    <!--        You can switch " data-color="blue" "  with one of the next bright colors: "green", "orange", "red", "purple"             -->

                                    <div class="wizard-header">
                                        <h3 class="wizard-title">
                                            Vào cửa hàng nào!
                                        </h3>
                                        <h5>Hãy đăng nhập vào nơi bạn làm việc, hãy nhờ chủ của bạn nếu chưa có tài khoản.</h5>
                                    </div>
                                    <div class="wizard-navigation">
                                        <ul>

                                            <li><a href="#captain"  data-toggle="tab">Đăng nhập</a></li>

                                        </ul>
                                    </div>

                                    <div class="tab-content">


                                        <div class="tab-pane" id="captain">
                                            <div class="row">
                                                <div class="col-sm-12">
                                                    <h4 class="info-text"> Hãy điền thông tin đăng nhập của bạn.</h4>
                                                </div>
                                                <div class="col-sm-3" ></div>
                                                <div class="col-sm-6" >
                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="material-icons">storefront</i>
                                                        </span>
                                                        <div class="form-group label-floating" >
                                                            <label class="control-label">Code</label>
                                                            <input name="bid" type="text" class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="material-icons">person</i>
                                                        </span>
                                                        <div class="form-group label-floating" >
                                                            <label class="control-label">Username</label>
                                                            <input name="username" type="text" class="form-control">
                                                        </div>
                                                    </div>

                                                    <div class="input-group">
                                                        <span class="input-group-addon">
                                                            <i class="material-icons">lock_outline</i>
                                                        </span>
                                                        <div class="form-group label-floating" >
                                                            <label class="control-label">Your Password</label>
                                                            <input name="pass" type="password" class="form-control">
                                                            <span id = "message" style="color:red">${requestScope.mess} </span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3" ></div>

                                            </div>

                                        </div>

                                    </div>

                                    <div class="wizard-footer" style="text-align: center">
                                        <div class="footer-checkbox">
                                            <div class="col-sm-12">
                                                <div class="checkbox">
                                                    <label>
                                                        <input type="checkbox" name="remember">
                                                    </label>
                                                    Nhớ phiên đăng nhập.
                                                </div>
                                            </div>
                                        </div>
                                        <input type='submit'  class='btn btn-finish btn-fill btn-danger btn-wd' name='login' value='Đăng nhập' />

                                        <div class="clearfix"></div>
                                    </div>
                                </form>
                            </div>
                        </div> <!-- wizard container -->
                    </div>
                </div> <!-- row -->
            </div> <!--  big container -->


        </div>

    </body>
    <!--   Core JS Files   -->
    <!--<script src="assets/js/jquery-2.2.4.min.js" type="text/javascript"></script>-->
    <script src="js/login/jquery-2.2.4.min.js" type="text/javascript"></script>
    <script src="js/login/bootstrap.min.js" type="text/javascript"></script>
    <!--<script src="assets/js/bootstrap.min.js" type="text/javascript"></script>-->
    <script src="js/login/jquery.bootstrap.js" type="text/javascript"></script>

    <!--  Plugin for the Wizard -->
    <script src="js/login/material-bootstrap-wizard.js"></script>

    <!--  More information about jquery.validate here: http://jqueryvalidation.org/	 -->
    <script src="js/login/jquery.validate.min.js"></script>


</html>
