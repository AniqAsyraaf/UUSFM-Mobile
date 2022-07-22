class User {
  String
      _id; // Use dynamic type because json-server id is int and firestore id is string
  String _cName;
  String _cEmail;
  String _cPassword;
  String _cPhoneNum;
  String _cRole;
  String _cVerifyStatus;
  String _created_at;
  String _updated_at;

  get id => _id;
  set id(value) => _id = value;

  get cName => _cName;
  set cName(value) => _cName = value;

  get cEmail => _cEmail;
  set cEmail(value) => _cEmail = value;

  get cPassword => _cPassword;
  set cPassword(value) => _cPassword = value;

  get cPhoneNum => _cPhoneNum;
  set cPhoneNum(value) => _cPhoneNum = value;

  get cRole => _cRole;
  set cRole(value) => _cRole = value;

  get cVerifyStatus => _cVerifyStatus;
  set cVerifyStatus(value) => _cVerifyStatus = value;

  get created_at => _created_at;
  set created_at(value) => _created_at = value;

  get updated_at => _updated_at;
  set updated_at(value) => _updated_at = value;

  User({
    dynamic id,
    String cName = '',
    String cEmail = '',
    String cPassword = '',
    String cPhoneNum = '',
    String cRole = '',
    String cVerifyStatus = '',
    String created_at = null,
    String updated_at = null,
  })  : _id = id,
        _cName = cName,
        _cEmail = cEmail,
        _cPassword = cPassword,
        _cPhoneNum = cPhoneNum,
        _cRole = cRole,
        _cVerifyStatus = cVerifyStatus,
        _created_at = created_at,
        _updated_at = updated_at;

  User.copy(User from)
      : this(
          id: from.id,
          cName: from.cName,
          cEmail: from.cEmail,
          cPassword: from.cPassword,
          cPhoneNum: from._cPhoneNum,
          cRole: from.cRole,
          cVerifyStatus: from.cVerifyStatus,
          created_at: from.created_at,
          updated_at: from.updated_at,
        );

  User.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          cName: json['cName'],
          cEmail: json['cEmail'],
          cPassword: json['cPassword'],
          cPhoneNum: json['cPhoneNum'],
          cRole: json['cRole'],
          cVerifyStatus: json['cVerifyStatus'],
          created_at: json['created_at'],
          updated_at: json['updated_at'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cName': cName,
        'cEmail': cEmail,
        'cPassword': cPassword,
        'cPhoneNum': cPhoneNum,
        'cRole': cRole,
        'cVerifyStatus': cVerifyStatus,
        'created_at': created_at,
        'updated_at': updated_at,
      };
}
