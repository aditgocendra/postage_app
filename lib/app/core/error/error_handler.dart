import 'dart:io';

import 'failure.dart';

abstract class HandlerRequestException {
  // Handle Error Request
  Failure handleErrorRequest(int statusCode) {
    switch (statusCode) {
      case 401:
        return Failure(
          key: AppError.badRequest,
          message: Failure.badRequestMessage(),
        );
      case 404:
        return Failure(
          key: AppError.notFound,
          message: Failure.notFoundMessage(),
        );
      default:
        return Failure(
          key: AppError.undefinedError,
          message: Failure.undefinedErrorMessage(),
        );
    }
  }

  Failure handleErrorConnection() {
    return Failure(
      key: AppError.noInternetConnection,
      message: Failure.noInternetConnectionMessage(),
    );
  }
}
