import '../utils/import.dart';

class ApiService {
  static Future<dynamic> getApi(
    String url,
    BuildContext ctx, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await AppVariables.connect
          .get(
            url,
            headers: headers,
          )
          .timeout(Apis.timeoutDuration);
      return _processResponse(response, ctx);
    } on SocketException {
      handleSocketException(ctx: ctx);
    } on TimeoutException {
      return null;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> multipartApi(
    String url,
    BuildContext ctx, {
    String imageParamName = '',
    required List<String> imagePath,
    required Map<String, dynamic> body,
    String method = 'POST',
  }) async {
    try {
      var formData = FormData(body);

      print('hi');
      if (imageParamName.isNotEmpty && imagePath.isNotEmpty) {
        print('hi');
        for (var path in imagePath) {
          final file =
              MultipartFile(File(path), filename: path.split('/').last);
          formData.files.add(MapEntry(imageParamName, file));
        }
      }

      Response response;

      if (method == 'POST') {
        response = await AppVariables.connect.post(
          url,
          formData,
        );
      } else {
        response = await AppVariables.connect.put(
          url,
          formData,
        );
      }

      return _processResponse(response, ctx);
    } on SocketException {
      handleSocketException(ctx: ctx);
    } on TimeoutException {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Request timed out. Please try again.",
      );
      return null;
    } catch (e) {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Unexpected error occurred: $e",
      );
      return null;
    }
  }

  static Future<dynamic> putApi(
    String url,
    BuildContext ctx, {
    Map<String, dynamic>? body,
  }) async {
    try {
      var response;
      if (body == null) {
        response = await AppVariables.connect.put(
          url,
          {},
        ).timeout(Apis.timeoutDuration);
      } else {
        response = await AppVariables.connect
            .put(
              url,
              jsonEncode(body),
              headers: Apis.headersValue,
            )
            .timeout(Apis.timeoutDuration);
      }
      return _processResponse(response, ctx);
    } on SocketException {
      handleSocketException(ctx: ctx);
    } on TimeoutException {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Request timed out. Please try again.",
      );
      return null;
    } catch (e) {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Unexpected error occurred: $e",
      );
      return null;
    }
  }

  static Future<dynamic> deleteApi(
    String url,
    BuildContext ctx, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    if (headers != null) {
      headers.addAll(Apis.headersValue);
    }
    try {
      final response = await AppVariables.connect
          .delete(
            url,
            headers: (headers != null) ? headers : Apis.headersValue,
            query: body ?? {},
          )
          .timeout(Apis.timeoutDuration);
      return _processResponse(response, ctx);
    } on SocketException {
      handleSocketException(ctx: ctx);
    } on TimeoutException {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Request timed out. Please try again.",
      );
      return null;
    } catch (e) {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Unexpected error occurred: $e",
      );
      return null;
    }
  }

  static Future<dynamic> deleteApiBody(
    String url,
    BuildContext ctx, {
    Map<String, dynamic>? body,
  }) async {
    final httpClient = HttpClient();
    try {
      final request = await httpClient.openUrl(
        'DELETE',
        Uri.parse(url),
      );
      Apis.headersValue.forEach(
        (key, value) {
          request.headers.set(key, value);
        },
      );
      request.write(json.encode(body ?? {}));
      final response = await request.close();
      final responseBody = await response.transform(utf8.decoder).join();
      print("responseBody :: ${responseBody}");
      print("responseBody :: ${request.uri}");
      return _processResponse(
          Response(
            body: json.decode(responseBody),
            statusCode: response.statusCode,
          ),
          ctx);
    } on SocketException {
      handleSocketException(ctx: ctx);
    } on TimeoutException {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Request timed out. Please try again.",
      );
      return null;
    } catch (e) {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Unexpected error occurred: $e",
      );
      return null;
    } finally {
      httpClient.close();
    }
  }

  static Future<dynamic> postApi(
    String url,
    BuildContext ctx, {
    dynamic body,
  }) async {
    var response;
    try {
      if (body != null) {
        response = await AppVariables.connect
            .post(
              url,
              jsonEncode(body),
              headers: Apis.headersValue,
            )
            .timeout(Apis.timeoutDuration);
      } else {
        response = await AppVariables.connect
            .post(
              url,
              {},
              headers: Apis.headersValue,
            )
            .timeout(Apis.timeoutDuration);
      }
      return _processResponse(response, ctx);
    } on SocketException {
      handleSocketException(ctx: ctx);
    } on TimeoutException {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Request timed out. Please try again.",
      );
      return null;
    } catch (e) {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Unexpected error occurred: $e",
      );
      return null;
    }
  }

  static dynamic _processResponse(
    Response response,
    BuildContext ctx,
  ) {
    log("S :: ${response.body}");
    log("S :: ${response.statusCode}");
    log("S :: ${response.request?.url}");
    switch (response.statusCode) {
      case 200 || 201:
        return response.body;
      case 400:
        if (response.body['message'] != null) {
          ShowToast.showFailedGfToast(
            ctx: ctx,
            msg:
                "${response.body['message'] ?? "Something went wrong.Please try again."}",
          );
          return null;
        }
        throw BadRequestException('Bad request: ${response.body}');
      case 401:
      case 404:
        ShowToast.showFailedGfToast(
          ctx: ctx,
          msg:
              "${response.body['message'] ?? "Error occurred while communicating with server."}",
        );
        return null;
      case 403:
        throw UnauthorisedException('Unauthorized: ${response.body}');
      case 500:
        ShowToast.showFailedGfToast(
          ctx: ctx,
          msg:
              "${response.body['message'] ?? "Something went wrong.Please try again."}",
        );
        return null;

      default:
        return null;
    }
  }

  static dynamic handleSocketException({required BuildContext ctx}) async {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      ShowToast.showFailedGfToast(
        ctx: ctx,
        msg: "Something went wrong. Please try again.",
      );
      return null;
    }

    ShowToast.showFailedGfToast(
      ctx: ctx,
      msg: "No internet connection.",
    );
    return null;
  }
}

class BadRequestException implements Exception {
  final String message;

  BadRequestException(this.message);
}

class UnauthorisedException implements Exception {
  final String message;

  UnauthorisedException(this.message);
}
