import './rating_model.dart';

class ProductModal {

  String? title;
  double? price;
  String? image;
  String? description;
  RatingModal? ratingModal;

  ProductModal({
    this.title,
    this.price,
    this.image,
    this.description,
    this.ratingModal,
  });

  factory ProductModal.fromJson(Map<String, dynamic>json) {
    return ProductModal(
      title: json['title'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
      ratingModal: RatingModal.fromJson(json['rating']),
    );
  }
}