import 'dart:io';

import 'package:check_postage_app/app/core/error/error_handler.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

import '../../core/error/failure.dart';
import '../../core/keys/api_key.dart';

abstract class BaseRemote extends HandlerRequestException {
  Future<Either<Failure, http.Response>> getRequest(String endPoint) async {
    http.Response? response;
    try {
      response = await http.get(
        Uri.parse(endPoint),
        headers: {"key": apiKeyRajaOngkir!},
      );
      return Right(response);
    } on SocketException {
      return Left(handleErrorConnection());
    } catch (_) {
      Failure err = handleErrorRequest(response!.statusCode);
      return Left(err);
    }
  }

  Future<Either<Failure, http.Response>> postRequest(
    String endPoint,
    Object body,
  ) async {
    http.Response? response;
    try {
      response = await http.post(
        Uri.parse(endPoint),
        headers: {
          "key": apiKeyRajaOngkir!,
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body,
      );
      return Right(response);
    } on SocketException catch (_) {
      return Left(handleErrorConnection());
    } catch (_) {
      return Left(handleErrorRequest(response!.statusCode));
    }
  }
}
