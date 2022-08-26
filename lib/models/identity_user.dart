import 'package:freezed_annotation/freezed_annotation.dart';

part 'identity_user.freezed.dart';
part 'identity_user.g.dart';

@freezed
class IdentityUser with _$IdentityUser {
  const factory IdentityUser({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    bool? emailConfirmed,
    required String username,
    String? phoneNumber,
    bool? phoneNumberConfirmed,
    bool? twoFactorEnabled,
    DateTime? lockoutEnd,
    bool? lockoutEnabled,
  }) = _IdentityUser;

  factory IdentityUser.fromJson(Map<String, Object?> json) =>
      _$IdentityUserFromJson(json);
}
