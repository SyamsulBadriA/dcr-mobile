import 'package:dio/dio.dart';
import '../app/app.logger.dart';

const baseUrl = "https://dev.diengcalderarace.com/api";
const savedId = "idUser";

/// ApiRootService is used to initialize dio http client in ApiService
class ApiServices {
  final log = getLogger('ApiService');

  Dio dio = Dio();
  Future<void> initializeDio() async {
    log.v('====== DIO STARTED initialising ======');

    Map<String, dynamic> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    dio.options.baseUrl = baseUrl;
    dio.options.headers = headers;

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Do something before request is sent
      log.v('REQUEST[${options.method}] => PATH: $baseUrl${options.path}');
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioException e, handler) {
      return handler.next(e); //continue
    }));

    log.v('====== DIO ENDED initialising ======');
  }
}
