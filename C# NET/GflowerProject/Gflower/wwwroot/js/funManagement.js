window.addEventListener("load", function () {
    setTimeout(function () {
        document.getElementById("content-bodyload").style.display = "block";
    }, 1000);
    setTimeout(function () {
        document.getElementById("loading-screen").style.display = "none";
    }, 1100);
});


//filter of All orders
var filterSelect = document.getElementById("filter-select-order");
var totalOrdersDiv = document.getElementById("total-orders");
var filterMoney = document.getElementById("filter-select-money");
var totalMoneyDiv = document.getElementById("total-money");

filterSelect.addEventListener("change", function () {
    var selectedValue = filterSelect.value;
    calculateTotalOrders(selectedValue);
});

filterMoney.addEventListener("change", function () {
    var selectedValueMoney = filterMoney.value;
    calculateTotalMoney(selectedValueMoney);
});


function calculateTotalOrders(filter) {
    var apiUrl = "http://localhost:5025/api/Order/get-count-orders/";
    if (filter === "day") {
        apiUrl += "1";
    } else if (filter === "month") {
        apiUrl += "2";
    } else if (filter === "year") {
        apiUrl += "3";
    }
    $.ajax({
        url: apiUrl,
        success: function (result) {
            // Xử lý kết quả đếm số bản ghi trong ngày hôm nay
            var count = parseInt(result);
            totalOrdersDiv.innerText = count
        },
        error: function (xhr, status, error) {
            // Xử lý lỗi nếu có
            console.error("Lỗi khi gọi API OData: " + error);
        }
    });
}

    function calculateTotalMoney(filter) {
        var apiUrl = "http://localhost:5025/api/Order/get-total-money/";
        if (filter === "day") {
            apiUrl += "1";
        } else if (filter === "month") {
            apiUrl += "2";
        } else if (filter === "year") {
            apiUrl += "3";
        }
        $.ajax({
            url: apiUrl,
            success: function (result) {
                // Xử lý kết quả đếm số bản ghi trong ngày hôm nay
                var count = parseInt(result);
                totalMoneyDiv.innerText = count+ " $";
            },
            error: function (xhr, status, error) {
                // Xử lý lỗi nếu có
                console.error("Lỗi khi gọi API OData: " + error);
            }
        });
    }

