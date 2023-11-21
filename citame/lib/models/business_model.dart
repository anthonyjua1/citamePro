class Business {
  final String businessName;
  final String category;
  final String email;
  final String contactNumber;
  final String direction;
  final String latitude;
  final String longitude;
  final String description;

  Business({
    required this.businessName,
    required this.category,
    required this.email,
    required this.contactNumber,
    required this.direction,
    required this.latitude,
    required this.longitude,
    required this.description,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessName: json['businessName'],
      category: json['category'],
      email: json['email'],
      contactNumber: json['contactNumber'],
      direction: json['direction'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
    );
  }
}