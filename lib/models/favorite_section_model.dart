class FavoritesSectionModel {
  late bool status;
  String? message;
  late Data data;

  FavoritesSectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }
}

class Data {
  late int currentPage;
  late List<FavoriteData> data = [];
  String? firstPageUrl;
  late int from;
  late int lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      currentPage = json['current_page'];
      json['data'].forEach((element) {
        data.add(FavoriteData.fromJson(element));
      });
      firstPageUrl = json['first_page_url'];
      from = json['from'];
      lastPage = json['last_page'];
      lastPageUrl = json['last_page_url'];
      nextPageUrl = json['next_page_url'];
      path = json['path'];
      perPage = json['per_page'];
      prevPageUrl = json['prev_page_url'];
      to = json['to'];
      total = json['total'];
    }
  }
}

class FavoriteData {
  late int id;
  late Product product;

  FavoriteData.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      product = Product.fromJson(json['product']);
    }
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late String description;

  Product.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      price = json['price'];
      oldPrice = json['old_price'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      description = json['description'];
    }
  }
}
