# Application_kitason0722
## アプリ概要
出てきたターゲットを制限時間内に何回タッチすることができるかを競うゲーム
### タイトル画面
<img src="https://github.com/user-attachments/assets/326739c6-abcd-489e-994b-2ebe917dd143" width="200">

### ゲーム画面
<img src="https://github.com/user-attachments/assets/c42cc12b-bea6-4e76-b85f-9d38bcbb41c2" width="200">

### ゲーム画面（プレイ中）
<img src="https://github.com/user-attachments/assets/077fbc6a-137a-4e10-a5e0-8c18c2e3453a" width="200">

### リザルト画面
<img src="https://github.com/user-attachments/assets/3d572424-f149-4343-8f4c-24247757176b" width="200">

### ランキング表示
<img src="https://github.com/user-attachments/assets/8996e02b-f30f-45c0-af1a-3e7960cd9693" width="200">

## 設計方針
**画面遷移**

タイトル画面 -> ゲーム画面

ゲーム画面 -> リザルト画面

リザルト画面 -> タイトル画面

**ルール：**勇者のターゲットをタップするとスコア+1、スライムのターゲットをタップするとスコア-1とする。
<img src="https://github.com/user-attachments/assets/68b84739-1a19-4de0-8cc1-b217508e1416" width="100">
<img src="https://github.com/user-attachments/assets/578eed06-aff4-4940-8076-a7dd2d093d3b" width="100">

## 工夫したところ
**1.ゲームの簡易さ：**プレイヤーのゲームスキルをあまり問わないシンプルな反射神経ゲームにすることで、どんなユーザーでも簡単に遊べることを重視した設計にした。

**2.ランキング形式を採用：** 自身の上位3位のスコアを掲示することでスコア更新のモチベーションを上げやすくした。

**3.ゲーム中のターゲットの数、出現頻度の変化：** ゲームの経過時間に応じてターゲットの表示数や表示時間を動的に変更することによりゲームの難易度を適度に楽しめるものに調節した。

## 動作環境
Flutter 3.24.3

Tools Dart 3.5.3
