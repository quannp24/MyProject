function generateTableRow() {
    var emptyColumn = document.createElement('tr');

    emptyColumn.innerHTML = '<td><a class="cut" onclick="remove(this)">-</a><input type="text" style="width: 100%;" name="product"></td>' +
            '<td><input type="text" style="width: 100%;" name="describe"></td>' +
            '<td><span></span><input onkeyup="myadd()" type="text" style="width: 100%; text-align: center;" name="unitprice"></td>' +
            '<td><input type="text" onkeyup="myadd()" style="width: 100%;text-align: center;" name="quantity"></td>' +
            '<td><span></span><input type="text" style="width: 100%;text-align: right;" name="price" readonly value="0"></td>';

    return emptyColumn;
}

//function parsePrice(number) {
//    return number.toLocaleString('it-IT', { style: 'currency', currency: 'VND' });
//}



function myFun() {
    document.querySelector('table.inventory tbody').appendChild(generateTableRow());
}

function remove(currElement) {
    var parentRowIndex = currElement.parentNode.parentNode.rowIndex;
    document.getElementById("myTable").deleteRow(parentRowIndex);

}

function myadd() {
    var total = 0;
    var cells, price, total, a, i;

    // update inventory cells
    // ======================

    for (var a = document.querySelectorAll('table.inventory tbody tr'), i = 0; a[i]; ++i) {
        // get inventory row cells
        cells = a[i].getElementsByTagName('input');

        // set price as cell[2] * cell[3]
        price = cells[2].value * cells[3].value;

        // add price to total
        total += price;

        // set row total

        cells[4].value = price;
    }
    // get balance cells
    cells = document.querySelectorAll('table.balance td:last-child input');

    // set total
    cells[0].value = total;

    // set balance and meta balance
    cells[2].value = total - parseInt(cells[1].value);



}

function checkvalue() {
    var check = 1;
    for (var a = document.querySelectorAll('input'), i = 0; a[i]; ++i) {
       
        if (i != 1 && i != 2) {
            if (!a[i].value) {
                a[i].parentNode.style.backgroundColor = "#FF9A9A";
                a[i].style.backgroundColor = "#FF9A9A";
                document.getElementById('message').innerHTML = "Giá trị không được trống";
                check = 0;
            } else {
                a[i].parentNode.style.backgroundColor = "#FFffff";
                a[i].style.backgroundColor = "#FFffff";

            }

        }

    }
    if (check == 1) {
        document.getElementById('noww').submit();
    }
}
