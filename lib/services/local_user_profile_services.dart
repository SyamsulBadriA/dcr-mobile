import 'package:dcr_mobile/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

const String boxNameUser = "user";
const String boxNameUsers = "users";

class LocalUserProfileServices with ListenableServiceMixin {
  final _users = ReactiveValue<List<UserProfile>>(
    Hive.box(boxNameUser)
        .get(boxNameUser, defaultValue: []).cast<UserProfile>(),
  );

  List<UserProfile> get users => _users.value;

  LocalUserProfileServices() {
    listenToReactiveValues([_users]);
  }

  void _saveToHive() => Hive.box(boxNameUser).put(boxNameUser, _users.value);

  void newUser(UserProfile userProfile) {
    _users.value.insert(0, userProfile);
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

  UserProfile? getDetailUser(String idUser) {
    final index = _users.value.indexWhere((user) => user.idUser == idUser);
    if (index == -1) {
      return null;
    }
    return _users.value[index];
  }
}
