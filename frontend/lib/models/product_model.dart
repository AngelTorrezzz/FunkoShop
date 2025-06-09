class ProductModel {
  int id;
  String name;
  double price;
  String club;
  int quantity;
  String imageURL;
  int isFavorite = 0;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.club,
    required this.quantity,
    required this.imageURL,
    required this.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      club: json['club'],
      quantity: json['quantity'],
      imageURL: json['imageURL'],
      isFavorite: json['isFavorite'] ?? 0,
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
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, price: $price, club: $club, quantity: $quantity, imageURL: $imageURL, isFavorite: $isFavorite}';
  }

}