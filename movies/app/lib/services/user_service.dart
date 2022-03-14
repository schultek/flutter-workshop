class UserService {
  static UserService instance = UserService();

  String _username = 'me';
  String get username => _username;

  void setUsername(String username) {
    _username = username;
  }
}
