// SplideJS Slider. See full docs at:
// https://splidejs.com/
document.addEventListener('DOMContentLoaded', function () {
    var splide = new Splide('#splide', {
      type         : 'loop',
      perPage      : 1,
      autoplay     : true,
      interval     : 5000, // How long to display each slide
      pauseOnHover : false, // must be false
      pauseOnFocus : false, // must be false
      resetProgress: false
    }).mount();
  
    var button = document.querySelector('.splide__play-pause');
  
    if (button) {
      var pausedClass = 'is-paused';
  
      // Remove the paused class and change the label to "Pause".
      splide.on('autoplay:play', function () {
        button.classList.remove(pausedClass);
        // button.textContent = 'Pause';
        var img = document.querySelector('.img-buttonPause');
        img.style.display = 'flex';
        var img = document.querySelector('.img-buttonPlay');
        img.style.display = 'none';
        button.setAttribute('aria-label', 'Pause Autoplay');
      });
  
      // Add the paused class and change the label to "Play".
      splide.on('autoplay:pause', function () {
        button.classList.add(pausedClass);
        // button.textContent = 'Play';
        var img = document.querySelector('.img-buttonPause');
        img.style.display = 'none';
        var img = document.querySelector('.img-buttonPlay');
        img.style.display = 'flex';
        button.setAttribute('aria-label', 'Start Autoplay');
      });
  
      // Toggle play/pause when the button is clicked.
      splide.on('click', function () {
        var flag     = 99;
        var Autoplay = splide.Components.Autoplay;
  
        if (button.classList.contains(pausedClass)) {
          Autoplay.play(flag);
        } else {
          Autoplay.pause(flag);
        }
      }, button);
    }
  });

  window.addEventListener('DOMContentLoaded', function() {
          // Lấy phần tử con thứ nhất
      var firstChild = document.querySelector('.splide__optional-button-container');

      // Lấy phần tử con thứ hai
      var secondChild = document.querySelector('.splide__pagination');

      // Tạo phần tử div cha
      var wrapperDiv = document.createElement('div');

      // Đặt class cho phần tử div cha
      wrapperDiv.className = 'parent-container';

      // Sử dụng phương thức wrapAll để bọc cả hai phần tử con
      firstChild.parentNode.insertBefore(wrapperDiv, firstChild);
      wrapperDiv.appendChild(firstChild);
      wrapperDiv.appendChild(secondChild);
  });

  window.addEventListener('DOMContentLoaded', function() {
    var element = document.querySelector('.splide__arrow--prev');
    var element1 = document.querySelector('.splide__arrow--next');

    var windowHeight = window.innerHeight;
    var windowWidth = window.innerWidth;
    var elementHeight = element.offsetHeight;
    var elementWidth = element.offsetWidth;
    
    var topPosition = (windowHeight - elementHeight) / 3;
    
    element.style.top = topPosition+ 70 + 'px';
    element1.style.top = topPosition+ 70 + 'px';

  });


  
  