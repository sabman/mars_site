# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  #API_KEY = 'ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBTJQa0g3IQ9GZqIMmInSLzwtGDKaBTox7Qzb4PL-EJhVrw0qM75IoR-hg'  #localhost:3000
  #API_KEY = 'ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBRKqhuLjd_uWzYYXjIXZDc_rYXXphRoDCW3Tc5XnLLZAPDNpsP5X4D44g'  #pc-30999:3000
  #API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBT_QGt0ydnrPeJeQ3fLK-qfbkisKhQZfGA44blCoU6lKBYwJlGzjhVHdQ' #10.7.65.109:3000
  #API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBTNDsdv8Kya0OrU386k6NycOBp3zxRI1yv2Vm4esgkI9tVkgGB2CjjASQ' #10.7.65.109:4001
  if RAILS_ENV == "development"
    API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBTJYszD_aHk3EW0KT_ZuefGcmcjnhQA8BWMbTMbWj74G-3ENHKm2IMR8Q' #10.7.65.109:4001
  elsif RAILS_ENV == "production"
    API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBQVRNRdYzxtMDeveoYJXVbmXDJe0RRujVvpgKlqtsSJxcXOpT-KPQKmPg' #10.7.65.109:9090
    #API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBTNDsdv8Kya0OrU386k6NycOBp3zxRI1yv2Vm4esgkI9tVkgGB2CjjASQ' #10.7.65.109:4000
  else
    API_KEY='ABQIAAAAa7SFeUyLeV9ADXW6EhbOsBTNDsdv8Kya0OrU386k6NycOBp3zxRI1yv2Vm4esgkI9tVkgGB2CjjASQ' #10.7.65.109:4000
  end

  GMAP_STATIC_URL="http://maps.google.com/maps/api/staticmap?"
  
  # http://maps.google.com/maps/api/staticmap?
  # size=400x400&
  # path=fillcolor:0xAA000066|color:0xFFFFFF00|enc:ktttE__b{XSQ[GWFUb@Ab@FTNTZHZKNYF[
  # &key=ABQIAAAAjU0EJWnWPMv7oQ-jjS7dYxSPW5CJgpdgO_s4yyMovOaVh_KvvhSfpvagV18eOyDWu7VytS6Bi1CWxw&
  # sensor=false&
  # maptype=hybrid&
  # zoom=19
  #
  # http://maps.google.com/maps/api/staticmap?
  # center=37.401937,-122.080679&
  # zoom=13&
  # path=color:0x0000FF80|weight:5|37.41307,-122.08626|37.39016,-122.08712|37.38907,-122.06961|37.41252,-122.06789|37.41307,-122.08626&
  # size=500x300&
  # sensor=TRUE_OR_FALSE

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

  def class_url(c)
    url_for(c, :only_path => false )
  end

  def indented_render(num=1, *args)
    render(*args).gsub(/^/, "\t" * num)
  end


  def thickbox_iframe_params
    'keepThis=true&TB_iframe=true&height=600&width=800'
  end

 def static_gmap(opts={}) # format of bbox is (xmin,ymin,xmax,ymax)
   return nil unless opts[:llur]
   return static_map_by_bbox(opts[:llur]) if opts[:llur]
 end

  private 
  def static_map_by_bbox(llur)
    p = GeoRuby::SimpleFeatures::Polygon.from_coordinates(llur.as_coordinates)
    p = p.envelope.center
    r = llur.as_coordinates[0].collect{|c| "#{c[1]},#{c[0]}"}.join('|')

    # path=color:0xFFEECC80|weight:2|37.41307,-122.08626|37.39016,-122.08712|37.38907,-122.06961|37.41252,-122.06789|37.41307,-122.08626&
    region = "path=color:0xFFEEAA80|weight:4|#{r}&"
    # center=37.401937,-122.080679&
    center = "center=#{p.y},#{p.x}&"
    # zoom=13&
    zoom = "zoom=5&"
    # size=500x300&
    size="size=500x300&"
    # maptype=hybrid&
    maptype="maptype=hybrid&"
    # sensor=TRUE_OR_FALSE
    sensor="sensor=false"
    GMAP_STATIC_URL+region+center+zoom+size+maptype+sensor+"&"+'keepThis=true&TB_iframe=true&height=304&width=500'
  end

end
