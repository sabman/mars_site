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

var drawControls;
var vLayer;     // editable vector layer
var bboxLayer;  // bbox layer
var bboxStyle;
function initDrawTool(){

  // init layers
  vLayer = new OpenLayers.Layer.Vector( "Editable" );
  bboxLayer = new OpenLayers.Layer.Vector( "BBox", {style: MARS.LAYERSTYLES.bbox});
  map.addLayers([vLayer, bboxLayer]);

  drawControls = {
    editingToolBar: new OpenLayers.Control.EditingToolbar(vLayer)
  };
  for(var key in drawControls){
    map.addControl(drawControls[key]);
  }
  
  // allow the selection of drawn features
  var selectOptions = {box:true, hover:true, onSelect:addBox, onUnselect:removeBox};
  var select = new OpenLayers.Control.SelectFeature(vLayer, selectOptions);
  map.addControl(select);
  select.activate();
}

var bounds;
function addBox (feature) { // feature passed is a layer 
  bounds = new OpenLayers.Feature.Vector(feature.geometry.bounds.toGeometry());
  $("#region_corners_input input").val(feature.geometry.bounds.toBBOX()); 
  $("#region_coordinates_input input").val("[["+feature.geometry.bounds.toBBOX()+"]]"); 
  bboxLayer.destroyFeatures();
  bboxLayer.addFeatures([bounds]); 
  // vLayer.redraw();
  // should display the bounding box of the features
  // and fill in the correct text fields
  var jsonFrmt = new OpenLayers.Format.GeoJSON();
  var str = jsonFrmt.write(feature, true);
  console.log(str);
}

function removeBox (feature) {
  ;
}


