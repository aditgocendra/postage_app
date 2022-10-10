import 'package:check_postage_app/app/data/models/city_model.dart';
import 'package:check_postage_app/app/data/models/courier_service_model.dart';
import 'package:check_postage_app/app/data/models/province_model.dart';
import 'package:either_dart/either.dart';
import '../../core/error/failure.dart';

abstract class PostageRepository {
  Future<Either<Failure, List<ProvinceModel>>> getProvinces();
  Future<Either<Failure, List<CityModel>>> getCity(String idProv);
  Future<Either<Failure, List<CourierServiceModel>>> getPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  );
}
