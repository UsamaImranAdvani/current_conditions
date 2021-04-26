import 'dart:core';
import 'dart:async';
import 'dart:convert';
import "package:http/http.dart" as http;

class config {
  @override
  String time;
  String currCity;
  List cities;
  int cityKey;
  bool IsDayTime = true;
  double temp;
  double RealFeelTemperature;
  int RelativeHumidity;
  double WindSpeed;
  double WindGust;
  int UVIndex;

  bool isLoading = true;
  bool ApiLoadError = false;
  bool isLoadingWeather = true;
  bool ApiLoadErrorWeather = false;

  Future<void> fetchCity() async {
    var url =
        'https://water-level-indicator-37a38-default-rtdb.firebaseio.com/.json';
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      if (items != null) {
        this.cities = items["cities"].entries.toList();
        this.time = items["lastUpdated"];
      }
      isLoading = false;
      ApiLoadError = false;
    } else {
      isLoading = false;
      ApiLoadError = true;
    }
  }

  Future<void> fetchWeather() async {
    var cityName = currCity.split(" ");
    try {
      var url =
          'http://dataservice.accuweather.com/locations/v1/cities/PK/search?apikey=%09C3a2RJm44QTfuGDMOTJPOsCVvPjE8ZOz&q=${cityName[0]}&details=true';
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var items = json.decode(response.body);
        if (items != null) {
          var apiOne = items;
          this.cityKey = int.tryParse(apiOne[0]["Key"]);
          isLoadingWeather = false;
          ApiLoadErrorWeather = false;
        } else {
          print("Error in citykey");
          isLoadingWeather = false;
          ApiLoadErrorWeather = true;
        }
      }
      var url2 =
          'http://dataservice.accuweather.com/currentconditions/v1/$cityKey?apikey=%09C3a2RJm44QTfuGDMOTJPOsCVvPjE8ZOz&details=true';
      var response2 = await http.get(url2);
      if (response2.statusCode == 200) {
        var items = json.decode(response2.body);
        if (items != null) {
          var apiTwo = items;
          this.IsDayTime = apiTwo[0]["IsDayTime"];
          this.temp = (apiTwo[0]["Temperature"] as dynamic)['Metric']["Value"];
          this.RealFeelTemperature =
              (apiTwo[0]["RealFeelTemperature"] as dynamic)['Metric']["Value"];
          this.RelativeHumidity = apiTwo[0]["RelativeHumidity"];
          this.WindSpeed =
              (apiTwo[0]["Wind"] as dynamic)["Speed"]["Metric"]["Value"];
          this.WindGust =
              (apiTwo[0]["WindGust"] as dynamic)["Speed"]["Metric"]["Value"];
          this.UVIndex = apiTwo[0]["UVIndex"];
          isLoadingWeather = false;
          ApiLoadErrorWeather = false;
        } else {
          print("Error in weather");
          isLoadingWeather = false;
          ApiLoadErrorWeather = true;
        }
      }
    } catch (e) {
      this.IsDayTime = true;
      this.temp = null;
      this.RealFeelTemperature = null;
      this.RelativeHumidity = null;
      this.WindSpeed = null;
      this.WindGust = null;
      this.UVIndex = null;
      isLoadingWeather = false;
      ApiLoadErrorWeather = false;
    } //try
  }
}

// ignore: camel_case_types
class theme {
  @override
  bool dark = false;

  String darkBG = "#37474F";
  String darkAppBarTxt = "#FFFFFF";
  String darkContainer = "0xFF000000";
  String darkCards = "0xFF37474F";
  String darkTxt = "0xFFFFFFFF";
  String darkLiquid = "0xFF9E9E9E";
  String darkLiquidTxt = "0xFFFFFFFF";

  String lightBG = "#37474F";
  String lightAppBarTxt = "#FFFFFF";
  String lightContainer = "0xFFFFFFFF";
  String lightCards = "0xFFFFFFFF";
  String lightTxt = "0xFF000000";
  String lightLiquid = "0xFF000000";
  String lightLiquidTxt = "0xFF9E9E9E";

  String container = "0xFFFFFFFF";
  String txt = "0xFF000000";
  String liquid = "0xFF000000";
  String liquidTxt = "0xFF9E9E9E";
  String card = "0xFFFFFFFF";
  String day = "assets/images/sunnyblack.png";
  String night = "assets/images/nightblack.png";

  String darkImageDay = "assets/images/sunnywhite.png";
  String lightImageDay = "assets/images/sunnyblack.png";

  String darkImageNight = "assets/images/nightwhite.png";
  String lightImageNight = "assets/images/nightblack.png";

  String darkLogo = "assets/images/logowhite.png";
  String lightLogo = "assets/images/logoblack.png";

  String logo = "assets/images/logoblack.png";

  changer() {
    if (dark) {
      dark = false;
      container = lightContainer;
      txt = lightTxt;
      liquid = lightLiquid;
      liquidTxt = lightLiquidTxt;
      day = lightImageDay;
      night = lightImageNight;
      card = lightCards;
      logo = lightLogo;
    } else {
      dark = true;
      container = darkContainer;
      txt = darkTxt;
      liquid = darkLiquid;
      liquidTxt = darkLiquidTxt;
      day = darkImageDay;
      night = darkImageNight;
      card = darkCards;
      logo = darkLogo;
    }
  }
}
