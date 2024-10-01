import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MarkLocation {
  final String id;
  final NLatLng position;
  final String info;
  final String number; // 추가
  final String address; // 추가
  final String name; // 추가
  final Color color;

  MarkLocation({
    required this.id,
    required this.position,
    required this.info,
    required this.number,
    required this.address,
    required this.name,
    required this.color,
  });
}

// List of marker locations
List<MarkLocation> markLocations = [
  MarkLocation(
    id: 'marker1',
    position: NLatLng(37.506932467450326, 127.05578661133796),
    info: "Marker 1 Info",
    number: '100',
    address: '서울 강남구 역삼로3길 20-3',
    name: '기린하우스',
    color: Colors.red,
  ),
  MarkLocation(
    id: 'marker2',
    position: NLatLng(37.506932467450326, 127.05678661133796),
    info: "Marker 2 Info",
    number: '80',
    address: '서울 강남구 역삼로3길 20-3',
    name: '기린하우스 2',
    color: Colors.orange,
  ),
  MarkLocation(
    id: 'marker3',
    position: NLatLng(37.506932467450326, 127.05778661133796),
    info: "Marker 3 Info",
    number: '50',
    address: '서울 강남구 역삼로3길 20-3',
    name: '기린하우스 3',
    color: Colors.yellow,
  ),
];

// Function to add markers to the Naver Map controller
void addMarkersToMap(NaverMapController controller) {
  for (final location in markLocations) {
    final marker = NMarker(
      id: location.id,
      position: location.position,
    );
    controller.addOverlay(marker);

    // Open the info window for the marker
    final infoWindow =
        NInfoWindow.onMarker(id: marker.info.id, text: location.info);
    marker.openInfoWindow(infoWindow);
  }
}

// Function to calculate the bounds of all markers
NLatLngBounds calculateBounds() {
  double southWestLat = double.maxFinite;
  double southWestLng = double.maxFinite;
  double northEastLat = double.minPositive;
  double northEastLng = double.minPositive;

  for (final location in markLocations) {
    southWestLat = southWestLat < location.position.latitude
        ? southWestLat
        : location.position.latitude;
    southWestLng = southWestLng < location.position.longitude
        ? southWestLng
        : location.position.longitude;
    northEastLat = northEastLat > location.position.latitude
        ? northEastLat
        : location.position.latitude;
    northEastLng = northEastLng > location.position.longitude
        ? northEastLng
        : location.position.longitude;
  }

  return NLatLngBounds(
    southWest: NLatLng(southWestLat, southWestLng),
    northEast: NLatLng(northEastLat, northEastLng),
  );
}
