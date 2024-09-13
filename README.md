# Sinatraプロジェクトのサンプル
Sinatraを使用する際の雛形の一例を置いておきます。

## セットアップ方法

セットアップ方法は以下の通りです。

`Docker`を起動してから以下の説明に従ってください。（`Docker`をインストールしていない方は[こちらから](https://matsuand.github.io/docs.docker.jp.onthefly/get-started/#download-and-install-docker)）

```
// コンテナイメージをビルド
$ make compose/build

// DBを構築
$ make db/setup

// コンテナを起動
$ make compose/up

// マイグレーション
$ make db/migrate
```

## 技術構成

| 技術         | 役割           |
| ------------ | -------------- |
| Ruby 3.1.4   | 言語           |
| Sinatra      | フレームワーク |
| ActiveRecord | ORM            |
| PostgreSQL   | DB             |
| Docker       | 動作環境       |

## ディレクトリ構成

ディレクトリ構成は以下の通りです。

```
.
├── config/
│   └── database.yml (DBの設定)
│
├── db/
│   ├── migrate/
│   ├── scheme.rb
│   └── seeds.rb
│
├── models/ (modelを定義するファイルを配置)
│
├── routes/ (routeを分割して配置)
│
├── app.rb
├── base.rb
├── config.ru
├── Gemfile
├── Gemfile.lock
├── Makefile (makeコマンドの定義)
├── Rakefile
├── Dockerfile
├── compose.yml
└── README.md
```

### modelsディレクトリ

一つのファイルにモデルを定義するのではなく、分割して定義します。
これにより今後開発人数が増えた際のコンフリクトを抑えたいからです。(今プロジェクトではタスクを細かく分けるため)

Userテーブルを作成した場合には、`user.rb`というファイルを作成し、そこにモデルを定義してください。

以下のコマンドでモデル定義のファイルを作成できます。

```
// モデル名は単数形です
$ make g/model name=モデル名
```

### routesディレクトリ

`app.rb`が肥大化する可能性や、複数人数によるコンフリクトを抑えるため、routesも分割して定義します。
`routes`ディレクトリに定義したルートは`app.rb`で呼び出すことで使用可能です。

以下のコマンドでルート作成ファイルを定義できます。

```
// ルート名は複数形です
$ make g/route name=ルート名
```

### base.rb

`base.rb`を作成することで、全てのルートで共通した処理を定義しています。

## コマンド集

使用する主なコマンドは以下のとおりです。

| コマンド                    | 内容                     |
| -------------------------- | ----------------------- |
| make compose/build         | Dockerのビルド           |
| make compose/up            | Dockerを起動             |
| make db/migrate            | マイグレーション           |
| make db/seed               | シード実行                |
| make g/migrate name=名前   | マイグレーションファイル生成  |
| make g/model name=モデル名  | モデル定義ファイル作成       |
| make g/route name=ルート名  | ルート定義ファイル作成       |
