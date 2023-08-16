function openDrop(filter) {
    var str = "dropdown-" + filter;
    // document.getElementById('price').innerHTML=str;
    var get = document.getElementById(str);
    if (get.style.display == 'none') {
        get.style.display = 'block';
    } else {
        get.style.display = 'none';
    }
}




const button = document.getElementById('bubble-button');

button.addEventListener('click', () => {
  window.location.href = 'https://example.com';
});
  
window.addEventListener("DOMContentLoaded", function() {
    var button = document.getElementById("bubble-button");
    button.style.transform = "translateY(600px)";
    setTimeout(function() {
      button.style.transform = "translateY(0)";
    }, 500);
  });



// $("#load_more_button").on("click", function () {
//     var count = document.getElementsByClassName("product-table").length;
//     $.ajax({
//         type: "post",
//         url: "/gallery",
//         data: {
//             amount: count
//         },
//         beforeSend: function () {
//             $("#load_more_button").hide();
//         },
//         success: function (data) {
//             var c = document.getElementById("load_more_products");
//             c.innerHTML += data;
//         }
//     });
// });
function closeModal() {
    document.getElementById("admin-add-modal").style.display="none";
}


