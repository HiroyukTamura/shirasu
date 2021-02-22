import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:shirasu/client/auth_wrapper_client.dart';
import 'package:shirasu/client/url_util.dart';
import 'package:shirasu/model/graphql/mixins/video_type.dart';
import 'package:shirasu/model/result_token_refresh.dart';
import 'package:shirasu/model/signed_cookie_result.dart';

final kPrvDioClient = Provider.autoDispose<DioClient>((ref) => DioClient(ref.read));

class DioClient {

  DioClient(this._reader);

  final Dio _dio = Dio();

  final Reader _reader;
  AuthClientInterceptor get _authClientInterceptor => _reader(kPrvAuthClientInterceptor);

  Future<String> getSignedCookie(
      String videoId, VideoType videoType, String auth) async {

    await _authClientInterceptor.refreshAuthTokenIfNeeded();

    final response = await _dio.get<Map<String, dynamic>>(UrlUtil.URL_SIGNED_COOKIE,
        queryParameters: {
          'videoId': videoId,
          'type': _parseVideoType(videoType)
        },
        options: Options(headers: {
          'Authorization': auth,
        }));

    final success = SignedCookieResult.fromJson(response.data).ok;
    if (!success) throw Exception('getSignedCookie failed : ${response.data}');

    return response.headers[HttpHeaders.setCookieHeader].map((it) {
      final cookie = Cookie.fromSetCookieValue(it);
      return '${cookie.name}=${cookie.value}';
    }).join('; ');
  }

  static String _parseVideoType(VideoType videoType) {
    switch (videoType) {
      case VideoType.ARCHIVED:
        return 'archive';
      case VideoType.LIVE:
        return 'live';
      default:
        throw ArgumentError.value(videoType);
    }
  }


  /// auth0 API doc: https://auth0.com/docs/tokens/refresh-tokens/use-refresh-tokens
  Future<ResultTokenRefresh> requestRenewToken(String clientId, String refreshToken) async {
    final result = await _dio.post<Map<String, dynamic>>(
      UrlUtil.URL_OAUTH_TOKEN,
      data: {
        'grant_type': 'refresh_token',
        'client_id': clientId,
        'refresh_token': refreshToken,
      },
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
      }),
    );
    return ResultTokenRefresh.fromJson(result.data);
  }
}
