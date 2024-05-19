import 'package:dcr_mobile/models/user.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse {
  UserProfileResponse({
    this.idRegistration,
    this.idUser,
    this.idCategory,
    this.nameBib,
    this.namaCategory,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
  });

  @JsonKey(name: "id_registration")
  final String? idRegistration;

  @JsonKey(name: "id_user")
  final String? idUser;

  @JsonKey(name: "id_category")
  final String? idCategory;

  @JsonKey(name: "name_bib")
  final String? nameBib;

  @JsonKey(name: "name_category")
  final String? namaCategory;

  @JsonKey(name: "first_name")
  final String? firstName;

  @JsonKey(name: "last_name")
  final String? lastName;

  final String? email;
  final String? username;
  final String? phone;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class BaseUserProfileResponse {
  BaseUserProfileResponse({this.status, this.message, this.data});

  final String? status;
  final String? message;
  final UserProfileResponse? data;

  factory BaseUserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseUserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseUserProfileResponseToJson(this);

  UserProfile toEntity() {
    final fullname = "${data?.firstName ?? ""} ${data?.lastName ?? ""}";

    return UserProfile(
      idRegistration: data?.idRegistration ?? "",
      idCategory: data?.idCategory ?? "",
      idUser: data?.idUser ?? "",
      nameBib: data?.nameBib ?? "",
      fullname: fullname,
      email: data?.email ?? "",
      phoneNumber: data?.phone ?? "",
      username: data?.username ?? "",
    );
  }
}
