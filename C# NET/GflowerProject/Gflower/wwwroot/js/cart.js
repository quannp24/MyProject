$(".btn").on("click", function () {


    var $button = $(this),
        $divQuantity = $button.closest('.Cart-Items').find(".count"),
        $textTotal = $button.closest('.CartContainer').find(".total-amount"),
        $unitPrice = $button.closest('.Cart-Items').find(".unitprice"),
        $id = $button.closest('.Cart-Items').find(".id-product"),
        $price = $button.closest('.Cart-Items').find(".amount");
    var oldQuantity = parseInt($divQuantity.text()), newQuantity, newPrice, total = 0,
        valUnitPrice = parseFloat($unitPrice.text().replace('$', '').replace(',', '.')), product = $id.text().trim();
    var cells = document.querySelectorAll('.amount');
    if ($.trim($button.text()) == "+") {

        $.ajax({
            type: "get",
            url: '/Cart?handler=PlusQuantity',
            data: {
                productId: product
            },
            success: function (data) {
                if (data.success == true) {
                    newQuantity = oldQuantity + 1;
                    $divQuantity.text(newQuantity); // quantity them 1
                    newPrice = valUnitPrice * newQuantity;
                    $price.text('$' + newPrice.toFixed(2)); //set lai price moi
                    for (i = 0; i < cells.length; i++) { //tính lại tổng
                        total = total + parseFloat(cells[i].textContent.replace('$', '').replace(',', '.'));
                    }
                    total = total.toFixed(2);
                    $textTotal.text('$' + total);
                }
            }
        });
    } else {
        // Don't allow decrementing below zero
        if (oldQuantity > 1) {
            $.ajax({
                type: 'get',
                url: '/Cart?handler=MinusQuantity',
                data: {
                    productId: product
                },
                success: function (data) {
                    if (data.success == true) {
                        newQuantity = oldQuantity - 1;
                        $divQuantity.text(newQuantity); // quantity them 1
                        newPrice = valUnitPrice * newQuantity;
                        $price.text('$' + newPrice.toFixed(2)); //set lai price moi
                        for (i = 0; i < cells.length; i++) { //tính lại tổng
                            total = total + parseFloat(cells[i].textContent.replace('$', '').replace(',', '.'));
                        }
                        total = total.toFixed(2);
                        $textTotal.text('$' + total);
                    }
                }
            });
        }
    }

});
$(".remove").on("click", function () {
    var $button = $(this),
        $block = $button.closest('.Cart-Items'),
        $price = $button.closest('.Cart-Items').find(".amount"),
        $item = $button.closest('.Cart-Items').find(".items"),
        $textTotal = $button.closest('.CartContainer').find(".total-amount"),
        $id = $block.find(".id-product");
    var product = $id.text().trim();
    var numOld = $("#number-cart").text(), totalText = $textTotal.text(), i, total = 0;
    $.ajax({
        type: 'get',
        url: '/Cart?handler=RemoveCart',
        data: {
            productId: product
        },
        success: function (data) {
            if (data.success == true) {
                $("#number-cart").text(parseInt(numOld) - 1);
                $block.remove();
                total = parseFloat(totalText.replace('$', ''));
                total = total - parseFloat($price.text().replace('$', ''));
                total = total.toFixed(2);
                $textTotal.text('$' + total);
                $item.text(parseInt($item.text()) - 1);
            }
        }
    });
});

$(".btn-checkout").on("click", function () {
    if (urlCheckout.length > 0) {
        window.location.href = urlCheckout;

    }
    
});

var btn_vnpay = document.getElementById("type-vnpay");
var btn_momo = document.getElementById("type-momo");
var urlCheckout = "";

btn_vnpay.addEventListener("click", function () {
    btn_momo.style.backgroundColor = "#fff";
    btn_momo.style.borderColor = "#8d8080";
    btn_momo.style.borderWidth = "1px";

    btn_vnpay.style.backgroundColor = "rgb(223 223 223)";
    btn_vnpay.style.borderColor = "rgb(145 160 189)";
    btn_vnpay.style.borderWidth = "3px";
    urlCheckout = "/payment?id=1";
});

btn_momo.addEventListener("click", function () {
    btn_vnpay.style.backgroundColor = "#fff";
    btn_vnpay.style.borderColor = "#8d8080";
    btn_vnpay.style.borderWidth = "1px";

    btn_momo.style.backgroundColor = "rgb(223 223 223)";
    btn_momo.style.borderColor = "rgb(145 160 189)";
    btn_momo.style.borderWidth = "3px";
    urlCheckout = "/payment?id=0";

});