enum AppError { notFound, badRequest }

class ErrorModel {
  final AppError key;
  final String? message;

  ErrorModel({required this.key, this.message});
}
