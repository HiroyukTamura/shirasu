import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_data.freezed.dart';
part 'auth_data.g.dart';

@freezed
abstract class AuthData with _$AuthData {
  const factory AuthData({
    @required Body body,
    @required int expiresAt,
  }) = _AuthData;

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      _$AuthDataFromJson(json);
}

@freezed
abstract class Body with _$Body {
  const factory Body({
    @required String clientId,
    @required String accessToken,
    @required String refreshToken,
    @required String idToken,
    @required String scope,
    @required int expiresIn,
    @required String tokenType,
    @required DecodedToken decodedToken,
    @required String audience,
  }) = _Body;

  factory Body.fromJson(Map<String, dynamic> json) =>
      _$BodyFromJson(json);
}

@freezed
abstract class DecodedToken with _$DecodedToken {
  const factory DecodedToken({
    @required Encoded encoded,
    @required Header header,
    @required Claims claims,
    @required User user,
  }) = _DecodedToken;

  factory DecodedToken.fromJson(Map<String, dynamic> json) =>
      _$DecodedTokenFromJson(json);
}

@freezed
abstract class Claims with _$Claims {
  const factory Claims({
    @required String raw,
    @required List<String> httpsShirasuIoRoles,
    @required HttpsShirasuIoUserAttribute httpsShirasuIoUserAttribute,
    @required String httpsShirasuIoCustomerId,
    @required List<dynamic> httpsShirasuIoDistributeds,
    @required List<dynamic> httpsShirasuIoTenants,
    @required String givenName,
    @required String familyName,
    @required String nickname,
    @required String name,
    @required String picture,
    @required String locale,
    @required DateTime updatedAt,
    @required String email,
    @required bool emailVerified,
    @required String iss,
    @required String sub,
    @required String aud,
    @required int iat,
    @required int exp,
    @required String nonce,
  }) = _Claims;

  factory Claims.fromJson(Map<String, dynamic> json) =>
      _$ClaimsFromJson(json);
}

@freezed
abstract class HttpsShirasuIoUserAttribute with _$HttpsShirasuIoUserAttribute {
  const factory HttpsShirasuIoUserAttribute({
    @required DateTime birthDate,
    @required String job,
    @required String country,
    @required String prefecture,
    @required String familyName,
    @required String givenName,
    @required String familyNameReading,
    @required String givenNameReading,
  }) = _HttpsShirasuIoUserAttribute;

  factory HttpsShirasuIoUserAttribute.fromJson(Map<String, dynamic> json) =>
      _$HttpsShirasuIoUserAttributeFromJson(json);
}

@freezed
abstract class Encoded with _$Encoded {
  const factory Encoded({
    @required String header,
    @required String payload,
    @required String signature,
  }) = _Encoded;

  factory Encoded.fromJson(Map<String, dynamic> json) =>
      _$EncodedFromJson(json);
}

@freezed
abstract class Header with _$Header {
  const factory Header({
    @required String alg,
    @required String typ,
    @required String kid,
  }) = _Header;

  factory Header.fromJson(Map<String, dynamic> json) =>
      _$HeaderFromJson(json);
}

@freezed
abstract class User with _$User {
  const factory User({
    @required List<String> httpsShirasuIoRoles,
    @required HttpsShirasuIoUserAttribute httpsShirasuIoUserAttribute,
    @required String httpsShirasuIoCustomerId,
    @required List<dynamic> httpsShirasuIoDistributeds,
    @required List<dynamic> httpsShirasuIoTenants,
    @required String givenName,
    @required String familyName,
    @required String nickname,
    @required String name,
    @required String picture,
    @required String locale,
    @required DateTime updatedAt,
    @required String email,
    @required bool emailVerified,
    @required String sub,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
}
