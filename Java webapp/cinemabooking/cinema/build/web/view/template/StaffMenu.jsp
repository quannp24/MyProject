<%-- 
    Document   : mktMenu
    Created on : Mar 10, 2022, 10:56:30 PM
    Author     : tenhik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<ul class="categories list-unstyled">
    <li class="">
        <p>DASHBOARD</p>
    </li>
    <!--account-->
<!--    <li class="">
        <a href="${pageContext.request.contextPath}/adminaccountlist"><i class="fa fa-users" aria-hidden="true"></i> Account</a>
    </li>
    staff
    <li class="has-dropdown">
        <a href="#" onclick="dropdown()" ><i class="fas fa-cogs"></i> Staff</a>
        <ul id="sidebar-dropdown" class="list-unstyled">
            staff
            <li><a href="#"><i class="fas fa-address-card"></i> Staff </a></li>
            cv
            <li><a href="${pageContext.request.contextPath}/adminrecruitmentlist" ><i class="fas fa-address-card"></i> Recruitment</a></li>
            <li><a href="${pageContext.request.contextPath}/admincvlist" ><i class="fas fa-address-card"></i> CV List</a></li>
        </ul>
    </li>-->
<!--    Banner
    <li class="">
        <a href="${pageContext.request.contextPath}/adminbannerlist"><i class="fas fa-film"></i> Banner</a>
    </li>
    Promotione
    <li class="">
        <a href="${pageContext.request.contextPath}/adminpromotionlist"><i class="far fa-calendar-alt"></i> Promotion</a>
    </li>-->
<!--    <li class="">
        <a href="${pageContext.request.contextPath}/adminListMovieRoom"><i class="far fa-calendar-alt"></i> Movie room</a>
    </li>-->
    <!--promtion-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/adminpromotionlist"><i class='fas fa-bullhorn'></i> Feedback</a>
    </li>
    <!--banner-->
    <li class="">
        <a class="neon-button" href="${pageContext.request.contextPath}/listbanner"><i class="fas fa-ad"></i> Banner</a>
    </li>
<!--    notification
    <li class="">
        <a href="${pageContext.request.contextPath}/adminnotificationlist"><i class='fas fa-bell'></i> Notification</a>
    </li>-->
</ul>
