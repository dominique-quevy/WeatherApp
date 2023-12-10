class ApiConstants {
  // https://openweathermap.org/current
  //
  // Product concept
  // Access current weather data for any location on Earth!
  // We collect and process weather data from different sources
  // such as global and local weather models, satellites, radars and a vast network of weather stations.
  // Data is available in JSON, XML, or HTML format.
  //
  // Call current weather data
  // How to make an API call
  // API call
  // https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
  //
  // Parameters
  //  lat	required	Latitude. If you need the geocoder to automatic convert city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API
  //  lon	required	Longitude. If you need the geocoder to automatic convert city names and zip-codes to geo coordinates and the other way around, please use our Geocoding API
  //  appid	required	Your unique API key (you can always find it on your account page under the "API key" tab)
  //  mode	optional	Response format. Possible values are xml and html. If you don't use the mode parameter format is JSON by default.
  //  units	optional	Units of measurement. standard, metric and imperial units are available. If you do not use the units parameter, standard units will be applied by default.
  //  lang	optional	You can use this parameter to get the output in your language.
  static const String weatherBaseScheme = 'https://';
  static const String weatherBaseUrlDomain = 'api.openweathermap.org';
  static const String weatherImagesPath = "/img/w/";
  static const String weatherImagesUrl =
      weatherBaseScheme + weatherBaseUrlDomain + weatherImagesPath;
  static const String weatherWeatherPath = "/data/2.5/weather";
  static const String weatherForecastPath = "/data/2.5/forecast";
  static const String weatherAppId = "3ad64614c29e55ba6dc5779a08d7723a";
}
