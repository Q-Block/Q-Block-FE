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
    position: NLatLng(37.4962, 127.1235),
    info: "Marker 1 Info",
    number: '100',
    address: '서울 송파구 송이로123',
    name: '경찰병원',
    color: Colors.red,
  ),
  MarkLocation(
    id: 'marker2',
    position: NLatLng(37.495116, 127.122461),
    info: "Marker 2 Info",
    number: '80',
    address: '서울 송파구 중대로 135',
    name: 'IT벤처타워',
    color: Colors.orange,
  ),
  MarkLocation(
    id: 'marker3',
    position: NLatLng(37.4956, 127.1213),
    info: "Marker 3 Info",
    number: '50',
    address: '서울 송파구 가락동 77-1',
    name: '로만손빌딩',
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
