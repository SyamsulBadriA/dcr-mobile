import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/app/app.router.dart';
import 'package:dcr_mobile/dto/login_request.dart';
import 'package:dcr_mobile/services/api_services.dart';
import 'package:dcr_mobile/services/api_user_profile_services.dart';
import 'package:dcr_mobile/services/local_user_profile_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app.logger.dart';

class LoginScreenViewModel extends ReactiveViewModel {
  final log = getLogger("LoginScreenViewModel");
  final apiServiceUser = locator<ApiUserProfileServices>();
  final _navService = locator<NavigationService>();
  final _hiveService = locator<LocalUserProfileServices>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isHidePassword = false;
  bool get isHidePassword => _isHidePassword;

  Future<void> login(LoginRequest req) async {
    try {
      if (usernameController.text.isEmpty && passwordController.text.isEmpty) {
        return;
      }
      setBusy(true);
      usernameController.text = "";
      passwordController.text = "";
      final user = await apiServiceUser.loginUser(req);

      if (user?.idUser != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final ok = await prefs.setString(savedId, user?.idUser ?? "");
        _hiveService.newUser(user!);
        if (ok) {
          _navService.pushNamedAndRemoveUntil(Routes.homeScreenView);
        }
      }
    } catch (e) {
      setError(e);
    } finally {
      setBusy(false);
    }
  }

  Future<void> navigateCheckPoint() async {
    await _navService.pushNamedAndRemoveUntil(Routes.checkPoint);

}

  void showHidePassword() {
    _isHidePassword = !_isHidePassword;
    notifyListeners();
  }

  Future<void> register() async {
    final Uri url = Uri.parse('https://diengcalderarace.com/register');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> forgotPassword() async {
    final Uri url = Uri.parse('https://diengcalderarace.com/forget_password');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
