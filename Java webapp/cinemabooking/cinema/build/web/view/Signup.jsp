<%-- 
    Document   : login
    Created on : 19-05-2022, 12:54:46
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="shortcut icon" href="image/logotitle.ico" type="image/x-icon">
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cinema-Đăng ký</title>
        <link rel="stylesheet" href="css/Signup.css">
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
            integrity="sha512-iBBXm8fW90+nuLcSKlbmrPcLa0OT92xO1BIsZ+ywDWZCvqsWgccV3gFoRBv0z+8dLJgyAHIhR35VZc2oM/gI1w=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />

    </head>
    <body>
        
        <div class="cont s--signup">

            <div class="form sign-in">
                <h2>Chào mừng</h2>
                </br>
                <div style="    display: flex;
                     justify-content: center;
                     color: red;">${mess}</div>
                <form action="login" method="post">
                    <label>
                        <span>Email</span>
                        <input name="email" type="email"  required/>
                    </label>
                    <label>
                        <span>Mật khẩu</span>
                        <input name="pass" type="password" required/>
                    </label>
                    </br>
                    <div style="display: flex; justify-content: center">
                        <input style="width: 5%" name="remember" type="checkbox"> 
                        <p>Nhớ mật khẩu</p>
                    </div>

                    <button type="submit" class="submit">Đăng nhập</button>
                    <a style="text-decoration: none;" href="ForgotPassword"><p class="forgot-pass">Quên mật khẩu?</p></a>


                </form>


            </div>
            <div class="sub-cont">
                <div class="img">
                    <div class="img__text m--up">

                        <h3>Không có tài khoản? 
                            Vui lòng đăng ký!</h3>
                    </div>
                    <div class="img__text m--in">

                        <h3>Nếu bạn đã có tài khoản. Ðăng nhập ngay.</h3>
                    </div>
                    <div class="img__btn">
                        <span class="m--up">Đăng ký</span>
                        <span class="m--in">Đăng nhập</span>
                    </div>
                </div>
                <div class="form sign-up">
                    <h2>Tạo tài khoản của bạn</h2>
                    <p style="color: green; margin: auto;
                       text-align: center;">
                        ${signupSuccessfull}</p>
                    <form action="signup" method="post">
                        <label>
                            <span>Họ và tên</span>
                            <input name="name" type="text" required/>
                        </label>
                        <label>
                            <span>Địa chỉ email</span> 
                            <p style="color: red;">
                                ${errorExistEmail}</p>
                            <input  name="emailSignUp" type="email" required/>
                        </label>
                        <label>
                            <span>Mật khẩu</span>
                            <p style="color: red;">
                                ${errorPassLength}</p>
                            <input name="passSignUp" type="password" required/>
                        </label>
                        <label>
                            <span>Giới tính</span>
                            </br>
                            </br>
                            <div style="display: flex">
                                <input id="gender" name="gender" type="radio" value="1" required/>Nam 
                                <input id="gender" name="gender" type="radio" value="0" />Nữ 
                            </div>

                        </label>
                        <label>
                            <span>Ngày sinh bạn là</span>
                            <input name="dob" type="date" required/>
                        </label>
                        <label>
                            <span>Địa chỉ</span>
                            <input name="address" type="text" required/>
                        </label>
                        <label>
                            <span>Số điện thoại</span>
                            <input name="phone" type="text" required/>
                        </label>
                        <button type="submit" class="submit">Đăng ký</button>
                    </form>
                    <script>
                        document.querySelector('.img__btn').addEventListener('click', function () {
                            document.querySelector('.cont').classList.toggle('s--signup');
                        });
                    </script>

                </div>
            </div>
        </div>
    </body>
</html>
