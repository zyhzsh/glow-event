import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          height: 900,
          width: 1000,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(top: 50, right: 15),
                width: 30,
                height: 30,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close, size: 30),
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 30.0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Text(
                  "Welcome to the Glow, here is ..",
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none,
                      color: Colors.white),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: 0, left: 30.0, right: 30.0, bottom: 30.0),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  style: TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.none,
                      color: Colors.white),
                ),
              ),
            ],
          )),
    );
  }
}
