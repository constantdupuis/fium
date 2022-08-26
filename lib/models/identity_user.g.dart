// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IdentityUser _$$_IdentityUserFromJson(Map<String, dynamic> json) =>
    _$_IdentityUser(
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      emailConfirmed: json['emailConfirmed'] as bool?,
      username: json['username'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      phoneNumberConfirmed: json['phoneNumberConfirmed'] as bool?,
      twoFactorEnabled: json['twoFactorEnabled'] as bool?,
      lockoutEnd: json['lockoutEnd'] == null
          ? null
          : DateTime.parse(json['lockoutEnd'] as String),
      lockoutEnabled: json['lockoutEnabled'] as bool?,
    );

Map<String, dynamic> _$$_IdentityUserToJson(_$_IdentityUser instance) =>
    <String, dynamic>{
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'email': instance.email,
      'password': instance.password,
      'emailConfirmed': instance.emailConfirmed,
      'username': instance.username,
      'phoneNumber': instance.phoneNumber,
      'phoneNumberConfirmed': instance.phoneNumberConfirmed,
      'twoFactorEnabled': instance.twoFactorEnabled,
      'lockoutEnd': instance.lockoutEnd?.toIso8601String(),
      'lockoutEnabled': instance.lockoutEnabled,
    };
