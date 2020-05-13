import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:klimatic_test/enterCityPage.dart';
import '../utils/utils.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _theCity = defaultCity;

  Future getCity(BuildContext context) async{
    Map receive = await Navigator.of(context).push(
        MaterialPageRoute<Map>(
            builder: (BuildContext context){
              return CityPage();
            })
    );
    if(receive != null && receive.containsKey('city')){
      _theCity = receive['city'];
    }else{
      _theCity = defaultCity;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Klimatic"),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () => getCity(context))
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Image.asset('images/umbrella.png',
          height: 1200,
          fit: BoxFit.fill,),
          new Container(
            margin: new EdgeInsets.fromLTRB(240, 10, 0, 0),
            child: new Text('${_theCity == null ? defaultCity : _theCity}', style: cityStyle(),),
          ),
          new Center(
            child: new Image.asset('images/light_rain.png'),
          ),
          futureWeather(_theCity)
        ],
      ),
    );
  }
}

TextStyle cityStyle(){
  return new TextStyle(
    color: Colors.white,
    //fontWeight: FontWeight.w100,
    fontSize: 20,
    fontStyle: FontStyle.italic
  );
}

TextStyle tempStyle(){
  return new TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: 49.9
  );
}

Future<Map> getWeather(String apID, String city) async{
    http.Response theResponse = await http.get('http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apID&units=imperial');
    return json.decode(theResponse.body);
}

Widget futureWeather(String city){
  return new FutureBuilder(
      future: getWeather(appID, city == null || city == "" ? defaultCity : city),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot){
        if(snapshot.hasData){
          return new Container(
            margin: new EdgeInsets.fromLTRB(45, 270, 0, 0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new ListTile(
                  title: new Text("${snapshot.data['main']['temp']} F",style: tempStyle()),
                  subtitle: new ListTile(
                    title: new Text(
                            "Humidity: ${snapshot.data['main']['humidity']}F\n"
                            "Min: ${snapshot.data['main']['temp_min']}F\n"
                            "Max: ${snapshot.data['main']['temp_max']}F\n",
                      style: new TextStyle(color: Colors.white, fontSize: 17.0)
                    ),
                  )
                )
              ],
            ),
          );
        }
        else{
          return new Container();
        }
      });
}


