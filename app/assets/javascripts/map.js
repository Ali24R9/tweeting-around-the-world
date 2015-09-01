var map;
var markers = [];
var myLatlng;
var latLng;

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
    myLatlng = latLng
    // $.ajax({
    //   type: "POST",
    //   url: "/tweets/get_tweets",
    //   dataType: 'json',
    //   data: {coordinates: myLatlng}
    // });

  });

  function placeMarkerAndPanTo(latLng, map) {

    var marker = new google.maps.Marker({
      position: latLng,
      map: map
    });

    map.panTo(latLng);
    markers.push(marker);

    $.ajax({
      type: "POST",
      url: "/tweets/get_tweets",
      data: {coordinates: JSON.stringify(latLng)},
      success: function(data){
        tweets = data["embedded_tweets"]
        $("#tweets").empty();
        $.each(tweets, function(index, value){
          $("#tweets").append("<div id=" + index + "></div>")
          $('#' + index).append(value.html)
        });
      }
    });

  }

  function deleteMarkers() {
    for (var i = 0; i < markers.length; i++) {
      markers[i].setMap(null);
    }

    markers = [];
  }

  window.twttr = (function (d, s, id) {
  var t, js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src= "https://platform.twitter.com/widgets.js";
  fjs.parentNode.insertBefore(js, fjs);
  return window.twttr || (t = { _e: [], ready: function (f) { t._e.push(f) } });
  }(document, "script", "twitter-wjs"));
}


// function placeMarkerAndPanTo(latLng, map) {

//   var marker = new google.maps.Marker({
//     position: latLng,
//     map: map
//   });

//   map.panTo(latLng);
//   markers.push(marker);
// }