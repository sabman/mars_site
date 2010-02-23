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
  var demis = new OpenLayers.Layer.WorldWind( "Word Map (tiles cached)", "http://www2.demis.nl/wms/ww.ashx?", 45, 11, {T:"WorldMap"}, { tileSize: new OpenLayers.Size(512,512) });
        
  map.addLayers([gphy, demis, gmap, ghyb, gsat]);

  map.setCenter(new OpenLayers.LonLat(135, -25), 3);
  return map;
}

function showMap(url){
  request = $.getJSON(url, null, initGeometry);
}

function indexMap(url){
  request = $.getJSON(url, null, initGeometries);
}

function initGeometries (data) {
  var vectors = new OpenLayers.Layer.Vector("Samples");
  var bboxLayer = new OpenLayers.Layer.Vector( "BBox", {style: MARS.LAYERSTYLES.bbox});
  map.addLayers([vectors, bboxLayer]);
  map.addControl(new OpenLayers.Control.EditingToolbar(vectors));
  var selectOptions = {box:true, hover:true};
  var select = new OpenLayers.Control.SelectFeature(vectors, selectOptions);
  map.addControl(select);
  select.activate();

  for (var i=0; i < data.length; i++) {
    var geom = data[i].object.geom;
    var geojson = new OpenLayers.Format.GeoJSON({"ignoreExtraDims": true});
    var features = geojson.read(geom);
    if (geom) {
      features.id = data[i].id;
      //addBox(features);
      if (features.constructor != Array) { features = [features]; };  
      vectors.addFeatures(features);
    };
  };
  var bounds = vectors.getDataExtent();
  map.zoomToExtent(bounds);
}

function initGeometry(data){
  var geom = data.object.geom;
  var geojson = new OpenLayers.Format.GeoJSON({"ignoreExtraDims": true});
  var features =  geojson.read(geom);
  if(features.constructor != Array){features = [features];}

  // new layer for showing the record on the map
  var vectors = new OpenLayers.Layer.Vector(data.object.sampleid);
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
  var str = jsonFrmt.write(feature);
  $("#region_geometry_input input").val(str); 
  console.log(str);
}

function removeBox (feature) {
  ;
}

function deseriliaze () {
  var element = NULL //make a json call to get the geometry
}


function addHighlighting (vectors) {

  var report = function(e) {
    OpenLayers.Console.log(e.type, e.feature.id);
  };
            
  var highlightCtrl = new OpenLayers.Control.SelectFeature(vectors, {
    hover: true,
    highlightOnly: true,
    renderIntent: "temporary",
    eventListeners: {
      beforefeaturehighlighted: report,
      featurehighlighted: report,
      featureunhighlighted: report
    }
  });

  var selectCtrl = new OpenLayers.Control.SelectFeature(vectors,
    {clickout: true}
  );

  map.addControl(highlightCtrl);
  map.addControl(selectCtrl);

  highlightCtrl.activate();
  selectCtrl.activate();
  return vectors;
}
