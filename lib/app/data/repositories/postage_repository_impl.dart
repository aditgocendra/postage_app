import "package:either_dart/either.dart";
import '../../core/error/failure.dart';
import '../models/city_model.dart';
import '../models/courier_service_model.dart';
import '../models/province_model.dart';
import '../remote/postage_remote_data.dart';
import 'postage_repository.dart';

class PostageRepositoryImpl implements PostageRepository {
  PostageRemoteData postageRemoteData;

  PostageRepositoryImpl({
    required this.postageRemoteData,
  });

  @override
  Future<Either<Failure, List<ProvinceModel>>> getProvinces() async {
    // Get data province
    final result = await postageRemoteData.getDataProvince();

    // Return Request Failed
    if (result.isLeft) {
      return Left(result.left);
    }

    // Return Request Success
    return Right(ProvinceModel.fromJsonList(
      result.right["rajaongkir"]["results"],
    ));
  }

  @override
  Future<Either<Failure, List<CityModel>>> getCity(String idProv) async {
    // Get data province
    final result = await postageRemoteData.getDataCity(idProv);

    // Return Request Failed
    if (result.isLeft) {
      return Left(result.left);
    }

    // Return Request Success
    return Right(CityModel.fromJsonList(
      result.right["rajaongkir"]["results"],
    ));
  }

  @override
  Future<Either<Failure, List<CourierServiceModel>>> getPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  ) async {
    final result = await postageRemoteData.getDataPostage(
      origin,
      destination,
      weight,
      courier,
    );

    // Return Request Failed
    if (result.isLeft) {
      return Left(result.left);
    }

    // // Return Request Success
    return Right(
      CourierServiceModel.fromJsonList(
        result.right['rajaongkir']['results'][0]['costs'],
      ),
    );
  }
}
