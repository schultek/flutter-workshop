import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class UserService {
  final Map<String, String> _users = {
    'kilian': '1234', // test user
  };
  final _secretKey = SecretKey('secret passphrase');

  bool userExists(String username) {
    return _users[username] != null;
  }

  bool matchesPassword(String username, String password) {
    return _users[username] == password;
  }

  void registerUser(String username, String password) {
    _users[username] = password;
  }

  String createJWT(String username) {
    var jwt = JWT({}, subject: username, issuer: 'movies_backend');
    return jwt.sign(_secretKey);
  }

  bool validateJWT(String token) {
    token = token.startsWith('Bearer ') ? token.substring(7) : token;
    var jwt = JWT.verify(token, _secretKey);

    return jwt.subject != null && jwt.issuer == 'movies_backend';
  }
}
