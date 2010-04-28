var lon = 5;
var lat = 40;
var zoom = 5;
var map, layer;

function init(){
  layer = new OpenLayers.Layer.WMS( "OpenLayers WMS",
    "http://labs.metacarta.com/wms/vmap0", {layers: 'basic'} );
    
  vlayer = new OpenLayers.Layer.Vector( "Editable" );
  map = new OpenLayers.Map( 'map', {
    controls: [
      new OpenLayers.Control.PanZoom(),
      new OpenLayers.Control.EditingToolbar(vlayer)
    ]
  });
  map.addLayers([layer, vlayer]);
    
  map.setCenter(new OpenLayers.LonLat(lon, lat), zoom);
}
