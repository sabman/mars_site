# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  #API_KEY = 'ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBTJQa0g3IQ9GZqIMmInSLzwtGDKaBTox7Qzb4PL-EJhVrw0qM75IoR-hg'  #localhost:3000
  #API_KEY = 'ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBRKqhuLjd_uWzYYXjIXZDc_rYXXphRoDCW3Tc5XnLLZAPDNpsP5X4D44g'  #pc-30999:3000
  API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBT_QGt0ydnrPeJeQ3fLK-qfbkisKhQZfGA44blCoU6lKBYwJlGzjhVHdQ' #10.7.65.109:3000
  def js_gmaps
    javascript_link("http://maps.google.com/maps?file=api&amp;v=2&amp;sensor=false&amp;key=#{API_KEY}")
  end

  def js_openlayers
    javascript('http://openlayers.org/dev/OpenLayers.js') 
  end

  def include_maps
    stylesheet('openlayers', 'googlemaps'  )
    js_gmaps
    js_openlayers
    javascript('mars')
    javascript('maps/initMap') 
  end

  def pageless(total_pages, url=nil)
    opts = {
      :totalPages => total_pages,
      :url        => url,
      :loaderMsg  => 'Loading more results'
    }
    
    javascript_tag("$('#main').pageless(#{opts.to_json});")
  end
end
