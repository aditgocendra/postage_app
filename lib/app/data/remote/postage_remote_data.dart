import 'package:check_postage_app/app/core/error/failure.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart';

abstract class PostageRemoteDataSource {
  Future<Either<Failure, Response>> getDataProvince();
  Future<Either<Failure, Response>> getDataCity(String idProv);
  Future<Either<Failure, Response>> getDataPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  );
}
