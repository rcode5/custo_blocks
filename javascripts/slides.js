function doOnLoad(newFunction) {
  var oldevent = window.onload;
  if (typeof oldevent == "function") {
    window.onload = function() {
      if (oldevent) {
        oldevent();
      }
      newFunction();
    };
  }
  else {
    window.onload = newFunction;
  }
}

doOnLoad(function() {
  var slideIndex = 0;
  var subSlideIndex = 0;
  var subslides;
  
  function removeClass(el, clss) {
    var re = new RegExp("^"+clss+"$|^"+clss+"\\s+|\\s+"+clss+"$|\\s+"+clss+"(\\s+)");
    el.setAttribute( "class", (el.getAttribute('class')||'').replace(re,"$1") )
  }
  function addClass(el, clss) {
    removeClass(el,clss)
    el.setAttribute( 'class', (el.getAttribute('class') || '') + ' ' + clss )
  }
  function hasClass(el, clss) {
    return !!(el.getAttribute('class')||'').match(new RegExp("(\\s+|^)"+clss+"(\\s+|$)"));
  }
  
  if ( location.hash && location.hash.match(/#\d+$/) ) {
    slideIndex = +location.hash.match(/#(\d+)$/)[1]
  }
  
  var slides = document.getElementsByClassName('slide');
  arrangeSlides( slides, slideIndex, true )
  subslides = slides[slideIndex].getElementsByClassName('sub-slide');
  if ( ! subslides.length ) {
    subslides = null;
  } else {
    subSlideIndex = 0;
    arrangeSlides( subslides, 0 );
  }
  
  function arrangeSlides( slides, index, autoHeight ) {
    for (var i=0, slide; slide = slides[i]; i++) {
      slide.style.width = document.body.offsetWidth + 'px';
      if ( autoHeight )
        slide.style.height = document.body.offsetHeight + 'px';
      if ( i > index )
        slide.style.left = document.body.offsetWidth + 'px';
      else if ( i < index )
        slide.style.left = -slide.offsetWidth + 'px';
      else 
        slide.style.left = '0px';
    }      
  }
  
  function transition( oldSlide, newSlide, direction, adjustHeight ) {
    var windowWidth = document.body.offsetWidth;
    removeClass( newSlide, 'transition' );
    newSlide.style.width = document.body.offsetWidth + 'px';
    if (adjustHeight)
      newSlide.style.height = document.body.offsetHeight + 'px';
    newSlide.style.left = direction * windowWidth + 'px';
    addClass( newSlide, 'transition' );
    addClass( oldSlide, 'transition' );
    
    setTimeout(function() { 
      newSlide.style.left = '0px'; 
      oldSlide.style.left = -direction * oldSlide.offsetWidth + 'px' 
    }, 1);
    return newSlide;
  }
  
  function transitionSlide( oldSlide, newSlide, direction ) {
    var interactive = oldSlide.getElementsByClassName('interactive');
    for (var i=0, el; el = interactive[i]; i++)
      window[el.id].hide();
    
    interactive = newSlide.getElementsByClassName('interactive');
    for (var i=0, el; el = interactive[i]; i++)
      window[el.id].show();
    
    subslides = newSlide.getElementsByClassName('sub-slide');
    if ( ! subslides.length ) {
      subslides = null;
    } else {
      subSlideIndex = ~direction ? 0 : subslides.length - 1;
      arrangeSlides( subslides, subSlideIndex );
    }

    return transition(oldSlide, newSlide, direction, true);
  }
  
  function next() {
    if ( subslides && subSlideIndex < subslides.length - 1 )
      return transition( subslides[subSlideIndex], subslides[++subSlideIndex], 1 );
    
    if ( slideIndex >= slides.length - 1 )
      return;
    
    transitionSlide( slides[slideIndex], slides[++slideIndex], 1 );
    location.hash = slideIndex;
  }
  
  function prev() {
    if ( subslides && subSlideIndex > 0 )
      return transition( subslides[subSlideIndex], subslides[--subSlideIndex], -1 );
    
    if ( slideIndex < 1 )
      return;
    transitionSlide( slides[slideIndex], slides[--slideIndex], -1 );
    location.hash = slideIndex;
  }
  
  document.body.onkeyup = function(e) {
    if (e.keyCode == 39) {
      next()
      return false;
    } else if (e.keyCode == 37) {
      prev()
      return false;
    }
  }
});
