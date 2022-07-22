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

function del(pos){
    var result = confirm("Bạn có chắc muốn xóa hóa đơn này không?");
    if (result)
    {
        window.location.href = "deletebill?delete=" + pos;
    }
}