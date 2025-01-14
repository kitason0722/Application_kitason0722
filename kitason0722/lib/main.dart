import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const ReactionGame());
}

class ReactionGame extends StatelessWidget {
  const ReactionGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'リアクションテストゲーム',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final Random _random = Random();
  Color _backgroundColor = Colors.white;
  late Timer _timer;
  bool _isTargetColor = false;
  int _score = 0;
  bool _gameRunning = false;

  // ターゲットの色
  final Color _targetColor = Colors.red;

  // ゲームを開始する
  void _startGame() {
    setState(() {
      _score = 0;
      _gameRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        // 背景色をランダムに変更
        _backgroundColor = Color.fromARGB(
          255,
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
        );
        // ターゲットの色かどうかを判定
        _isTargetColor = _backgroundColor == _targetColor;
      });
    });
  }

  // ゲームを終了する
  void _endGame() {
    _timer.cancel();
    setState(() {
      _gameRunning = false;
      _backgroundColor = Colors.white;
    });
  }

  // タップ時の動作
  void _onTap() {
    if (_isTargetColor) {
      setState(() {
        _score++;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar
        (
        title: const Text('リアクションテストゲーム'),
      ),
      body: GestureDetector
        (
        onTap: _gameRunning ? _onTap : null,
        child: Container
          (
          color: _backgroundColor,
          child: Center
            (
            child: _gameRunning
                ? Column
              (
              mainAxisSize: MainAxisSize.min,
              children:
              [
                Text
                  (
                  'スコア: $_score',
                  style: const TextStyle(fontSize: 32), // スコアのフォントサイズを調整
                ),
                const SizedBox(height: 20),
                const Text
                  (
                  '背景が赤になったら押せ!',
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold), // メッセージのフォントサイズを調整
                ),
              ],
            )
                : SizedBox
              (
              width: 200, // ボタンの幅
              child: ElevatedButton
                (
                onPressed: _startGame,
                style: ElevatedButton.styleFrom
                  (
                  minimumSize: const Size(200, 60), // ボタンサイズを指定
                ),
                child: const Text
                  (
                  'スタート',
                  style: TextStyle(fontSize: 20), // ボタン文字サイズ
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: _gameRunning
          ? FloatingActionButton(
        onPressed: _endGame,
        child: const Icon(Icons.stop),
      )
          : null,
    );
  }
}
