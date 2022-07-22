import 'package:uusfm/viewmodel/viewmodel.dart';

import '../model/user.dart';

class UserViewmodel extends Viewmodel {
  User _user;

  get user => _user;
  set user(value) => _user = value;
  bool get isUserSignedIn => _user != null;
}
