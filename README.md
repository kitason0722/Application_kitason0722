# Application_kitason0722
## アプリ概要
出てきたターゲットを制限時間内に何回タッチすることができるかを競うゲーム
### タイトル画面
<img src="https://github.com/user-attachments/assets/326739c6-abcd-489e-994b-2ebe917dd143" width="200">

### ゲーム画面
<img src="https://github.com/user-attachments/assets/0bdf0088-1694-41d1-b9ce-d077e62da575" width="200">

### ゲーム画面（プレイ中）
<img src="https://github.com/user-attachments/assets/e389e5c3-a375-4a98-9ce7-d09ba6eae723" width="200">

### リザルト画面
<img src="https://github.com/user-attachments/assets/3d572424-f149-4343-8f4c-24247757176b" width="200">

### ランキング表示
<img src="https://github.com/user-attachments/assets/8996e02b-f30f-45c0-af1a-3e7960cd9693" width="200">

## 設計方針
**画面遷移**

タイトル画面 -> ゲーム画面

ゲーム画面 -> リザルト画面

リザルト画面 -> タイトル画面

**ゲームの簡単さ：** ゲームの方式をターゲットをタッチするだけにすることで、誰でも簡単に遊べるように設計しました。

**見やすさ：** ボタンや背景の色を工夫し、ターゲットやランキングのデータを見やすくしました。

**拡張性：** 現地点だとゲームの難易度が低すぎるため、将来的に得点の異なる複数種類のターゲットが表示されるようにしゲームの難度を少し上げれるようにしたいです

## 工夫したところ、現地点での改善案（1/18）
**ランキング形式を採用：** 自身の上位3位のスコアを掲示することでスコア更新のモチベーションを上げやすくしました。

**ターゲットのモデルが単純すぎる：** ターゲットがただの赤い丸のため、何かしらのキャラクターに変更したいです。（lib/Materailsディレクトリに追加予定）

**一定時間でターゲットが消えるようにする：** 拡張性の機能を実装した場合、タップしない限りターゲットが残り続けてしまうため、一定時間でターゲットが消えるようにする調整したいです。

## 動作環境
Flutter 3.24.3

Tools Dart 3.5.3
