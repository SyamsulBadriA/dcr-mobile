import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/app/app.router.dart';
import 'package:dcr_mobile/services/map_services.dart';
import 'package:dcr_mobile/ui/home/check_location_view.dart';
import 'package:geolocator/geolocator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckLocationViewModel extends ReactiveViewModel {
  final _mapServices = locator<MapServices>();
  final _navServices = locator<NavigationService>();

  final lifecycleEventHandler = LifecycleEventHandler();

  Future<void> requestPermission() async {
    try {
      setBusy(true);
      final permission = await _mapServices.requestPermission();
      if (permission != LocationPermission.denied ||
          permission != LocationPermission.deniedForever) {
        _navServices.pushNamedAndRemoveUntil(Routes.homeScreenView);
      }
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
