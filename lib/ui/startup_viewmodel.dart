import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/app/app.router.dart';
import 'package:dcr_mobile/services/api_services.dart';
import 'package:dcr_mobile/services/local_user_profile_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../app/app.logger.dart';

class StartupViewModel extends ReactiveViewModel {
  final log = getLogger("StartupViewModel");
  final _hiveServiceUser = locator<LocalUserProfileServices>();
  final _navService = locator<NavigationService>();
  final _apiService = locator<ApiServices>();

  bool _startAnimation = true;
  bool get startAnimation => _startAnimation;

  Future<void> runStartupLogic() async {
    log.i('===== runStartupLogic() STARTED =====');

    await Future.delayed(const Duration(milliseconds: 2500)).then((value) {
      _startAnimation = false;
      notifyListeners();
    });

    log.i('===== runStartupLogic() ENDED =====');
  }

  Future<void> checkLoggedIn() async {
    await _apiService.initializeDio();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final savedIdUser = prefs.getString(savedId);
    log.v('ApiService _savedIdUser: $savedIdUser');

    if (savedIdUser == null) {
      await _navService.pushNamedAndRemoveUntil(Routes.loginScreenView);
      return;
    }

    final user = _hiveServiceUser.getDetailUser(savedIdUser);
    if (user == null) {
      await _navService.pushNamedAndRemoveUntil(Routes.loginScreenView);
      return;
    }

    await _navService.pushNamedAndRemoveUntil(Routes.checkLocationView);
  }
}
