// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:weather_app/functions/split_weather_text.dart';
import 'package:weather_app/services/weather.dart';
import 'package:weather_app/screens/type_city_name_screen.dart';
import 'package:weather_app/widgets/custom_divider.dart';
import 'package:weather_app/widgets/details_row.dart';

class WeatherDetailsPage extends StatefulWidget {
  WeatherDetailsPage({required this.locationWeather});

  final locationWeather;

  @override
  _WeatherDetailsPageState createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  WeatherService weather = WeatherService();
  late int temperature;
  late double feelsLike;
  late int pressure;
  late int humidity;
  late double windSpeed;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;
  late String weatherConditionText;
  late DateTime usersDateTime;
  late var condition;

  late int dailyWeatherTemp;
  late String dailyWeatherDay;
  late String dailyWeatherIcon;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'assets/images/noDataIcon.png';
        weatherMessage = 'Cant get weather Data';
        cityName = 'No City Name Like That,Try Again';
        feelsLike = 0;
        pressure = 0;
        humidity = 0;
        windSpeed = 0;
        weatherConditionText = 'No Data';
        return;
      }

      num temp = weatherData['main']['temp'];
      feelsLike = weatherData['main']['feels_like'];
      pressure = weatherData['main']['pressure'];
      humidity = weatherData['main']['humidity'];
      num windSpeedTemp = weatherData['wind']['speed'];
      windSpeed = windSpeedTemp.toDouble();

      temperature = temp.toInt();
      condition = weatherData['weather'][0]['id'];

      weatherConditionText = weatherData['weather'][0]['description'];

      weatherMessage = weather.getMessage(condition, temperature);

      weatherIcon = weather.getWeatherIcon(condition);

      cityName = weatherData['name'];

      usersDateTime = DateTime.now();
      debugPrint(usersDateTime.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> weatherConditionTextWords = weatherConditionText.split(' ');

    List<Widget> textWidgets = [];

    splitWeatherText(weatherConditionTextWords, textWidgets);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: getBackGroundImage(),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.location_pin,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return TypeCityNamePage();
                            },
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cityName,
                            style: const TextStyle(
                                fontFamily: 'Oswald',
                                color: Colors.white,
                                fontSize: 25),
                          ),
                          Text(
                            '$temperature°',
                            style: const TextStyle(
                                fontSize: 60, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 5),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          weatherIcon,
                          width: 75,
                          height: 75,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: textWidgets),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/images/warning.png'),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      weatherMessage,
                                      style: const TextStyle(
                                          fontFamily: 'Merriweather',
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              DetailsRow(
                                detailsTypeValue:
                                    '${feelsLike.toStringAsFixed(1)}°',
                                detailsTypeText: 'Feels Like',
                                imageName: 'feelslikeIcon',
                              ),
                              const CustomDivider(),
                              DetailsRow(
                                  detailsTypeValue: '$pressure hPa',
                                  detailsTypeText: 'Pressure',
                                  imageName: 'pressureIcon'),
                              const CustomDivider(),
                              DetailsRow(
                                  detailsTypeValue: '%$humidity',
                                  detailsTypeText: 'Humidity',
                                  imageName: 'moistureIcon'),
                              const CustomDivider(),
                              DetailsRow(
                                  detailsTypeValue:
                                      '${windSpeed.toStringAsFixed(1)} m/s',
                                  detailsTypeText: 'Wind',
                                  imageName: 'windIcon'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AssetImage getBackGroundImage() {
    if (usersDateTime.hour >= 6 &&
        usersDateTime.hour <= 10 &&
        condition >= 800 &&
        condition <= 804) {
      return const AssetImage('assets/images/morningWeather.jpg');
    }
    if (usersDateTime.hour >= 20 || usersDateTime.hour <= 5) {
      return const AssetImage('assets/images/nightWeather.jpg');
    }
    if (condition < 600) {
      return const AssetImage('assets/images/rainyWeather.jpg');
    } else if (condition < 700) {
      return const AssetImage('assets/images/snowyWeather.jpg');
    } else if (condition == 800) {
      return const AssetImage('assets/images/sunnyWeather.jpg');
    } else if (condition <= 804) {
      return const AssetImage('assets/images/cloudlyWeather.jpg');
    }

    return const AssetImage('assets/images/cloudlyWeather.jpg');
  }
}
