window.addEventListener("load", function () {
    setTimeout(function () {
        document.getElementById("content-bodyload").style.display = "block";
    }, 1000);
    setTimeout(function () {
        document.getElementById("loading-screen").style.display = "none";
    }, 1100);
});