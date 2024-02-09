import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/network.dart';

const apiKey = '7b4a37474bd2c40b10210df0e37094c2';

class WeatherService {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return 'assets/images/stormIcon.png';
    } else if (condition < 400) {
      return 'assets/images/drizzleRainIcon.png';
    } else if (condition < 600) {
      return 'assets/images/rainyIcon.png';
    } else if (condition < 700) {
      return 'assets/images/snowIcon.png';
    } else if (condition < 800) {
      return 'assets/images/fogIcon.png';
    } else if (condition == 800) {
      return 'assets/images/sunIcon.png';
    } else if (condition <= 804) {
      return 'assets/images/cloudIcon.png';
    } else {
      return 'assets/images/noDataIcon.png';
    }
  }

  String getMessage(int condition, int temp) {
    if (temp >= 33) {
      return 'The weather is hot today. Don\'t forget to wear a hat, drink plenty of water, and avoid staying under the sun.';
    }
    if (condition < 300) {
      return 'It might be a stormy and thunderous day. Don\'t forget to take your umbrella and try to stay indoors.';
    } else if (condition < 600) {
      return 'It might be a rainy day. Don\'t forget to take your umbrella or wear a raincoat.';
    } else if (condition < 700) {
      return 'It might be a snowy day. Dress warmly and avoid staying outside for long periods in the cold weather.';
    } else if (condition < 800) {
      return 'The weather might be foggy and misty. Pay attention to your visibility.';
    } else if (condition == 800) {
      return 'The weather is clean and sunny today. Enjoy the day!';
    } else if (condition <= 804) {
      return 'The weather is cloudy today.';
    } else {
      return '🤷‍';
    }
  }

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getDailyWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            'api.openweathermap.org/data/2.5/forecast/daily?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;
  }
}
