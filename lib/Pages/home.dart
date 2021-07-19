import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {}; // declare an empty Map object therefore it cannot be null


  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';
    Color? bgColor =  data['isDaytime'] ? Colors.blueAccent : Colors.blueGrey[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 175.0, 0.0, 0.0),
            child: Column(
              children: [
                TextButton.icon(
                    onPressed: () async {
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag'],
                        };
                      });
                    },
                    icon: Icon(
                        Icons.edit_location,
                        color: Colors.grey[300],
                    ),
                  label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: Colors.grey[300],
                      )
                  ),
                ),
                SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 40.0,
                        letterSpacing: 1.5,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 69.0,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
