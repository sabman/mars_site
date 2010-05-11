if (typeof MARS == "undefined") {
  MARS = {};
}

MARS.LAYERSTYLES = ( function () {
  /*
   * Layer style
   */
  // we want opaque external graphics and non-opaque internal graphics
  var layer_style = OpenLayers.Util.extend({}, OpenLayers.Feature.Vector.style['default']);
  layer_style.fillOpacity = 0.2;
  layer_style.graphicOpacity = 1;

  /*
   * Blue style
   */
  var style_blue = OpenLayers.Util.extend({}, layer_style);
  style_blue.strokeColor = "blue";
  style_blue.fillColor = "blue";
  style_blue.pointRadius = 10;
  style_blue.strokeWidth = 3;
  style_blue.rotation = 45;
  style_blue.strokeLinecap = "butt";

  /*
   * Bbox style
   */
  var style_bbox = OpenLayers.Util.extend({}, layer_style);
  style_bbox.strokeColor = "red";
  style_bbox.fillColor = "blue";
  style_bbox.fillOpacity = 0.2;
  style_bbox.strokeWidth = 2;
  style_bbox.strokeLinecap = "butt";
  style_bbox.strokeDashstyle = "dash";
  style_bbox.strokeOpacity = 0.6;

  return{
    bbox: style_bbox,
    blue: style_blue
  }
})();
