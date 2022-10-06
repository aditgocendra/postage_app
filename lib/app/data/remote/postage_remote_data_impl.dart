import 'package:check_postage_app/app/core/error/error_model.dart';
import 'package:check_postage_app/app/data/remote/base_remote.dart';
import 'package:check_postage_app/app/data/remote/postage_remote_data.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;

class PostageRemoteDataImpl extends BaseRemote
    implements PostageRemoteDataSource {
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
