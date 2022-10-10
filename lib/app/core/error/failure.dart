enum AppError { notFound, noInternetConnection, badRequest, undefinedError }

class Failure {
  final AppError key;
  final String? message;

  Failure({required this.key, this.message});

  // Message Status
  static String badRequestMessage() =>
      "Yahh apa yang kamu cari belum ketemu nih, coba lagi nanti ya :)";

  static String noInternetConnectionMessage() =>
      "Yahh sepertinya koneksi kamu sedang tidak baik-baik saja!!";

  static String notFoundMessage() => "Yahh yang kamu cari gak ada nihh!!!";

  static String undefinedErrorMessage() => "Coba lagi nanti yaa!!!";
}
