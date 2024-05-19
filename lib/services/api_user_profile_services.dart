import 'package:dcr_mobile/dto/login_request.dart';
import 'package:dcr_mobile/dto/login_response.dart';
import 'package:dcr_mobile/dto/user_profile_response.dart';
import 'package:dcr_mobile/models/user.dart';
import 'package:dcr_mobile/services/api_services.dart';
import 'package:dio/dio.dart';

import '../app/app.locator.dart';
import '../app/app.logger.dart';

class ApiUserProfileServices {
  final log = getLogger('ApiUserProfileServices');

  final apiService = locator<ApiServices>();

  Future<UserProfile?> loginUser(LoginRequest req) async {
    try {
      log.v("REQUEST: /login => ${req.toJson()}");
      Response res = await apiService.dio.post("/login", data: req.toJson());
      log.v("RESPONSE: /login => ${res.data}");

      if (res.data != null && res.statusCode == 200) {
        final data = LoginResponse.fromJson(res.data["data"]);
        log.v(data.idUser);
        final user = await getUserProfile(data.idUser ?? "");
        return user;
      }
      return null;
    } on DioException catch (e) {
      log.v("ERROR on login user profile : $e");
      throw e.response?.data;
    }
  }

  Future<UserProfile?> getUserProfile(String id) async {
    try {
      Response res = await apiService.dio.get("/profile/$id");
      log.v("RESPONSE: /profile => ${res.data}");

      if (res.data != null && res.statusCode == 200) {
        final data = BaseUserProfileResponse.fromJson(res.data);
        return data.toEntity();
      }
      return null;
    } on DioException catch (e) {
      log.v("ERROR on get user profile : ${e.response}");
      throw e.response?.data;
    }
  }
}
