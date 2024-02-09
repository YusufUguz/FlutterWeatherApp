import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

void splitWeatherText(List<String> weatherText, List<Widget> textWidgets) {
  if (weatherText.length == 2) {
    textWidgets.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            weatherText[0],
            style: weatherConditionTextStyle,
          ),
          Text(
            weatherText[1],
            style: weatherConditionTextStyle,
          ),
        ],
      ),
    );
  } else if (weatherText.length == 3) {
    textWidgets.add(
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${weatherText[0]} ${weatherText[1]}",
                  style: weatherConditionTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${weatherText[2]}}", style: weatherConditionTextStyle),
            ],
          ),
        ],
      ),
    );
  } else if (weatherText.length == 4) {
    textWidgets.add(
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${weatherText[0]} ${weatherText[1]}",
                  style: weatherConditionTextStyle),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${weatherText[2]} ${weatherText[3]}",
                  style: weatherConditionTextStyle),
            ],
          ),
        ],
      ),
    );
  }
}
