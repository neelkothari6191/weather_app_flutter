import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: 'Weather App',
      home: Home(),
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windspeed;
  var visibility;

  Future getWeather() async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=19.0760&lon=72.8777&units=imperial&appid=5dbd6f62105df3465700b3bd66c7e61f");
    http.Response response = await http.get(url);

    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windspeed = results['wind']['speed'];
      this.visibility = results['visibility'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Image.asset("assets/c1.png",fit:BoxFit.contain),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Mumbai",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\u00B0" : 'Loading',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    currently != null
                        ? currently.toString() + "\u00B0"
                        : 'Loading',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ListView(
                    children: <Widget>[
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                        title: Text("Thermometer"),
                        trailing: Text(temp != null
                            ? temp.toString() + "\u00B0"
                            : 'Loading'),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.cloud),
                        title: Text("Weather"),
                        trailing: Text(description != null
                            ? description.toString()
                            : 'Loading'),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.sun),
                        title: Text("TemperaHumidityture"),
                        trailing: Text(
                            humidity != null ? humidity.toString() : 'Loading'),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.wind),
                        title: Text("Wind Speed"),
                        trailing: Text(windspeed != null
                            ? windspeed.toString()
                            : 'Loading'),
                      ),
                      ListTile(
                        leading: FaIcon(FontAwesomeIcons.eye),
                        title: Text("Visibilty"),
                        trailing: Text(visibility != null
                            ? visibility.toString()
                            : 'Loading'),
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
