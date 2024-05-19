import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/app/app.logger.dart';
import 'package:dcr_mobile/app/app.router.dart';
import 'package:dcr_mobile/dto/checkpoint_user_request.dart';
import 'package:dcr_mobile/services/api_user_location_services.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CheckPointViewModel extends ReactiveViewModel {
  final log = getLogger("HomeScreenViewModel");

  final apiServiceLocation = locator<ApiUserLocationServices>();
  final _navServices = locator<NavigationService>();
  final checkPointNameController = TextEditingController();
  final categoryController = TextEditingController();
  final userIdController = TextEditingController();

  Future<void> submitCheckpointUserLocation() async {
    try {
      setBusy(true);
      final ok = await apiServiceLocation.submitCheckpointUserLocation(
          CheckPointUserRequest(
              userId: userIdController.text,
              category: categoryController.text,
              checkpointName: checkPointNameController.text));
      if (ok) {
        await _navServices.navigateToLoginScreenView();
      }
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }
}
