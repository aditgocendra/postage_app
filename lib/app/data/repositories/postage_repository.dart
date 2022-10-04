import 'package:check_postage_app/app/data/models/city_model.dart';
import 'package:check_postage_app/app/data/models/courier_service_model.dart';
import 'package:check_postage_app/app/data/models/province_model.dart';
import 'package:either_dart/either.dart';
import '../../core/error/error_model.dart';

abstract class PostageRepository {
  Future<Either<ErrorModel, List<ProvinceModel>>> getProvinces();
  Future<Either<ErrorModel, List<CityModel>>> getCity(String idProv);
  Future<Either<ErrorModel, List<CourierServiceModel>>> getPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  );
}
