import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    //mapping the routed data
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String? bgImage;
    Color? bgColor;

    if (data['isDayTime'] == true) {
      bgImage = 'day.png';
      bgColor = Colors.blue;
    }
    if (data['isDayTime'] == false) {
      bgImage = 'night.png';
      bgColor = Colors.indigo[700];
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('images/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = result;
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color:Colors.grey[300] ,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      letterSpacing: 2.0,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
