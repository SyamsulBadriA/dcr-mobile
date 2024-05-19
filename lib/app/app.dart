import 'package:dcr_mobile/services/api_services.dart';
import 'package:dcr_mobile/services/api_user_location_services.dart';
import 'package:dcr_mobile/services/api_user_profile_services.dart';
import 'package:dcr_mobile/services/local_user_location_services.dart';
import 'package:dcr_mobile/services/local_user_profile_services.dart';
import 'package:dcr_mobile/services/map_services.dart';
import 'package:dcr_mobile/ui/home/check_location_view.dart';
import 'package:dcr_mobile/ui/home/home_screen_view.dart';
import 'package:dcr_mobile/ui/login/login_screen_view.dart';
import 'package:dcr_mobile/ui/checkpoint/checkpoint_view.dart';
import 'package:dcr_mobile/ui/startup_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: LoginScreenView),
    MaterialRoute(page: CheckPointView),
    MaterialRoute(page: CheckLocationView),
    MaterialRoute(page: HomeScreenView),
  ],
  dependencies: [
    LazySingleton(classType: ApiServices),
    LazySingleton(classType: ApiUserLocationServices),
    LazySingleton(classType: ApiUserProfileServices),
    LazySingleton(classType: LocalUserProfileServices),
    LazySingleton(classType: LocalUserLocationServices),
    LazySingleton(classType: MapServices),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
  ],
  logger: StackedLogger(),
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
