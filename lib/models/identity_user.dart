class IdentityUser {
  String Firstname;
  String Lastname;
  String Email;
  bool? EmailConfirmed;
  String Username;
  String? PhoneNumber;
  bool? PhoneNumberConfirmed;
  bool? TwoFactorEnabled;
  DateTime? LockoutEnd;
  bool? LockoutEnabled;
  IdentityUser(
      {required this.Firstname,
      required this.Lastname,
      required this.Email,
      required this.Username});
}
