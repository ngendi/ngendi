function initialize() {
      if (GBrowserIsCompatible()) {
        var map = new GMap2(document.getElementById("map_canvas"));
        var center = new GLatLng(-7.795357,110.371399);
        map.setCenter(center, 15);
        map.enableContinuousZoom();
		  map.enableDoubleClickZoom();
 
         
        var marker = new GMarker(center, {draggable: true});
 
        GEvent.addListener(marker, "dragstart", function() {
          map.closeInfoWindow();
        });
 
        GEvent.addListener(marker, "dragend", function() {
        var point = marker.getLatLng();
        	 document.getElementById("place_latitude").value=point.lat();
        	 document.getElementById("place_longitude").value=point.lng();
        });
 
        map.addOverlay(marker);
 
      }
    }
