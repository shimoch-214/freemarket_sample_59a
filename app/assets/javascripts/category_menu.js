$(function(){
  $(".item-tag__box").hover(function(){
    $($(this).children(".item-tag__category--box"))
    .children("ul")
    .css("display", "block")
  },
  function(){
    $($(this).children(".item-tag__category--box"))
    .children("ul")
    .css("display", "none")
  });
  $(".parent").hover(function(){
    $($(this).children("ul"))
    .css("display", "block")
    $($(this).children("a"))
    .css("color", "#fff")
  },
  function(){
    $($(this).children("ul"))
    .css("display", "none")
    $($(this).children("a"))
    .css("color", "#333")
  });
  $(".category-child").hover(function(){
    $($(this).children("ul"))
    .css("display", "block")
  },
  function(){
    $($(this).children("ul"))
    .css("display", "none")
  });

});
