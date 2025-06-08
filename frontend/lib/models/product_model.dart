class ProductModel {
  int id;
  String name;
  double price;
  String club;
  int quantity;
  String imageURL;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.club,
    required this.quantity,
    required this.imageURL,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      club: json['club'],
      quantity: json['quantity'],
      imageURL: json['imageURL'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'club': club,
      'quantity': quantity,
      'imageURL': imageURL,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, price: $price, club: $club, quantity: $quantity, imageURL: $imageURL}';
  }

}