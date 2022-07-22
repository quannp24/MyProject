
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<nav class="navbar navbar-expand-md">
    <div class="container-fluid mx-2">
        <!--Brand-->
        <div class="navbar-header">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#toggle-navbar" aria-controls="toggle-navbar" aria-expanded="false" aria-label="Toggle navigation">
                <i class="uil-bars text-white"></i>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/usermanagement">Quản lý<span class="main-color"> rạp phim <i class="fas fa-cogs"></i></span></a>
        </div>       
        <!--Account info-->
        <div class="collapse navbar-collapse" id="toggle-navbar">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false" >
                        <i class="fas fa-user-circle" style="color: #FFF"></i>
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <c:if test ="${sessionScope.account !=  null}">
                            <!-- Default -->
                            <li><span class="dropdown-item-text">Xin chào ${account.fullname}</span></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/userprofile?id=${account.accId}">Xem thông tin</a></li>  
                            <!-- Change password -->
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/changepass?id=${account.accId}">Đổi mật khẩu</a></li>
                            <!-- Default Logout -->
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>

                        </c:if>

                        <!-- Neu khong co user -->
                        <c:if test ="${sessionScope.account ==  null}">
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/signup">Đăng ký</a></li>

                        </c:if>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>