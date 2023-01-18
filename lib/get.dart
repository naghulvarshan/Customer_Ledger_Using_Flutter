class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String website;
  final String address;
  final String company;
  final String phone;
  User(this.id, this.name, this.username, this.email, this.website,
      this.address, this.company, this.phone);
  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        json['id'] ?? "FNAME",
        json['name'] ?? "LNAME",
        json['username'] ?? "UNAME",
        json['email'] ?? "@",
        json['website'] ?? "@",
        json['address']['street'] ?? "@",
        json['company']['name'] ?? "@",
        json['phone'] ?? "0");
  }
}
