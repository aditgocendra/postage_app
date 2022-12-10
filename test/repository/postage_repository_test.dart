import "package:check_postage_app/app/core/error/failure.dart";
import 'package:check_postage_app/app/data/models/city_model.dart';
import 'package:check_postage_app/app/data/models/courier_service_model.dart';
import 'package:check_postage_app/app/data/models/province_model.dart';
import 'package:check_postage_app/app/data/remote/postage_remote_data.dart';
import 'package:check_postage_app/app/data/repositories/postage_repository.dart';
import 'package:check_postage_app/app/data/repositories/postage_repository_impl.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'postage_repository_test.mocks.dart';

class PostageRemoteDataTest extends Mock implements PostageRemoteData {}

@GenerateNiceMocks([MockSpec<PostageRemoteDataTest>()])
void main() {
  late MockPostageRemoteDataTest mockPostageRemoteDataTest;
  late PostageRepository postageRepository;

  setUp(() {
    mockPostageRemoteDataTest = MockPostageRemoteDataTest();
    postageRepository =
        PostageRepositoryImpl(postageRemoteData: mockPostageRemoteDataTest);
  });

  group("test postage repository get province", () {
    final body = {
      "rajaongkir": {
        "query": {"id": "12"},
        "status": {"code": 200, "description": "OK"},
        "results": [
          {"province_id": "12", "province": "Kalimantan Barat"}
        ]
      }
    };
    test("success", () async {
      when(mockPostageRemoteDataTest.getDataProvince()).thenAnswer(
        (_) async => Right(body),
      );

      final result = await postageRepository.getProvinces();

      expect(result.right, isA<List<ProvinceModel>>());
    });

    test("test no internet connection", () async {
      final fail = Failure(
        key: AppError.noInternetConnection,
        message: Failure.noInternetConnectionMessage(),
      );

      when(mockPostageRemoteDataTest.getDataProvince()).thenAnswer(
        (_) async => Left(fail),
      );

      final result = await postageRepository.getProvinces();

      expect(result.left, isA<Failure>());
    });

    test("test bad request", () async {
      final fail = Failure(
        key: AppError.badRequest,
        message: Failure.badRequestMessage(),
      );

      when(mockPostageRemoteDataTest.getDataProvince()).thenAnswer(
        (_) async => Left(fail),
      );

      final result = await postageRepository.getProvinces();

      expect(result.left, isA<Failure>());
    });

    test("test unknown error", () async {
      final fail = Failure(
        key: AppError.undefinedError,
        message: Failure.undefinedErrorMessage(),
      );

      when(mockPostageRemoteDataTest.getDataProvince()).thenAnswer(
        (_) async => Left(fail),
      );

      final result = await postageRepository.getProvinces();

      expect(result.left, isA<Failure>());
    });
  });

  group("test postage repository get city", () {
    const idProv = "2";

    final body = {
      "rajaongkir": {
        "query": {"province": "2"},
        "status": {"code": 200, "description": "OK"},
        "results": [
          {
            "city_id": "27",
            "province_id": "2",
            "province": "Bangka Belitung",
            "type": "Kabupaten",
            "city_name": "Bangka",
            "postal_code": "33212"
          }
        ]
      }
    };
    test('success', () async {
      when(mockPostageRemoteDataTest.getDataCity(idProv)).thenAnswer(
        (_) async => Right(body),
      );

      final result = await postageRepository.getCity(idProv);

      expect(result.right, isA<List<CityModel>>());
    });

    test("test no internet connection", () async {
      final fail = Failure(
        key: AppError.noInternetConnection,
        message: Failure.noInternetConnectionMessage(),
      );

      when(mockPostageRemoteDataTest.getDataCity(idProv)).thenAnswer(
        (_) async => Left(fail),
      );

      final result = await postageRepository.getCity(idProv);

      expect(result.left, isA<Failure>());
    });

    test("test bad request", () async {
      final fail = Failure(
        key: AppError.badRequest,
        message: Failure.badRequestMessage(),
      );

      when(mockPostageRemoteDataTest.getDataCity(idProv)).thenAnswer(
        (_) async => Left(fail),
      );

      final result = await postageRepository.getCity(idProv);

      expect(result.left, isA<Failure>());
    });

    test("test unknown error", () async {
      final fail = Failure(
        key: AppError.undefinedError,
        message: Failure.undefinedErrorMessage(),
      );

      when(mockPostageRemoteDataTest.getDataCity(idProv)).thenAnswer(
        (_) async => Left(fail),
      );

      final result = await postageRepository.getCity(idProv);

      expect(result.left, isA<Failure>());
    });
  });

  group('test postage repository get postage', () {
    final body = {
      "rajaongkir": {
        "query": {
          "origin": "501",
          "destination": "114",
          "weight": 1700,
          "courier": "jne"
        },
        "status": {"code": 200, "description": "OK"},
        "origin_details": {
          "city_id": "501",
          "province_id": "5",
          "province": "DI Yogyakarta",
          "type": "Kota",
          "city_name": "Yogyakarta",
          "postal_code": "55000"
        },
        "destination_details": {
          "city_id": "114",
          "province_id": "1",
          "province": "Bali",
          "type": "Kota",
          "city_name": "Denpasar",
          "postal_code": "80000"
        },
        "results": [
          {
            "code": "jne",
            "name": "Jalur Nugraha Ekakurir (JNE)",
            "costs": [
              {
                "service": "OKE",
                "description": "Ongkos Kirim Ekonomis",
                "cost": [
                  {"value": 38000, "etd": "4-5", "note": ""}
                ]
              },
              {
                "service": "REG",
                "description": "Layanan Reguler",
                "cost": [
                  {"value": 44000, "etd": "2-3", "note": ""}
                ]
              },
              {
                "service": "SPS",
                "description": "Super Speed",
                "cost": [
                  {"value": 349000, "etd": "", "note": ""}
                ]
              },
              {
                "service": "YES",
                "description": "Yakin Esok Sampai",
                "cost": [
                  {"value": 98000, "etd": "1-1", "note": ""}
                ]
              }
            ]
          }
        ]
      }
    };

    test('test success', () async {
      when(mockPostageRemoteDataTest.getDataPostage(
        "501",
        "114",
        "1700",
        "jne",
      )).thenAnswer(
        (realInvocation) async => Right(body),
      );

      final result = await postageRepository.getPostage(
        "501",
        "114",
        "1700",
        "jne",
      );

      expect(result.right, isA<List<CourierServiceModel>>());
    });

    test("test no internet connection", () async {
      final fail = Failure(
        key: AppError.noInternetConnection,
        message: Failure.noInternetConnectionMessage(),
      );

      when(mockPostageRemoteDataTest.getDataPostage(
        "501",
        "114",
        "1700",
        "jne",
      )).thenAnswer(
        (realInvocation) async => Left(fail),
      );

      final result = await postageRepository.getPostage(
        "501",
        "114",
        "1700",
        "jne",
      );

      expect(result.left, isA<Failure>());
    });

    test("test bad request", () async {
      final fail = Failure(
        key: AppError.badRequest,
        message: Failure.badRequestMessage(),
      );

      when(mockPostageRemoteDataTest.getDataPostage(
        "501",
        "114",
        "1700",
        "jne",
      )).thenAnswer(
        (realInvocation) async => Left(fail),
      );

      final result = await postageRepository.getPostage(
        "501",
        "114",
        "1700",
        "jne",
      );

      expect(result.left, isA<Failure>());
    });

    test("test unknown error", () async {
      final fail = Failure(
        key: AppError.undefinedError,
        message: Failure.undefinedErrorMessage(),
      );

      when(mockPostageRemoteDataTest.getDataPostage(
        "501",
        "114",
        "1700",
        "jne",
      )).thenAnswer(
        (realInvocation) async => Left(fail),
      );

      final result = await postageRepository.getPostage(
        "501",
        "114",
        "1700",
        "jne",
      );

      expect(result.left, isA<Failure>());
    });
  });
}
