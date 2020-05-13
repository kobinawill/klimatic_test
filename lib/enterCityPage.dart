import 'package:flutter/material.dart';

class CityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final showCityWeatherController = new TextEditingController();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Select City"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: new Stack(
        children: <Widget>[
          new Image.asset('images/white_snow.png',
          width: 400,
          fit: BoxFit.fill,),
          new Column(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  controller: showCityWeatherController,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      hintText: "Enter City"
                  ),
                ),
              ),
              new FlatButton(
                  color: Colors.red,
                  onPressed: (){
                    Navigator.pop(context,
                    {
                      'city' : showCityWeatherController.text
                    });
                  },
                  child: new Text("Show City Weather"),
                  textColor: Colors.white,)
            ],
          )
        ]
      ),
    );
  }
}
