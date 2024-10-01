import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'current_location.dart';
import 'mark_locations.dart';

class NaverMapWidget extends StatefulWidget {
  final Function(NaverMapController)
      onMapReady; // Add a callback for when the map is ready

  const NaverMapWidget(
      {super.key,
      required this.onMapReady}); // Require the callback in the constructor

  @override
  _NaverMapWidgetState createState() => _NaverMapWidgetState();
}

class _NaverMapWidgetState extends State<NaverMapWidget> {
  NaverMapController? _mapController;
  CurrentLocation _currentLocation = CurrentLocation();

  final _initialCameraPosition = NCameraPosition(
    target: NLatLng(37.506932467450326, 127.05778661133796), // 초기 좌표 (서울 시청)
    zoom: 15,
    bearing: 0,
    tilt: 0,
  );

  @override
  void initState() {
    super.initState();
    _initializeNaverMap();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveToCurrentLocation();
    });
  }

  void _moveToCurrentLocation() async {
    try {
      // 위치 권한 요청 및 현재 위치 가져오기
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('위치 서비스가 비활성화되어 있습니다.');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('위치 권한이 거부되었습니다.');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        print('위치 권한이 영구적으로 거부되었습니다.');
        return;
      }

      // 현재 위치 가져오기
      Position position = await _currentLocation.getCurrentLocation();
      double lat = position.latitude;
      double lng = position.longitude;

      print('현재 위치: 위도 = $lat, 경도 = $lng');

      // 현재 위치로 카메라 이동
      _mapController?.updateCamera(
        NCameraUpdate.scrollAndZoomTo(target: NLatLng(lat, lng)),
      );
    } catch (e) {
      print('위치 오류: $e');
    }
  }

  Future<void> _initializeNaverMap() async {
    WidgetsFlutterBinding.ensureInitialized(); // Flutter의 엔진 초기화
    String? clientId = dotenv.env['MAP_clientId']; // Naver Map 클라이언트 ID 설정
    await NaverMapSdk.instance
        .initialize(clientId: clientId); // NaverMap SDK 초기화
    print("Naver Map SDK 초기화 완료");
  }

  List<NMarker> _createMarkers() {
    return markLocations.map((location) {
      return NMarker(
        id: location.name, // Marker ID should be unique
        position: location.position,
        caption: NOverlayCaption(
            text: location.name, color: Colors.black), // Optional caption
      );
    }).toList();
  }

  void addMarkersToMap(NaverMapController controller) {
    final markers = _createMarkers();
    for (var marker in markers) {
      controller.addOverlay(marker); // Set each marker on the map
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 300.0, // 지도 크기 설정
          child: NaverMap(
            options: NaverMapViewOptions(
                // Here you can add more Naver Map options if needed
                ),
            onMapReady: (controller) {
              _mapController = controller;
              print("네이버 맵 로딩됨!");

              addMarkersToMap(_mapController!);
              _moveToCurrentLocation();

              widget.onMapReady(controller);
            },
          ),
        ),
        Positioned(
          top: 10, // Adjust the position as needed
          right: 10,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white, // White background
              foregroundColor: Colors.green, // Green text
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            onPressed:
                _moveToCurrentLocation, // Move to current location on tap
            child: const Text('현재 위치로 이동'),
          ),
        ),
      ],
    );
  }
}
