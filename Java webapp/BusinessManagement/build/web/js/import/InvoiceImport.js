/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function pagger(id, pageindex, totalpage,name,filter, gap)
{
    var container = document.getElementById(id);
    var result = '';
    //generate first
    if (pageindex - gap > 1)
        result += '<li class="page-item"><a href="invoiceimport?page=1&name='+name+'&filter='+filter+'" class="page-link">1</a></li>';

    for (var i = pageindex - gap; i < pageindex; i++)
    {
        if (i >= 1)
        {
            result += '<li class="page-item"><a href="invoiceimport?page=' + i + '&name='+name+'&filter='+filter+'" class="page-link">' + i + '</a></li>';
        }
    }

    // generate span for pageindex
    result += '<li class="active page-item"><a href="#" class="page-link">' + pageindex + '</a></li>';

    for (var i = pageindex + 1; i <= pageindex + gap; i++)
    {
        if (i <= totalpage)
        {
            result += '<li class="page-item"><a href="invoiceimport?page=' + i + '&name='+name+'&filter='+filter+'" class="page-link">' + i + '</a></li>';
        }
    }

    //generate last
    if (pageindex + gap < totalpage)
        result += '<li class="page-item"><a href="invoiceimport?page=' + totalpage + '&name='+name+'&filter='+filter+'" class="page-link">' + totalpage + '</a></li>';

    container.innerHTML = result;
}

function check() {
    var check = 1;
    for (var a = document.querySelectorAll('input'), i = 0; a[i]; ++i) {
        if (!a[0].value && !a[1].value) {
            location.reload();
        }
    }
    if (check == 1) {
        document.getElementById('noww').submit();
    }
}
