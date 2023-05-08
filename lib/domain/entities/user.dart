// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class User extends Equatable {
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

  const User({
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
