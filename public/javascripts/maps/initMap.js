var map;
var editableLayer;     	// editable vector layer
var bboxLayer;  	// bbox layer
var bboxStyle;
var vectors;
var vector;
var bounds;
var select;


function initMap() {
  map = new OpenLayers.Map('map');
  map.addControl(new OpenLayers.Control.LayerSwitcher());
  map.addControl(new OpenLayers.Control.MousePosition());
  //  map.addControl(new OpenLayers.Control.Graticule({numPoints: 2, labelled: true, visible:true}));
  // Create Map Layers
  //
  var vmap0 = new OpenLayers.Layer.WMS( "OpenLayers WMS", "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'} );
  var gphy = new OpenLayers.Layer.Google("Google Physical",   {type: G_PHYSICAL_MAP});
  var gmap = new OpenLayers.Layer.Google("Google Streets",    {type: G_NORMAL_MAP});
  var ghyb = new OpenLayers.Layer.Google("Google Hybrid",     {type: G_HYBRID_MAP});
  var gsat = new OpenLayers.Layer.Google("Google Satellite",  {type: G_SATELLITE_MAP});
  var demis = new OpenLayers.Layer.WorldWind( "Word Map (tiles cached)", "http://www2.demis.nl/wms/ww.ashx?", 45, 11, {T:"WorldMap"}, { tileSize: new OpenLayers.Size(512,512) });
        
  map.addLayers([vmap0, gphy, demis, gmap, ghyb, gsat]);

  map.setCenter(new OpenLayers.LonLat(130, -25), 3);
  return map;
}

function showMap(url){
  request = $.getJSON(url, null, initGeometry);
}

function indexMap(url){
  request = $.getJSON(url, null, initGeometries);
}

function initGeometries (data) {
  vectors = new OpenLayers.Layer.Vector("Samples");
  bboxLayer = new OpenLayers.Layer.Vector( "BBox", {style: MARS.LAYERSTYLES.bbox});
  map.addLayers([vectors, bboxLayer]);
  map.addControl(new OpenLayers.Control.EditingToolbar(vectors));
  var selectOptions = {box:true, hover:false, onSelect: onFeatureSelect, onUnselect: onFeatureUnselect};
  var select = new OpenLayers.Control.SelectFeature(vectors, selectOptions);
  map.addControl(select);
  select.activate();

  for (var i=0; i < data.length; i++) {
    var geom = data[i].object;
    console.log(geom)
    var geojson = new OpenLayers.Format.GeoJSON({"ignoreExtraDims": true});
    var features = geojson.parseFeature(geom.feature);
    console.log(features)
    if (features) {
      if (features.constructor != Array) { features = [features]; };  
      vectors.addFeatures(features);
    };
  };
  var bounds = vectors.getDataExtent();
  if(bounds == null) return null ;
  map.zoomToExtent(bounds);
  return vectors;
}

function initGeometry(data){
  if(data.object.feature == null) return null ;
  var geom = data.object.feature;
  var geojson = new OpenLayers.Format.GeoJSON({"ignoreExtraDims": true});
  var features =  geojson.parseFeature(geom);
  if(features.constructor != Array){features = [features];}

  // new layer for showing the record on the map
  vector = new OpenLayers.Layer.Vector(data.object.sampleid);
  vector.addFeatures(features); 
  map.addLayer(vector);

  // allow selection
  map.addControl(new OpenLayers.Control.EditingToolbar(vector));
  var selectOptions = {box:true, hover:false, onSelect: onFeatureSelect, onUnselect: onFeatureUnselect};
  var select = new OpenLayers.Control.SelectFeature(vector, selectOptions);
  map.addControl(select);
  select.activate();
  
  // zoom the the extents of the new vector layer
  var bounds = vector.getDataExtent();
  map.zoomToExtent(bounds);
  return vectors;
}

// var drawControls;
function initDrawTool()
{
  // init layers
  editableLayer = new OpenLayers.Layer.Vector( "Editable" );
  bboxLayer     = new OpenLayers.Layer.Vector( "BBox", {style: MARS.LAYERSTYLES.bbox});
  // add EditingToolBar
  map.addControl(new OpenLayers.Control.EditingToolbar(editableLayer));
  map.addLayers([editableLayer, bboxLayer]);
  
  // allow the selection of drawn features
  var editableFeatureSelectControl = new OpenLayers.Control.SelectFeature(
    editableLayer, { box:true, hover:true, onSelect:addBox, onUnselect:removeBox}
  );
  map.addControl(editableFeatureSelectControl);
  editableFeatureSelectControl.activate();
}

function addBox (feature) 
{ // feature passed is a layer 
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
function onFeatureSelect (feature) {
  selectedFeature = feature;
  popup = new OpenLayers.Popup.FramedCloud("Popup", 
      feature.geometry.getBounds().getCenterLonLat(),
      null,
      "<div style='font-size:1em'>Sample ID: <a href='/samples/"+feature.attributes.sampleno+"'>" + feature.attributes.sampleid +"</a>"+
			"<br />Sample type: " + feature.sample_type+
			"<br />Survey: <a href='/surveys/" + feature.attributes.eno+"'>"+feature.attributes.eno+"</a></div><br/>" + 
      "<div style='font-size:0.8em;text-align:right'>click outside to close</div>",
      null, false, onPopupClose);
      feature.popup = popup;
      map.addPopup(popup);
}
function onFeatureUnselect(feature) {
  map.removePopup(feature.popup);
  feature.popup.destroy();
  feature.popup = null;
}    
		
function onPopupClose(evt) {
  console.log(evt);
  select.unselect(selectedFeature);
}
