

//function pagger(id, pageindex, totalpage, gap)
//{
//    var container = document.getElementById(id);
//    var result = '';
//    //generate first
//    if (pageindex - gap > 1)
//        result += '<li class="page-item"><a href="bills?page=1" class="page-link">1</a></li>';
//
//    for (var i = pageindex - gap; i < pageindex; i++)
//    {
//        if (i >= 1)
//        {
//            result += '<li class="page-item"><a href="bills?page=' + i + '" class="page-link">' + i + '</a></li>';
//        }
//    }
//
//    // generate span for pageindex
//    result += '<li class="active page-item"><a href="#" class="page-link">' + pageindex + '</a></li>';
//
//    for (var i = pageindex + 1; i <= pageindex + gap; i++)
//    {
//        if (i <= totalpage)
//        {
//            result += '<li class="page-item"><a href="bills?page=' + i + '" class="page-link">' + i + '</a></li>';
//        }
//    }
//
//    //generate last
//    if (pageindex + gap < totalpage)
//        result += '<li class="page-item"><a href="bills?page=' + totalpage + '" class="page-link">' + totalpage + '</a></li>';
//
//    container.innerHTML = result;
//}

function pagger(id, pageindex, totalpage, search, gap)
{
    var container = document.getElementById(id);
    var result = '';
    //generate first
    if (pageindex - gap > 1)
        result += '<li class="page-item"><a href="expense?page=1&search=' + search + '" class="page-link">1</a></li>';

    for (var i = pageindex - gap; i < pageindex; i++)
    {
        if (i >= 1)
        {
            result += '<li class="page-item"><a href="expense?page=' + i + '&search=' + search + '" class="page-link">' + i + '</a></li>';
        }
    }

    // generate span for pageindex
    result += '<li class="active page-item"><a href="#" class="page-link">' + pageindex + '</a></li>';

    for (var i = pageindex + 1; i <= pageindex + gap; i++)
    {
        if (i <= totalpage)
        {
            result += '<li class="page-item"><a href="expense?page=' + i + '&search=' + search + '" class="page-link">' + i + '</a></li>';
        }
    }

    //generate last
    if (pageindex + gap < totalpage)
        result += '<li class="page-item"><a href="expense?page=' + totalpage + '&search=' + search + '" class="page-link">' + totalpage + '</a></li>';

    container.innerHTML = result;
}

function pagger2(id, pageindex, totalpage, search, gap)
{
    var container = document.getElementById(id);
    var result = '';
    //generate first
    if (pageindex - gap > 1)
        result += '<li class="page-item"><a href="expense?pageleft=1&search=' + search + '" class="page-link">1</a></li>';

    for (var i = pageindex - gap; i < pageindex; i++)
    {
        if (i >= 1)
        {
            result += '<li class="page-item"><a href="expense?pageleft=' + i + '&search=' + search + '" class="page-link">' + i + '</a></li>';
        }
    }

    // generate span for pageindex
    result += '<li class="active page-item"><a href="#" class="page-link">' + pageindex + '</a></li>';

    for (var i = pageindex + 1; i <= pageindex + gap; i++)
    {
        if (i <= totalpage)
        {
            result += '<li class="page-item"><a href="expense?pageleft=' + i + '&search=' + search + '" class="page-link">' + i + '</a></li>';
        }
    }

    //generate last
    if (pageindex + gap < totalpage)
        result += '<li class="page-item"><a href="expense?pageleft=' + totalpage + '&search=' + search + '" class="page-link">' + totalpage + '</a></li>';

    container.innerHTML = result;
}

function checkvalue() {
    var check = 1;
    for (var a = document.querySelectorAll('input'), i = 0; a[i]; ++i) {
        if (!a[i].value) {
            check = 0;
        }

    }
    if (check == 1) {
        document.getElementById('noww').submit();
    }
}

function convert(money) {
    document.getElementById('money').innerHTML=moneyVND(money);
}

function convert2(money) {
    document.getElementById('money2').innerHTML=moneyVND(money);
}


function moneyVND(n) {  
    return new Intl.NumberFormat('it-IT', { style: 'currency', currency: 'VND' }).format(n);
}