function paymentMomo() {
    // Lấy thông tin từ các input
    var name = document.getElementById("name").value;
    var phone = document.getElementById("phone").value;
    var address = document.getElementById("address").value;
    var orderName = document.getElementById("order-name").value;
   

    // Kiểm tra nếu có bất kỳ trường nào bị bỏ trống
    if (!name || !phone || !address || !orderName) {
        document.getElementById("message").innerHTML = "Please fill all fields!";
        return;
    }


    var total = parseFloat($(".total-amount").text().replace('$', '').replace(',', '.'));

    window.location.href = "/paymentmomo?name=" + name + "&phone=" + phone + "&address=" + address + "&total=" + total + "&order_name=" + orderName;

}

function paymentVNPay() {
    // Lấy thông tin từ các input
    var name = document.getElementById("name").value;
    var phone = document.getElementById("phone").value;
    var address = document.getElementById("address").value;
    var orderName = document.getElementById("order-name").value;


    // Kiểm tra nếu có bất kỳ trường nào bị bỏ trống
    if (!name || !phone || !address || !orderName) {
        document.getElementById("message").innerHTML = "Please fill all fields!";
        return;
    }
    var total = parseFloat($(".total-amount").text().replace('$', '').replace(',', '.'));

    window.location.href = "/paymentvnpay?name=" + name + "&phone=" + phone + "&address=" + address + "&total=" + total + "&order_name=" + orderName;
}