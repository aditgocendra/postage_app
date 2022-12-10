import 'dart:io';
import '../../core/error/error_handler.dart';
import '../../core/error/failure.dart';
import '../../core/utils/api_utils.dart';
import 'postage_remote_data.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';

class PostageRemoteDataImpl extends GetConnect
    with HandlerRequestException
    implements PostageRemoteData {
  @override
  Future<Either<Failure, dynamic>> getDataProvince() async {
    Response? response;

    try {
      response = await get("${endpointRajaongkirAPI}province", headers: {
        "key": apiKeyRajaOngkir!,
      });

      return Right(response.body);
    } on SocketException {
      return Left(
        handleErrorConnection(),
      );
    } catch (_) {
      Failure err = handleErrorRequest(
        response!.statusCode!,
      );
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, dynamic>> getDataCity(String idProv) async {
    Response? response;

    try {
      response =
          await get("${endpointRajaongkirAPI}city?province=$idProv", headers: {
        "key": apiKeyRajaOngkir!,
      });

      // Return body
      return Right(response.body);
    } on SocketException {
      return Left(
        handleErrorConnection(),
      );
    } catch (_) {
      Failure err = handleErrorRequest(
        response!.statusCode!,
      );
      return Left(err);
    }
  }

  @override
  Future<Either<Failure, dynamic>> getDataPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  ) async {
    var reqBody = {
      "origin": origin,
      "destination": destination,
      "weight": weight,
      "courier": courier
    };

    Response? response;

    try {
      response = await post("${endpointRajaongkirAPI}cost", reqBody, headers: {
        "key": apiKeyRajaOngkir!,
      });

      return Right(response.body);
    } on SocketException {
      return Left(
        handleErrorConnection(),
      );
    } catch (_) {
      Failure err = handleErrorRequest(
        response!.statusCode!,
      );
      return Left(err);
    }
  }
}
