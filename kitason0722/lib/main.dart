import 'package:flutter/material.dart';
import 'GameScene.dart';

void main() {
  runApp(const TitleScene());
}

class TitleScene extends StatelessWidget {
  const TitleScene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> ranking = [0, 0, 0];
    Alignment rankingAlignment = Alignment.topCenter; // ランキングの位置設定

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(ranking: ranking, rankingAlignment: rankingAlignment),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<int> ranking;
  final Alignment rankingAlignment;

  MyHomePage({Key? key, required this.ranking, required this.rankingAlignment}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Alignment _rankingAlignment;

  @override
  void initState() {
    super.initState();
    _rankingAlignment = widget.rankingAlignment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: Text(
          'リアクションマスターズ',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final updatedRanking = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScene(ranking: List.from(widget.ranking)),
                  ),
                );
                if (updatedRanking != null) {
                  setState(() {
                    widget.ranking.clear();
                    widget.ranking.addAll(updatedRanking);
                  });
                }
              },
              child: Text("スタート", style: TextStyle(color: Colors.yellow, fontSize: 30)),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50),
                backgroundColor: Colors.black,
                side: BorderSide(color: Colors.orange, width: 3),
              ),
            ),
          ),
          Align(
            alignment: _rankingAlignment,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'ランキング:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  for (int i = 0; i < 3; i++)
                    Text(
                      '${i + 1} 位: ${widget.ranking[i]}',
                      style: TextStyle(fontSize: 20),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
