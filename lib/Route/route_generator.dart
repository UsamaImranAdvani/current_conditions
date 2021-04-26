import 'package:flutter/material.dart';
import '../Base/weatherapiCall.dart';
import '../Base/apiCall.dart';

class RouteGenerator {

  // ignore: missing_return
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => apiCall());
      case '/weatherApiCall':
        return MaterialPageRoute(
            builder: (context) => weatherApiCall(
              dataMap: args,
            ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Error"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("Page Not Found"),
        ),
      );
    });
  }
}
