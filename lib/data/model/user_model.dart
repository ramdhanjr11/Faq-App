// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:faq_app/domain/entities/user.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String? jenisUser;
  final String email;
  final String level;
  final String pathPhoto;
  final String accessToken;
  final String tokenType;
  final String expiresIn;
  final String nik;

  const UserModel({
    required this.id,
    required this.name,
    required this.jenisUser,
    required this.email,
    required this.level,
    required this.pathPhoto,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.nik,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      jenisUser: json['jenis_user'],
      email: json['email'],
      level: json['level'],
      pathPhoto: json['path_foto'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresIn: json['expires_in'],
      nik: json['nik'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'jenis_user': jenisUser,
        'email': email,
        'level': level,
        'path_photo': pathPhoto,
        'access_token': accessToken,
        'token_type': tokenType,
        'expires_in': expiresIn,
        'nik': nik,
      };

  User toEntity() => User(
        id: id,
        name: name,
        jenisUser: jenisUser,
        email: email,
        level: level,
        pathPhoto: pathPhoto,
        accessToken: accessToken,
        tokenType: tokenType,
        expiresIn: expiresIn,
        nik: nik,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      jenisUser ?? 'null',
      email,
      level,
      pathPhoto,
      accessToken,
      tokenType,
      expiresIn,
      nik,
    ];
  }
}
