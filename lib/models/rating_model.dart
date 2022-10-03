class RatingModal {
  double? rate;
 
  RatingModal({this.rate});

  factory RatingModal.fromJson(Map<String, dynamic>json) {
    
    return RatingModal(
      rate: json['rate'].toDouble(),
    );
  }
}