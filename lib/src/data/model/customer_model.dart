class Customer {
  String? id;
  String? profileImage;
  String? fullName;
  String? address;
  String? phoneNumber;
  String? email;

  Customer({
    required this.id,
    required this.profileImage,
    required this.fullName,
    required this.address,
    required this.phoneNumber,
    required this.email,
  });

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profileImage'];
    fullName = json['fullName'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }
}
