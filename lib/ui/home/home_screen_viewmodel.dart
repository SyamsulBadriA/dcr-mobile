import 'dart:async';
import 'dart:ui' as ui;
import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/app/app.logger.dart';
import 'package:dcr_mobile/dto/user_location_request.dart';
import 'package:dcr_mobile/models/location.dart';
import 'package:dcr_mobile/models/user.dart';
import 'package:dcr_mobile/services/api_services.dart';
import 'package:dcr_mobile/services/api_user_location_services.dart';
import 'package:dcr_mobile/services/local_user_location_services.dart';
import 'package:dcr_mobile/services/local_user_profile_services.dart';
import 'package:dcr_mobile/services/map_services.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenViewModel extends FutureViewModel {
  final log = getLogger("HomeScreenViewModel");

  final apiServiceLocation = locator<ApiUserLocationServices>();
  final _hiveServiceLocation = locator<LocalUserLocationServices>();
  final _hiveServiceUser = locator<LocalUserProfileServices>();
  final _mapServices = locator<MapServices>();

  UserProfile? _userProfile;
  CameraPosition? _initialCameraPosition;
  List<LatLng>? _listCoordinates;
  Polyline? _polyline;
  List<CheckPoints>? _checkpoints;
  List<Marker>? _marker;
  Position? _previousLoc;
  Position? _nowLoc;

  final Completer<GoogleMapController> _controller = Completer();

  Completer<GoogleMapController> get controller => _controller;

  UserProfile? get user => _userProfile;

  CameraPosition get cameraPosition =>
      _initialCameraPosition ??
      const CameraPosition(
        target: LatLng(-7.267318, 109.959513),
        zoom: 15,
      );

  List<Marker> get checkpointsMarker => _marker ?? [];

  Polyline get polyline =>
      _polyline ?? const Polyline(polylineId: PolylineId("0"));

  @override
  Future futureToRun() async {
    /// Receive events from BackgroundGeolocation in Headless state.

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedIdUser = prefs.getString(savedId) ?? '';
    log.v('ApiService _savedIdUser: $savedIdUser');

    final pos = await _mapServices.getCurrentPosition();

    _userProfile = _hiveServiceUser.getDetailUser(savedIdUser);

    final category = "${_userProfile?.idCategory}_km";
    log.v("CATEGORY: $category");

    _initialCameraPosition = CameraPosition(
      target: LatLng(pos.longitude, pos.latitude),
      zoom: 10,
    );

    await parseGPX(category);

    final currentPos = await Geolocator.getCurrentPosition();

    await apiServiceLocation.submitUserLocation(
      UserLocationRequest(
        uid: _userProfile?.idUser ?? "",
        email: _userProfile?.email,
        longitude: currentPos.longitude.toString(),
        latitude: currentPos.latitude.toString(),
        altitude: (currentPos.altitude).toString(),
        fullname: _userProfile?.fullname,
        category: category,
      ),
    );

    Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    )).listen((Position? position) {
      _nowLoc = position;

      if (_controller.isCompleted) {
        if (_previousLoc != null) {
          // Calculate distance between current and previous location
          double distance = _mapServices.calculateDistanceGeo(
            _previousLoc?.latitude,
            _previousLoc?.longitude,
            _nowLoc?.latitude,
            _nowLoc?.longitude,
          );

          // Update map camera only if distance exceeds 100 meters (0.1 km)
          if (distance > 0.03) {
            _controller.future.then((controller) {
              controller.animateCamera(CameraUpdate.newLatLng(
                  LatLng(_nowLoc?.latitude ?? 0, _nowLoc?.longitude ?? 0)));

              _hiveServiceLocation.newUser(
                UserLocation(
                  idUser: _userProfile?.idUser ?? "",
                  latitude: _nowLoc?.latitude ?? 0,
                  longitude: _nowLoc?.longitude ?? 0,
                  altitude: 10,
                ),
              );

              apiServiceLocation
                  .submitUserLocation(
                    UserLocationRequest(
                      uid: _userProfile?.idUser ?? "",
                      email: _userProfile?.email,
                      longitude: _nowLoc?.longitude.toString(),
                      latitude: _nowLoc?.latitude.toString(),
                      altitude: (_nowLoc?.altitude ?? 10).toString(),
                      fullname: _userProfile?.fullname,
                      category: category,
                    ),
                  )
                  .then((value) => null);
            });
          }
          // Update previous location to current location
          _previousLoc = _nowLoc;
        }
      } else {
        // First location update, set previous location
        _previousLoc = _nowLoc;
      }
    });

    log.v("SUCCESS: set polyline => ${_polyline?.points.length}");
    log.v("SUCCESS: set markers => ${_marker?.length}");
  }

  Future<void> parseGPX(String category) async {
    final gpx = await _mapServices.getGpx(category);
    final wpts = gpx?.trks
        .map((e) => e.trksegs.toList().map((e) => e.trkpts.toList()).toList())
        .toList()[0][0];

    _checkpoints = gpx?.wpts
        .map(
            (e) => CheckPoints(name: e.name, latitude: e.lat, longitude: e.lon))
        .toList();

    _listCoordinates =
        wpts?.map((e) => LatLng(e.lat ?? 0, e.lon ?? 0)).toList();

    _polyline = Polyline(
      polylineId: PolylineId(category),
      points: _listCoordinates ?? [],
      color: const Color(0xff10385b),
      width: 3,
    );

    _marker = _checkpoints?.map((e) {
      return Marker(
          markerId: MarkerId(e.name ?? ''),
          position: LatLng(e.latitude ?? 0, e.longitude ?? 0),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: e.name,
          ));
    }).toList();
  }

  // declared method to get Images
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> submitLocation(UserLocation userLocation) async {
    _hiveServiceLocation.newUser(userLocation);

    await apiServiceLocation.submitUserLocation(UserLocationRequest(
      uid: userLocation.idUser,
      altitude: userLocation.altitude.toString(),
      latitude: userLocation.latitude.toString(),
      longitude: userLocation.longitude.toString(),
      email: _userProfile?.email ?? "",
      fullname: "${_userProfile?.fullname}",
    ));
  }
}
