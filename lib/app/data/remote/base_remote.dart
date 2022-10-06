import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../core/error/error_model.dart';
import '../../core/keys/api_key.dart';

abstract class BaseRemote {
  Future<Either<ErrorModel, http.Response>> getRequest(String endPoint) async {
    final response = await http.get(
      Uri.parse(endPoint),
      headers: {"key": apiKeyRajaOngkir},
    );

    switch (response.statusCode) {
      case 200:
        return Right(response);
      default:
        return Left(
          ErrorModel(
            key: AppError.badRequest,
            message: "Bad Request",
          ),
        );
    }
  }

  Future<Either<ErrorModel, http.Response>> postRequest(
    String endPoint,
    Object body,
  ) async {
    final response = await http.post(
      Uri.parse(endPoint),
      headers: {
        "key": apiKeyRajaOngkir,
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: body,
    );

    switch (response.statusCode) {
      case 200:
        return Right(response);
      default:
        return Left(
          ErrorModel(
            key: AppError.badRequest,
            message: "Bad Request",
          ),
        );
    }
  }
}
