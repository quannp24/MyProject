

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="categories list-unstyled">
    <li class="">
        <p>DASHBOARD</p>
    </li>
    <!--account-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/usermanagement"><i class="fa fa-users" aria-hidden="true"></i> Tài khoản người dùng</a>
    </li>
    <!--staff-->

    <!--movie-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/alistmovie"><i class="fas  fa-film "></i> Phim chiếu rạp</a>
    </li>
    <!--schedule-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/setupschedule"><i class="far fa-calendar-alt"></i> Lịch trình</a>
    </li>
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/managementroom"><i class="far fa-calendar-alt"></i> Phòng chiếu</a>
    </li>
    <!--Food And Drink-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/alistfd"><i class="far fa-life-bouy"></i> Đồ ăn & đồ uống</a>
    </li>
    <!--notification-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/adminnotificationlist"><i class='fas fa-bell'></i> Thông báo</a>
    </li>
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/listbanner"><i class="fas fa-ad"></i> Banner</a>
    </li>
</ul>
