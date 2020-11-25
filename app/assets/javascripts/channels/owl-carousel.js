$(function(){
  $(".slide-banner.owl-carousel").owlCarousel();
});

$(document).ready(function(){
  $("#main-slider").owlCarousel({
    autoplay: true,
    center: true,
    stagePadding: 115,
    items:1,
    nav: true,
    loop:true
  });
  $("#banner-slider").owlCarousel({
    autoplay: true,
    center: true,
    stagePadding: 115,
    items:1000,
    nav: true,
    loop:true
  });
});

