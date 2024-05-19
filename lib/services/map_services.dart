import 'dart:async';
import 'dart:math';

import 'package:dcr_mobile/app/app.logger.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gpx/gpx.dart';
import 'package:http/http.dart' as http;

class MapServices {
  final log = getLogger('MapServices');

  Future<Gpx?> getGpx(String category) async {
    var cat = "";

    switch (category) {
      case "10_km":
        cat = "10KM_DCR.gpx";
        break;
      case "21_km":
        cat = "21KM_DCR.gpx";
        break;

      case "42_km":
        cat = "42KM_DCR.gpx";
        break;

      case "75_km":
        cat = "75KM_DCR.gpx";
        break;

      default:
        cat = "10KM_DCR.gpx";
        break;
    }

    final uri = Uri.parse("https://assajjadazis.github.io/tracks/$cat");

    log.v("MapServices => Parsing GPX ${uri.path}");

    final res = await http.get(uri);
    if (res.statusCode == 200) {
      var gpxStr = GpxReader().fromString(res.body);
      return gpxStr;
    }
    return null;
  }

  Future<LocationPermission> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    return permission;
  }

  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: const Duration(minutes: 2),
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double calculateDistanceGeo(
    startLatitude,
    startLongitude,
    endLatitude,
    endLongitude,
  ) {
    return Geolocator.distanceBetween(
          startLatitude,
          startLongitude,
          endLatitude,
          endLongitude,
        ) /
        1000;
  }
}
