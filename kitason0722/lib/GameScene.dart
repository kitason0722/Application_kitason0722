import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

// GameSceneクラスはStatefulWidgetとしてゲームロジックを管理する。
class GameScene extends StatefulWidget {
  @override
  _GameSceneState createState() => _GameSceneState();
}

class _GameSceneState extends State<GameScene> {
  int _score = 0; // 現在のスコアを保持
  Offset _targetPosition = Offset(100, 100); // ターゲットの現在位置
  Random _random = Random(); // ランダム位置生成用のRandomクラス
  Timer? _gameTimer; // ゲーム進行用のタイマー
  int _timeLeft = 30; // ゲームの残り時間

  // ゲームを開始するメソッド
  void _startGame() {
    setState(() {
      _score = 0; // スコアをリセット
      _timeLeft = 30; // 残り時間をリセット
    });

    // タイマーを初期化
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--; // 残り時間を減少
        } else {
          _gameTimer?.cancel(); // タイマー終了
          _showGameOverDialog(); // ゲーム終了ダイアログを表示
        }
      });
    });
  }

  // ゲーム終了時にスコアを表示するダイアログを表示
  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ゲーム終了'),
        content: Text('スコア: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // ダイアログを閉じる
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  // ターゲットがタップされたときの処理
  void _onTargetTapped() {
    if (_timeLeft > 0) { // 残り時間がある場合のみスコアを更新
      setState(() {
        _score++; // スコアを増加
        // ターゲットの位置をランダムに更新
        _targetPosition = Offset(
          _random.nextDouble() * (MediaQuery.of(context).size.width - 50),
          _random.nextDouble() * (MediaQuery.of(context).size.height - 150),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ゲーム画面', // アプリバーのタイトル
          style: TextStyle(
            fontSize: 30,
          ),
        ),
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
                ElevatedButton(
                  onPressed: _startGame, // ゲーム開始ボタン
                  child: Text('ゲーム開始'),
                ),
              ],
            ),
          ),
          // ターゲットの位置を描画
          if (_timeLeft > 0)
            Positioned(
              left: _targetPosition.dx, // ターゲットのX座標
              top: _targetPosition.dy, // ターゲットのY座標
              child: GestureDetector(
                onTap: _onTargetTapped, // ターゲットがタップされたときの処理を実行
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red, // ターゲットの色
                    shape: BoxShape.circle, // ターゲットの形状
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel(); // タイマーをキャンセルしてリソースを解放
    super.dispose();
  }
}
