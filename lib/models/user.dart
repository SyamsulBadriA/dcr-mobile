class UserProfile {
  final String idRegistration;
  final String idCategory;
  final String idUser;
  final String nameBib;
  final String fullname;
  final String email;
  final String phoneNumber;
  final String username;

  UserProfile(
      {required this.idRegistration,
      required this.idCategory,
      required this.idUser,
      required this.nameBib,
      required this.fullname,
      required this.email,
      required this.phoneNumber,
      required this.username});
}

class UserLocation {
  final String idUser;
  final double latitude;
  final double longitude;
  final double altitude;

  UserLocation(
      {required this.idUser,
      required this.latitude,
      required this.longitude,
      required this.altitude});
}
