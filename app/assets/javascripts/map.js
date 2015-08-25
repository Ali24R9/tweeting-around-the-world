var map;
var markers = [];

function initMap() {

  var myLatlng = {lat: 34.1639064, lng: -118.4229371},

  map = new google.maps.Map(document.getElementById('map'), {
    center: myLatlng,
    zoom: 8
  });

  var marker = new google.maps.Marker({
     position: myLatlng,
     map: map,
     title: 'Click to zoom'
   });

  map.addListener('click', function(e) {
    marker.setMap(null);
    deleteMarkers();
    placeMarkerAndPanTo(e.latLng, map);

  });

  function placeMarkerAndPanTo(latLng, map) {

    var marker = new google.maps.Marker({
      position: latLng,
      map: map
    });

    map.panTo(latLng);
    markers.push(marker);
  }

  function deleteMarkers() {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }

    markers = [];
  }
}

// function placeMarkerAndPanTo(latLng, map) {

//   var marker = new google.maps.Marker({
//     position: latLng,
//     map: map
//   });

//   map.panTo(latLng);
//   markers.push(marker);
// }