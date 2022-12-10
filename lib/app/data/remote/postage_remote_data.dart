import 'package:either_dart/either.dart';

import '../../core/error/failure.dart';

abstract class PostageRemoteData {
  Future<Either<Failure, dynamic>> getDataProvince();
  Future<Either<Failure, dynamic>> getDataCity(String idProv);
  Future<Either<Failure, dynamic>> getDataPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  );
}
