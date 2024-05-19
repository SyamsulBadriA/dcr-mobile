import 'package:dcr_mobile/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

const String boxNameUserLocation = "userLocation";

class LocalUserLocationServices with ListenableServiceMixin {
  final _users = ReactiveValue<List<UserLocation>>(
    Hive.box(boxNameUserLocation)
        .get(boxNameUserLocation, defaultValue: []).cast<UserLocation>(),
  );

  List<UserLocation> get usersLocations => _users.value;

  LocalUserLocationServices() {
    listenToReactiveValues([_users]);
  }

  void _saveToHive() =>
      Hive.box(boxNameUserLocation).put(boxNameUserLocation, _users.value);

  void newUser(UserLocation userLocation) {
    _users.value.insert(0, userLocation);
    _saveToHive();
    notifyListeners();
  }

  bool removeUser(String idUser) {
    final index = _users.value.indexWhere((user) => user.idUser == idUser);
    if (index != -1) {
      _users.value.removeAt(index);
      _saveToHive();
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  UserLocation? getDetailUserLocation(String idUser) {
    final index = _users.value.indexWhere((user) => user.idUser == idUser);

    if (index == -1) {
      return null;
    }
    return _users.value[index];
  }
}
