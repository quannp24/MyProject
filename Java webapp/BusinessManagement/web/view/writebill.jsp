<%-- 
    Document   : import
    Created on : 12-03-2022, 22:30:55
    Author     : Quan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Ghi hóa đơn - BM</title>
    <link rel="icon" type="image/x-icon" href="img/d.png" />
    <!-- Bootstrap icons-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="license" href="https://www.opensource.org/licenses/mit-license/">
    <script src="js/sell/writebill.js" type="text/javascript"></script>
    <link href="css/sell/writebill.css" rel="stylesheet" type="text/css"/>
</head>

<body>
    <header style="margin: 0px 0px 10px 0px">
        <h1>GHI HÓA ĐƠN</h1>

        <span><a href="manage"><img style="margin: 1em 0 0 1.6em" alt="logo" src="img/d.png"></a></span>
    </header >
    <form id="noww" action="writebill" method="POST">
        <article>

            <address>
               
                <a href="bills" class="button-80" >Danh sách hóa đơn</a>
            </address>
            <table class="meta">
                <tr>
                    <th><span>Tên khách hàng</span></th>
                    <td><input type="text" style="width: 100%;" name="name"></td>
                </tr>
                <tr>
                    <th><span>Địa chỉ</span></th>
                    <td><input type="text" style="width: 100%;" name="address"></td>
                </tr>
                <tr>
                    <th><span>Số điện thoại</span></th>
                    <td><input type="text" style="width: 100%;" name="phone"></td>
                </tr>
                <tr>
                    <th><span>Hình thức thanh toán</span></th>
                    <td><input type="text" style="width: 100%;" name="paytype"></td>
                </tr>

            </table>
            <table class="inventory" id="myTable">
                <thead>
                    <tr>
                        <th><span>Tên sản phẩm</span></th>
                        <th><span>Miêu tả</span></th>
                        <th><span>Đơn giá</span></th>
                        <th><span>Số lượng</span></th>
                        <th><span>Giá</span></th>
                    </tr>
                </thead>
                <tbody>

                    <tr>
                        <td><a class="cut" onclick="remove(this)">-</a><input type="text" style="width: 100%;" name="product"></td>
                        <td><input type="text" style="width: 100%;" name="describe"></td>
                        <td><span></span><input onkeyup="myadd()" type="text" style="width: 100%; text-align: center;" name="unitprice"></td>
                        <td><input type="text" onkeyup="myadd()" style="width: 100%;text-align: center;" name="quantity"></td>
                        <td><span></span><input type="text" style="width: 100%;text-align: right;" name="price" readonly value="0"></td>
                    </tr>
                </tbody>
            </table>
            <a class="add" onclick="myFun()">+</a>
            <table class="balance">

                <tr>
                    <th><span>Tổng</span></th>
                    <td><span data-prefix></span><input type="text" style="width: 100%;text-align: right;" name="total" readonly value="0"></td>
                </tr>
                <tr>
                    <th><span>Đã đưa</span></th>
                    <td><span data-prefix></span><input onkeyup="myadd()" style="width: 100%;text-align: right;" name="payment"></td>
                </tr>
                <tr>
                    <th><span>Còn nợ</span></th>
                    <td><span data-prefix></span><input type="text" style="width: 100%;text-align: right;" name="debt" readonly value="0"></td>
                </tr>
            </table>

        </article>
        <aside>
            <span id = "message" style="color:red">${requestScope.mess} </span>
            <h1><span><input class="submit" onclick="checkvalue()" type="button" value="Lưu và in hóa đơn"></span></h1>
            <div>
                <p></p>
            </div>
        </aside>
    </form>
</body>

</html>
