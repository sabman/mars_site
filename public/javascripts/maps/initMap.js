var map;
function initMap() {
  map = new OpenLayers.Map('map');
  map.addControl(new OpenLayers.Control.LayerSwitcher());
  //  map.addControl(new OpenLayers.Control.Graticule({numPoints: 2, labelled: true, visible:true}));
  // Create Map Layers
  var gphy = new OpenLayers.Layer.Google("Google Physical",   {type: G_PHYSICAL_MAP});
  var gmap = new OpenLayers.Layer.Google("Google Streets",    {type: G_NORMAL_MAP, numZoomLevels: 20});
  var ghyb = new OpenLayers.Layer.Google("Google Hybrid",     {type: G_HYBRID_MAP, numZoomLevels: 20});
  var gsat = new OpenLayers.Layer.Google("Google Satellite",  {type: G_SATELLITE_MAP, numZoomLevels:20});

  map.addLayers([gphy, gmap, ghyb, gsat]);

  map.setCenter(new OpenLayers.LonLat(135, -25), 3);
  return map;
}

function showMap(url){
  request = $.getJSON(url, null, initGeometry);
}

function initGeometry(data){
  var geom = data.sample.geom;
  var geojson = new OpenLayers.Format.GeoJSON({"ignoreExtraDims": true});
  var features =  geojson.read(geom)
  if(features.constructor != Array){features = [features];}

  // new layer for showing the record on the map
  var vectors = new OpenLayers.Layer.Vector(data.sample.sampleid);
  vectors.addFeatures(features); 
  map.addLayer(vectors);

  // zoom the the extents of the new vector layer
  var bounds = vectors.getDataExtent();
  map.zoomToExtent(bounds);
}

