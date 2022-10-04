import 'package:check_postage_app/app/core/error/error_model.dart';
import 'package:check_postage_app/app/data/remote/postage_remote_data.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import '../../core/keys/api_key.dart';

class PostageRemoteDataImpl implements PostageRemoteDataSource {
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

  @override
  Future<Either<ErrorModel, http.Response>> getDataProvince() async {
    return await getRequest("https://api.rajaongkir.com/starter/province");
  }

  @override
  Future<Either<ErrorModel, http.Response>> getDataCity(String idProv) async {
    return await getRequest(
      "https://api.rajaongkir.com/starter/city?province=$idProv",
    );
  }

  @override
  Future<Either<ErrorModel, http.Response>> getDataPostage(
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

    return await postRequest(
        "https://api.rajaongkir.com/starter/cost", reqBody);
  }
}
