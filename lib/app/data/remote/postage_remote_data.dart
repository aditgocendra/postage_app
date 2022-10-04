import 'package:check_postage_app/app/core/error/error_model.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart';

abstract class PostageRemoteDataSource {
  Future<Either<ErrorModel, Response>> getDataProvince();
  Future<Either<ErrorModel, Response>> getDataCity(String idProv);
  Future<Either<ErrorModel, Response>> getDataPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  );
}
