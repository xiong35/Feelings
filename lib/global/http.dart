import 'dart:io';
import 'dart:convert';

final HttpClient httpClient = HttpClient();

Future<String> GET(String path,
    {Map<String, dynamic> query}) async {
  HttpClientRequest request = await httpClient.getUrl(
    Uri(
      scheme: "http",
      host: "api.xiong35.cn",
      path: "/netease$path",
      queryParameters: query,
    ),
  );

  HttpClientResponse response = await request.close();

  String responseBody =
      await response.transform(utf8.decoder).join();

  return responseBody;
}
