import 'package:fast_food/screen/home_screen.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:  Theme.of(context).textTheme.bodyText2.color,
            size: 25,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Wrap(
              children: [
                Text(
                  'Hi this is shashank singh ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color:  Theme.of(context).textTheme.bodyText2.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("I am a flutter developer you can contact me on 9260928512",
                  style: TextStyle(
                      color:  Theme.of(context).textTheme.bodyText2.color, fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
