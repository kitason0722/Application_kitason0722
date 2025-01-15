import 'package:flutter/material.dart';
import 'package:kitason0722/GameScene.dart';

void main() {
  runApp(const TitleScene());
}

class TitleScene extends StatelessWidget {
  const TitleScene({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'タイトル画面',
          style:TextStyle(
            fontSize: 30,
          ),
        ),

      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GameScene())
            );
          },
          child: Text(
              "スタート",
            style:TextStyle(
              color:Colors.yellow,
              fontSize: 30,
            ),
          ),
          style:ElevatedButton.styleFrom(
              minimumSize: Size(150, 50),
              backgroundColor:Colors.black,
              side: BorderSide(color:Colors.orange,width: 3),
          ),
        ),
      ),
    );
  }
}
