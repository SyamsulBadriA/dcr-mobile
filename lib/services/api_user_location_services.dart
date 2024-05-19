import 'package:dcr_mobile/app/app.locator.dart';
import 'package:dcr_mobile/app/app.logger.dart';
import 'package:dcr_mobile/dto/checkpoint_user_request.dart';
import 'package:dcr_mobile/dto/user_location_request.dart';
import 'package:dcr_mobile/dto/user_location_response.dart';
import 'package:dcr_mobile/models/user.dart';
import 'package:dcr_mobile/services/api_services.dart';
import 'package:dio/dio.dart';

class ApiUserLocationServices {
  final log = getLogger('ApiUserLocationServices');

  final apiService = locator<ApiServices>();

  Future<bool> submitUserLocation(UserLocationRequest req) async {
    try {
      Response res = await apiService.dio.post("/submit", data: req.toJson());
      log.v("RESPONSE: /submit => ${res.data}");

      if (res.data != null && res.statusCode == 200) {
        return true;
      }

      log.v("SUCCESS SUBMIT LOCATION ${res.data}");
      return false;
    } on DioException catch (e) {
      log.v("ERROR on submit location : ${e.response}");
      throw e.response?.data;
    }
  }

  Future<bool> submitCheckpointUserLocation(CheckPointUserRequest req) async {
    try {
      Response res = await apiService.dio.post("/checkpoints", data: req.toJson());
      log.v("RESPONSE: /checkpoints => ${res.data}");

      if (res.data != null && res.statusCode == 200) {
        return true;
      }

      log.v("SUCCESS SUBMIT checkpoints ${res.data}");
      return false;
    } on DioException catch (e) {
      log.v("ERROR on submit checkpoints : ${e.response}");
      throw e.response?.data;
    }
  }

  Future<List<UserLocation>> getUserLocations(String category) async {
    try {
      Response res = await apiService.dio.get("/locations?category=$category");
      log.v("RESPONSE: /locations => ${res.data}");

      if (res.data != null && res.statusCode == 200) {
        var dataRes = BaseUserLocationResponse.fromJson(res.data);
        return dataRes.toEntity();
      }
      return [];
    } on DioException catch (e) {
      log.v("ERROR on get location : ${e.response}");
      throw e.response?.data;
    }
  }
}
