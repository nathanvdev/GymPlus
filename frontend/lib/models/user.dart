class User{
  final int memberId;
  final String username;
  final String password;
  final String rol;
  final String employmentStatus;
  final String dateOfEmployment;
  final String createdAt;
  final String updatedAt;

  User({
    this.memberId = 0,
    required this.username,
    required this.password,
    this.rol = "",
    this.employmentStatus = "",
    this.dateOfEmployment = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  get id => null;

  static User fromJson(data) {
    return User(
      memberId: data['member_id'],
      username: data['username'],
      password: data['password'],
      rol: data['rol'],
      employmentStatus: data['employment_status'],
      dateOfEmployment: data['date_of_employment'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }
}