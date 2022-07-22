function checkvalue() {
    var check = 1;
    for (var a = document.querySelectorAll('input'), i = 0; a[i]; ++i) {


        if (!a[i].value) {
            a[i].style.backgroundColor = "#FF9A9A";
            document.getElementById('message').innerHTML = "Giá trị không được trống";
            check = 0;
        } else {
            a[i].style.backgroundColor = "#F2F2F2";
        }


    }
    if (check == 1) {
        document.getElementById('noww').submit();
    }
}