import 'dart:convert';
import 'package:check_postage_app/app/data/models/city_model.dart';
import 'package:check_postage_app/app/data/models/courier_service_model.dart';
import 'package:check_postage_app/app/data/models/province_model.dart';
import 'package:check_postage_app/app/data/remote/postage_remote_data.dart';
import 'package:check_postage_app/app/data/repositories/postage_repository.dart';
import 'package:either_dart/either.dart';
import 'package:get/get.dart';
import '../../core/error/error_model.dart';

class PostageRepositoryImpl implements PostageRepository {
  final remoteSourceData = Get.find<PostageRemoteDataSource>();

  @override
  Future<Either<ErrorModel, List<ProvinceModel>>> getProvinces() async {
    List<ProvinceModel> province = [];
    // Get data province
    final value = await remoteSourceData.getDataProvince();

    // Return Request Failed
    if (value.isLeft) {
      return Left(value.left);
    }

    // Return Request Success
    var res = value.right;
    province = ProvinceModel.fromJsonList(
        jsonDecode(res.body)["rajaongkir"]["results"]);

    return Right(province);
  }

  @override
  Future<Either<ErrorModel, List<CityModel>>> getCity(String idProv) async {
    List<CityModel> city = [];
    // Get data province
    final value = await remoteSourceData.getDataCity(idProv);

    // Return Request Failed
    if (value.isLeft) {
      return Left(value.left);
    }

    // Return Request Success
    var res = value.right;
    city =
        CityModel.fromJsonList(jsonDecode(res.body)["rajaongkir"]["results"]);

    return Right(city);
  }

  @override
  Future<Either<ErrorModel, List<CourierServiceModel>>> getPostage(
    String origin,
    String destination,
    String weight,
    String courier,
  ) async {
    final value = await remoteSourceData.getDataPostage(
      origin,
      destination,
      weight,
      courier,
    );

    // Return Request Failed
    if (value.isLeft) {
      return Left(value.left);
    }

    // // Return Request Success
    var res = value.right;
    var result = jsonDecode(res.body)['rajaongkir']['results'][0]['costs'];
    return Right(CourierServiceModel.fromJsonList(result));
  }
}
