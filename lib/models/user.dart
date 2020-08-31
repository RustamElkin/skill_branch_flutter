import 'package:FlutterGalleryApp/string_util.dart';

enum LoginType { email, phone }

class User with UserUtils {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  // User.__(String name) {
  //   this._lastName = name;
  // }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");

    bool hasPhone = phone != null && phone.isNotEmpty;
    bool hasEmail = email != null && email.isNotEmpty;
    // проверка телефона и email на не null, и не пустую строку,
    // если оба true тогда возвращают истину

    if (!hasPhone && !hasEmail) throw Exception('phone or email is empty');
    // если Phone или Email пустое, бросает Exception

    return User._(
        firstName: _getFirstname(name),
        lastName: _getLastname(name),
        phone: hasPhone ? checkPhone(phone) : "",
        email: hasEmail ? checkEmail(email) : "");
  }

  static String _getLastname(String userName) => userName.split(" ")[1];
  static String _getFirstname(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    if (phone == null || phone.isEmpty) {
      throw Exception(
          "Enter don't empty phone number"); // проверка на не пустой номер телефона

    } else {
      phone = phone.replaceAll(RegExp("[^+\\d]"), "");

      if (!RegExp(pattern).hasMatch(phone)) {
        throw Exception(
            "Enter a valid phone number starting with a + and containing 11 digits"); // проверка на то что начинается с +  содержит 11 цифр
      }
      return phone;
    }
  }

  static String checkEmail(String email) {
    String pattern =
        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";

    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    }

    if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Enter not correct email");
    }

    return email;
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";

/*
  @override
  bool operator == (Object object) {
    if (object == null) {
      return false;
    }
    if (object is User) {
      return _firstName == object._firstName && _lastName == object._lastName 
      && (phone == object.phone || email == object.email);
    }
  }
*/

  void addFriend(Iterable<User> newFriend) {
    friends.addAll(newFriend);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => '''
  name: $name
  email: $email
  firstName: $_firstName
  lastName: $_lastName
  friends: ${friends.toList()}
  ''';

  @override
  String toString() {
    return '''
  name: $name
  email: $email
  firstName: $_firstName
  lastName: $_lastName
  friends: ${friends.toList()}
  ''';
  }
}

mixin UserUtils {
  String capitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();
}
