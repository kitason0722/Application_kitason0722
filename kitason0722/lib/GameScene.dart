import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// GameSceneクラスはStatefulWidgetとしてゲームロジックを管理する。
class GameScene extends StatefulWidget {
  final List<int> ranking;

  GameScene({Key? key, required this.ranking}) : super(key:key);

  @override
  _GameSceneState createState() => _GameSceneState();
}

class _GameSceneState extends State<GameScene>
{
  int _score = 0;
  int _timeLeft = 30;
  bool _isGameActive = false;
  Random _random = Random();
  Timer? _gameTimer,_spawnTimer;
  List<Map<String,dynamic>> _targets = [];//ターゲットのリスト
  double _targetDisplayduration = 2.0;
  double _heroratio = 0.8;//hero.pngの出現割合
  double _spawnInterval = 1.0;//ターゲット出現間隔


  // ゲームを開始するメソッド
  void _startGame() {
    setState(() {
      //変数、リストの初期化
      _score = 0;
      _timeLeft = 30;
      _isGameActive = true;
      _targets.clear();
      _targetDisplayduration = 2.0;
      _heroratio = 0.8;
      _spawnInterval = 1.0;
    });

    //タイマーの初期化
    _gameTimer?.cancel();
    _spawnTimer?.cancel();

    //ゲーム時間
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0)
        {
          _timeLeft--; // 残り時間を減少

          if (_timeLeft % 5 == 0)
          {
            if (_targetDisplayduration > 0.5) _targetDisplayduration -= 0.2;
            if (_heroratio > 0.5) _heroratio -= 0.05; // heroの割合を減少
          }

          _spawnInterval = _changeSpawnInterval();
        }
        else
        {
          _gameTimer?.cancel();
          _spawnTimer?.cancel();
          _isGameActive = false;
          _updateRanking();
          _showGameOverDialog();
        }
      });
    });
    // ターゲットの出現を管理
    _spawnTimer = Timer.periodic(Duration(milliseconds: (_spawnInterval * 1000).toInt()), (timer)
    {
      if (_isGameActive) _addTarget();
    });
  }

  double _changeSpawnInterval()
  {
    return 1.0 - (0.7*(30-_timeLeft)/30);
  }

  int _TargetNumber()
  {
    // 難易度曲線を基に一度に出現するターゲット数を算出
    // 最初は1体、徐々に最大5体まで増加
    return 1 + ((5 - 1) * (30 - _timeLeft) ~/ 30);
  }

  void _setTarget() {
    final isHero = _random.nextDouble() <= _heroratio;
    final size = isHero ? 100.0 : 200.0; // ターゲットのサイズ
    final maxWidth = MediaQuery.of(context).size.width - size;
    final maxHeight = MediaQuery.of(context).size.height - size - 100;

    final newTarget =
    {
      'position': Offset
        (
        _random.nextDouble() * maxWidth,
        _random.nextDouble() * maxHeight,
      ),
      'id':  DateTime.now().millisecondsSinceEpoch + _random.nextInt(1000), // 一意のID
      'type': isHero ? 'hero' : 'slime',
    };
    _targets.add(newTarget);
    // 一定時間後にターゲットを削除
    Timer(Duration(seconds: _targetDisplayduration.toInt()), ()
    {
      setState(()
      {
        _targets.removeWhere((target) => target['id'] == newTarget['id']);
      });
    });
  }

  void _addTarget()
  {
    int targetnum = _TargetNumber();
    for (int i = 0; i < targetnum; i++)_setTarget();
  }

  //タップ時の処理
  void _onTargetTapped(int id,String type)
  {
    setState(() {
      if (type == 'hero') {
        _score++;
      } else if (type == 'slime') {
        _score--;
      }
      _targets.removeWhere((target) => target['id'] == id);
    });
  }

  //スコアを保存
  void _updateRanking(){
    widget.ranking.add(_score);
    widget.ranking.sort((a, b) => b.compareTo(a)); // 降順にソート
    if (widget.ranking.length > 3) {
      widget.ranking.removeRange(3, widget.ranking.length); // 上位3つに絞る
    }
  }

  // ゲーム終了時にスコアを表示するダイアログを表示
  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ゲーム終了'),
        content: Text('スコア: $_score',style: TextStyle(fontSize: 24)),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // ダイアログを閉じる
              Navigator.of(context).pop(widget.ranking); // ランキングを返す
            },
            style:ElevatedButton.styleFrom(
              minimumSize: Size(50, 30),
              backgroundColor:Colors.black,
              side: BorderSide(color:Colors.orange,width: 3),
            ),
            child: Text('タイトルへ',style: TextStyle(color:Colors.yellow)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'タイトルへ',
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 16,
              ),
            ),
      style:ElevatedButton.styleFrom(
        minimumSize: Size(90, 30),
        backgroundColor:Colors.black,
        side: BorderSide(color:Colors.orange,width: 3),
      ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 中央にスコアとタイマーを表示
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'スコア: $_score', // 現在のスコアを表示
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 10),
                Text(
                  '残り時間: $_timeLeft 秒', // 残り時間を表示
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                Visibility(
                  visible: !_isGameActive,
                  child: ElevatedButton(
                    onPressed: _startGame, // ゲーム開始ボタン
                    child: Text(
                      'ゲーム開始', style: TextStyle(
                      color: Colors.yellow,
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
              ],
            ),
          ),
          // ターゲットを表示
          ..._targets.map((target) {
            final size = target['type'] == 'hero' ? 100.0 : 200.0;//ターゲットごとのサイズ
            return Positioned(
              left: target['position'].dx,
              top: target['position'].dy,
              child: GestureDetector(
                onTap: () => _onTargetTapped(target['id'],target['type']),
                child: Image.asset(
                  target['type'] == 'hero'
                  ?'Materials/hero.png'
                  :'Materials/slime.png',
                  width: size,
                  height: size,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }
}
