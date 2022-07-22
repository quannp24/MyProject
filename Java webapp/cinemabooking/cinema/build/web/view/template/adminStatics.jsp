

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<section class="statis mt-4 text-center">
    <div class="row">
        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
            <div class="box bg-primary p-3">
                <i class="fas fa-film"></i>
                <h3>${getMovies.totalMovie}</h3>
                <p class="lead">Tổng số phim</p>
            </div>
        </div>
        <div class="col-md-6 col-lg-3 mb-4 mb-lg-0">
            <div class="box bg-danger p-3">
                <i class="fas fa-users"></i>
                <h3>${getAccount.getTotalAccountByRole(3)}</h3>
                <p class="lead">Người dùng </p>
            </div>
        </div>
        <div class="col-md-6 col-lg-3 mb-4 mb-md-0">
            <div class="box bg-warning p-3">
                <i class="fas fa-cogs"></i>
                <h3>${getAccount.getTotalAccountByRole(2)}</h3>
                <p class="lead">Nhân viên</p>
            </div>
        </div>
        <div class="col-md-6 col-lg-3">
            <div class="box bg-success p-3">
                <i class="fas fa-receipt"></i>
                <h3></h3>
                <p class="lead">Giao dịch</p>
            </div>
        </div>
    </div>
</section>
