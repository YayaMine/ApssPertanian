class User {
  final int? id;
  final String email;
  final String username;
  final String phone;
  final String password;

  User({
    this.id,
    required this.email,
    required this.username,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'phone': phone,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      phone: map['phone'],
      password: map['password'],
    );
  }
}
