class FavoritesModel {
  late bool status;
  late String message;

  FavoritesModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      status = json['status'];
      message = json['message'];
    }
  }
}
