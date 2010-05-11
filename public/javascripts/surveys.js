jQuery(document).ready(function($) {
  $('div.pagination a').livequery('click', function() {
    $('#surveys').load(this.href)
    return false
  })
})
