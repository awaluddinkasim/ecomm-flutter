class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? pict;

  User({name, email, phone, pict});

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        name = json['name'],
        email = json['email'],
        phone = json['phone'].toString(),
        pict = json['pict'];
}
