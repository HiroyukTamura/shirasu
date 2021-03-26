import 'package:shirasu/model/graphql/mixins/video_type.dart';
import 'package:shirasu/model/network/result_login.dart';
import 'package:shirasu/model/result_token_refresh.dart';

mixin DioRepository {

  Future<String> getSignedCookie(
      String videoId, VideoType videoType, String auth);

  Future<ResultTokenRefresh> requestRenewToken(String clientId, String refreshToken);

  Future<LoginResult> login2Shirasu(LoginData loginData);
}