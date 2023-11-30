import 'package:http/http.dart' as http;
import 'package:weatherapp/api/api_constans.dart';
import 'package:weatherapp/models/weather_data.dart';

import 'api_error.dart';

typedef Mapper<T> = T Function(http.Response response);

bool isSuccessStatusCode(int statusCode) {
  return statusCode < 200 || statusCode >= 300;
}

class ApiService {
  Future<T> _get<T>(String path, Mapper<T> mapper,
      {Map<String, dynamic>? queryParams}) async {
    String query;
    if (queryParams == null) {
      query = "";
    } else {
      query = "?" +
          queryParams.entries
              .map((entry) => '${entry.key}=${entry.value}')
              .join("&");
    }
    // String query = queryParams == null ? "" : ("?" + queryParams.entries.map((entry) => '${entry.key}=${entry.value}').join("&"));
    Uri uri = Uri.parse(ApiConstants.weatherBaseScheme +
        ApiConstants.weatherBaseUrlDomain +
        path +
        query);
    http.Response response = await http.get(uri);
    if (isSuccessStatusCode(response.statusCode)) {
      throw ApiServiceError(
          response.reasonPhrase ??
              'Failed with status code: ${response.statusCode}',
          response);
    }
    T result = mapper(response);
    return result;
  }

  Future<WeatherData> getWeather(String city) async {
    return _get<WeatherData>(
      ApiConstants.weatherWeatherPath,
      (response) => WeatherData.fromJson(response.body),
      queryParams: {'q': city, 'appid': ApiConstants.weatherAppId},
    );
  }
}
