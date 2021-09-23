class HomeModel {
  late bool status;
  late HomeDataModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    print('HomeModel.fromJson: ${json['data']}');
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((banner) {
      banners.add(BannerModel.fromJson(banner));
    });
    json['products'].forEach((product) {
      products.add(ProductModel.fromJson(product));
    });
  }
}

class BannerModel {
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      image = json['image'];
    }
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductModel.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      id = json['id'];
      price = json['price'];
      oldPrice = json['old_priced'];
      discount = json['discount'];
      image = json['image'];
      name = json['name'];
      inFavorites = json['in_favorites'];
      inCart = json['in_cart'];
    }
  }
}
