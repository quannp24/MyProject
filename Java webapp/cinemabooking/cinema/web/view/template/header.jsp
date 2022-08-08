

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page trimDirectiveWhitespaces="true" %> 
<!DOCTYPE html>

<div class="row m-0 p-0" style="background: linear-gradient(200deg, rgba(198, 48, 48, 0.85) 0%, rgba(0, 0, 0, 0.81) 100%);">
    <span id="promo" class="d-lg-block d-none" style="color: hsl(107, 75%, 100%); text-shadow: 0 0 0.125em hsl(0 0% 100% / 0.3), 0 0 0.45em currentColor;">
        <marquee behavior="scroll" direction="left">Hãy xem phim bùng nổ cùng BoomCinema!!!</marquee>
    </span>
</div>

<nav class="navbar main-navbar navbar-expand-lg navbar-light bg-light pt-0" id="navbar1">
    <div class="container-fluid" style="background: linear-gradient(200deg, rgba(198, 48, 48, 0.85) 0%, rgba(0, 0, 0, 0.81) 100%);" >
        <!-- LOGO -->
        <a class="navbar-brand col-lg-3 offset-lg-1 logo"   href="${pageContext.request.contextPath}/home">
            <img style="padding-top: 10px;" src="${pageContext.request.contextPath}/image/logo.png">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <!-- SEARCHBAR -->
            <form class="d-flex searchbar" method="get" action="${pageContext.request.contextPath}/searchmovie">
                <input type="hidden" name="page" value="1"/>
                <input style="background-color: #EFEFEF" oninput="checkSearch()" name="moviename" value="${movieNameInput}" class="form-control me-2" type="text" placeholder="Tìm kiếm phim bạn cần..." aria-label="Search">

                <button style="color: white;" class="btn btn-search" type="submit"><span><i  class="fas fa-search" style="font-size: 100%; "></i></span></button>
            </form>
            <ul class="navbar-nav me-auto ms-auto">                

                <!-- EXPANDED -->
                <c:if test="${sessionScope.account !=null}">
                    <li class="nav-item dropdown d-none d-lg-block">
                        
                        
                    </li>

                    <li class="nav-item d-none d-lg-block" style="padding: 0;">
                        <a style="padding: 5px;"  class="nav-link" href="myorder">
                            <img  src="image/ve.png">
                            
                        </a>
                    </li>
                </c:if>
                <li class="nav-item dropdown d-none d-lg-block">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user-circle"></i>
                    </a>
                    <ul style="background: #3C3535;" class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <c:if test ="${sessionScope.account !=  null}">
                            <!-- Default -->
                            <li><span style="color: #D2B129" class="dropdown-item-text">Chào ${sessionScope.account.getFullname()}</span></li>
                            <li><a style="color: #D85B5B" class="dropdown-item" href="${pageContext.request.contextPath}/userprofile?id=${sessionScope.account.accId}">Xem thông tin</a></li>  
                            <!-- Admin -->
                            <c:if test="${sessionScope.account.role == 1}">
                                <li><a style="color: #D85B5B" class="dropdown-item" href="${pageContext.request.contextPath}/usermanagement">Quản lý rạp phim</a></li>
                                <!--<li><a style="color: #D85B5B" class="dropdown-item" href="${pageContext.request.contextPath}/alistmovie">Quản lý phim</a></li>-->
                                </c:if>
                            <!-- Staff -->
                            <c:if test="${sessionScope.account.role ==  2}">
                                <!--<li><a style="color: #D85B5B" class="dropdown-item" href="#">DashBoard</a></li>-->
                                <li><a style="color: #D85B5B" class="dropdown-item" href="listbanner">Quản lý banner</a></li>
                                <!--<li><a style="color: #D85B5B" class="dropdown-item" href="#">Quản lý khuyến mãi</a></li>-->
                                </c:if>
                            <!-- My order-->
                            <!--<li><a style="color: #D85B5B" class="dropdown-item" href="${pageContext.request.contextPath}/myorder">Đơn hàng</a></li>-->
                            <!-- Change password -->

                            <li><a style="color: #D85B5B" class="dropdown-item" href="${pageContext.request.contextPath}/changepass?id=${sessionScope.account.accId}">Đổi mật khẩu</a></li>

                            <!-- Default Logout -->
                            <li><hr class="dropdown-divider"></li>
                            <li><a style="color: #D85B5B" class="dropdown-item" href="logout">Đăng xuất</a></li>

                        </c:if>

                        <!-- Neu khong co user -->
                        <c:if test ="${sessionScope.account ==  null}">
                            <li><a style="color: #D85B5B" class="dropdown-item" href="login">Đăng nhập</a></li>
                            <li><a style="color: #D85B5B" class="dropdown-item" href="signup">Đăng ký</a></li>

                        </c:if>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


<!-- SECONDARY NAVBAR -->
<nav id="navbar2" style="background: #060606;" class="navbar navbar-expand-lg   d-none d-lg-block p-1">
    <div class="container-fluid" >
        <ul class="navbar-nav offset-2 me-auto mb-2 mb-lg-0" style="margin-left: auto; margin-right:auto; ">
            <li  class="nav-item me-4">
                <a  class="neon-button" aria-current="page" href="${pageContext.request.contextPath}/home">Trang chủ</a>
            </li>

            <li class="nav-item me-4">
                <a class="neon-button" aria-current="page" href="">Sự kiện</a>
            </li>
            
         
            <li class="nav-item me-4">
                <a class="neon-button" href="#footer">Feedback</a>
            </li>
            <li class="nav-item dropdown me-4">
                <a class="neon-button dropdown-toggle d-inline-block" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Phim ≡</a>
                <ul style="background: #3C3535;" class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <li>
                        <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/filtermovie?service=nowplaying"><h6 style="color: #D85B5B" class="dropdown-item">Phim đang chiếu</h6></a>
                    </li>
                    <li>
                        <a class="nav-link" aria-current="page" href="${pageContext.request.contextPath}/filtermovie?service=comingsoon"><h6 style="color: #D85B5B" class="dropdown-item">Phim sắp chiếu</h6></a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</nav>
<%-- NAV --%>
<%-- Top Btn --%>
<button onclick="topFunction()" id="myTBTN" title="Go to top"><i class="fas fa-arrow-up"></i></button>
<script>
    function checkSearch() {
        var mess = document.querySelector('input[name=moviename]');
        var messTrim = mess.value.trim();
        var messReplaceSpace = messTrim.replace(/\s\s+/g, ' ');
        console.log(messReplaceSpace);
        if (messReplaceSpace.length == 0) {
            mess.setCustomValidity('Can not be empty!');
        } else {
            mess.setCustomValidity('');
        }
    }
</script>