// periodically check to see if the scroll bar is near the end of the page

var currentPage = 1;
function checkScroll () {
  if (nearBottomOfPage()) {
    currentPage++;
    //new Ajax.Request('/products?page='+currentPage, {asynchronous:true, evalScripts:true, method:'get'});
    $.ajax({data: ({page : currentPage})});
  } else{
    setTimeout("checkScroll()", 250);
  };
}

function nearBottomOfPage () {
  return scrollDistanceFromBottom() < 150;
}

function scrollDistanceFromBottom () {
  return pageHeight() - (window.pageYOffset + self.innerHeight);
}

function pageHeight () {
  return Math.max(document.body.scrollHeight, document.body.offsetHeight);
}

document.observe('dom:loaded', checkScroll);
