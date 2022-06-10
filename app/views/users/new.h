<div class="block_main">
<h1>New user</h1>

<%= render "form", user: @user %>

<br>

<div>
  <%= link_to "Back to users", users_path %>
</div>
</div>

<div id='map'></div>

<script>

mapboxgl.accessToken = 'pk.eyJ1Ijoia2Vsenp6ZXIiLCJhIjoiY2wzMXVxNjk4MGZxcjNpb2pxd3lqczRyaiJ9.IvHxJFJQDY5yoISmeC5Low';
var map = new mapboxgl.Map({
container: 'map', // container ID
style: 'mapbox://styles/mapbox/streets-v11', // style URL
center: [27.54, 53.9], // starting position [lng, lat]
zoom: 11 // starting zoom
});

map.on('style.load', function() {
map.on('click', function(e) {
var coordinates = e.lngLat;
var coordinatesLongitude = coordinates.lng;
var coordinatesLatitude = coordinates.lat;
document.querySelector('#user_latitude').value = coordinatesLongitude;
document.querySelector('#user_longitude').value = coordinatesLatitude;
console.log(coordinates)

// this is create popup
new mapboxgl.Popup()
  .setLngLat(coordinates)
  .setHTML('You are here!')
  .addTo(map);
  });
});

// Initialize the geolocate control.
var geolocate = new mapboxgl.GeolocateControl({
  positionOptions: {
    enableHighAccuracy: true
  },
  trackUserLocation: true
});

// Add the control to the map.
map.addControl(new mapboxgl.NavigationControl());
map.addControl(geolocate);
geolocate.on('geolocate', function(e) {
  document.querySelector('#user_latitude').value = e.coords.latitude;
document.querySelector('#user_longitude').value = e.coords.longitude;
});
</script>

