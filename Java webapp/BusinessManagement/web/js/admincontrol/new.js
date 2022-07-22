

function myFunction() {
    for (var a = document.querySelectorAll('input'), i = 0; a[i]; ++i) {
        if (i > 4) {
            if (a[i].type === "password") {
                a[i].type = "text";
            } else {
                a[i].type = "password";
            }
        }
    }
}

function checkvalue() {
    var check = 1;
    for (var a = document.querySelectorAll('input'), i = 0; a[i]; ++i) {

        if (i != 3 && i != 4) {
            if (!a[i].value) {
                a[i].style.backgroundColor = "#FF9A9A";
//                a[i].style.backgroundColor = "#FF9A9A";
                document.getElementById('message').innerHTML = "Giá trị không được trống";
                check = 0;
            } else {

                a[i].style.backgroundColor = "#FFffff";

            }

        }

    }
    if (check == 1) {
        document.getElementById('noww').submit();
    }
}

function del(pos) {
    var result = confirm("Bạn có chắc muốn xóa nhân viên này không?");
    if (result)
    {
        window.location.href = "deletestaff?user=" + pos;
    }
}