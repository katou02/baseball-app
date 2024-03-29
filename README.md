# 甲子園ドットコム
高校野球の試合記事、戦力分析、試合予想などを投稿できるアプリです！  
<br>
紹介記事: https://qiita.com/katou02/private/ba6d18b1e39029bbf774
<br>

<img src="https://user-images.githubusercontent.com/56467807/132135325-ba726584-120f-4436-bf9d-1be23133107b.png" height="600" width="1000">
<br>

## 使用した技術

#### バックエンド
• Ruby 2.5.1  
• Rails 5.2.3 (APIモード)  
• RSpec(テスト）

#### フロントエンド
• HTML/CSS  
• JavaScript  
• Vue.js (SPAモード)  
• Chart.js  
• Vuetify  
• JsonWebToken

#### インフラ
• AWS(EC2,S3,VPC,Route53,ALB,ACM,SSM)  
• Docker/Docker-compose  
• CircleCI(CI/CD)  
• Terraform(インフラの一部をコード化)  
<br>
## 工夫点

#### バックエンド
• Ruby on RailsのAPIモードを利用し、APIサーバーとしてフロントエンドからのリクエストに対してJSONデータを返している点  
• トークン認証を利用したログインを実装してる点

#### フロントエンド
• Vue.jsを採用し、SPA（シングルページアプリケーション）で配信している点  
• UIフレームワークにVuetifyを使用し、整ったUIを意識している点  
• Chart.jsを使用しデータをグラフ化している点

#### インフラ
• Terraformを使い、本番環境インフラをコードで管理している点  
<br>
## ER図
<img src="https://user-images.githubusercontent.com/56467807/125237618-f099c500-e320-11eb-8dab-d00d10b988aa.png" height="900" width="900">

## AWS構成図
<img src="https://user-images.githubusercontent.com/56467807/125237831-453d4000-e321-11eb-824b-06c80378c390.png" height="600" width="600">  
<br>

## 機能一覧
|  機能名  |  説明  |
| ---- | ---- |
|  ユーザー機能  |  新規登録、登録内容変更、アバター登録、ログイン、ログアウト  |
|  投稿機能  |  記事、分析、予想、ふるさと紹介の投稿、編集、削除<br>画像も可  |
| 大会別機能 | 記事、分析、予想、ふるさとを大会別に表示 |
| コメント機能 | 記事、分析、予想に対してコメントを投稿、削除 |
| 検索機能 | 各投稿の検索が可能 |
| いいね機能 | 試合記事に対して「いいね」をする |
| 通知機能 | 他ユーザーが自分に対してアクションを起こした時に通知 |
| フォロー機能 | 他ユーザーをフォローする |
| DM機能 | フォローしたユーザーにダイレクトメールを送信 |
| 投稿データ表示機能 | ユーザーページでそのユーザーが投稿したデータを表示 |
|  アンケート機能  |  アンケートを取り集計する  |
| 平均評価機能 | 分析された高校の平均評価を表示 |
| マップ表示機能 | Google Maps APIを使用しマップを表示 |
| ユーザー一覧機能 | 登録しているユーザーを表示 |
| お問い合わせ機能 | Action Mailerを使って管理者にメールを送信 |
