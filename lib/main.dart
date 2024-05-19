import 'dart:async';
import 'dart:developer';

import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/dcr_app.dart';
import 'package:dcr_mobile/models/user.adapter.dart';
import 'package:dcr_mobile/models/user.dart';
import 'package:dcr_mobile/services/local_user_location_services.dart';
import 'package:dcr_mobile/services/local_user_profile_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    Hive.registerAdapter<UserProfile>(UserProfileAdapter());
    Hive.registerAdapter<UserLocation>(UserLocationAdapter());
    await Hive.openBox(boxNameUser);
    await Hive.openBox(boxNameUserLocation);
    await setupLocator();

    return SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) => runApp(const DCRApp()));
  }, (error, stack) {
    log(error.toString());
    log(stack.toString());
  });
}
