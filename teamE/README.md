# 概要

このブランチをクローンすることで、Ruby3 系＋ Rails6 系＋ MySQL ＋ Docker の環境構築を簡単に行える。

環境構築のコードは以下の記事を参考にして作成しました。  
[docker-compose で Rails 6×MySQL の開発環境を構築する方法](https://tmasuyama1114.com/docker-compose-rails6-mysql-development/)

# 方法

**1. コードを clone するディレクトリに移動する。**  
 注）Downloads、Documents、Desktop の使用は避ける。理由は、Docker で NFS をマウントする際に、エラーが発生することがあるからです。  
 https://objekt.click/2019/11/docker-the-problem-with-macos-catalina/  
 https://qiita.com/dmrt/items/b9aab190840c4854f219

**2. ブランチを指定して clone する。**

```
git clone -b [ブランチ名][リポジトリのアドレス]
git clone -b rails6_docker git@github.com:vareal/SDD_Standard.git
```

**3. プロジェクトのディレクトリ名を SDD_Standard から好みの名前に変更する。**

例）  
before  
<kbd><img src="https://i.gyazo.com/81a9dfbca8be03f880727e576c25454e.png" width="150px"></kbd><br>
after  
<kbd><img src="https://i.gyazo.com/7e960fd2cf97cff82bcaebaeaf2fa2ef.png" width="160px"></kbd><br>

**4. GitHub にリポジトリを作成する。**

<kbd><img src="https://i.gyazo.com/c52049b4e41dfcbfd6c03836fad6c0ae.png" width="500px"></kbd><br>

**5. でプロジェクトのディレクトリに移動する。既存の origin を削除してから、再度 origin を登録し直す。**  
 https://qiita.com/hatorijobs/items/1cae1946656ece954c63

```
git remote rm origin
git remote add origin git@github.com:ユーザ名/リポジトリ名.git
```

<kbd><img src="https://i.gyazo.com/225622a053f31b3551d8b56ba2e3dd5d.png" width="500px"></kbd>

**6. ブランチ名を main に変更し、リモートリポジトリにコードを push する。**

```
git branch -M main
git push -u origin main
```

<kbd><img src="https://i.gyazo.com/371f7aa4144adfff03b407805ca83b91.png" width="500px"></kbd>

**7. ローカル DB を設定する。**

```
docker-compose run --rm web rails db:reset
```

**8. イメージを構築し、コンテナを起動する。**

```
docker-compose build
docker-compose up
```

<kbd><img src="https://i.gyazo.com/2054526e03bfac32d1c8d4c68bafd638.png" width="500px"></kbd>

**9. http://localhost:3000/ <span>にアクセスする。</span>**

=>完成！！！  
<kbd><img src="https://i.gyazo.com/230cc9564b5da741ba4a275e42160a75.png" width="500px"></kbd>

# 各種知識

## Docker

```
# コンテナ起動
docker-compose up

# コンテナ停止
docker-compose down

# コンテナに入る
docker-compose run --rm web bash

# コンテナに入る + コンソール起動
docker-compose run --rm web bundle exec rails c

# イメージの再構築（gem を追加した後などに実行する。）
docker-compose build

# イメージの再構築（うまくいかずに最初からやり直したいとき）
docker-compose build --no-cache
```

## ローカル DB の再設定

```
docker-compose run --rm web bundle exec rails db:reset
# seed ファイルがあれば、その読み込みも行われる
```

## RuboCop

```
# 修正箇所指摘
docker-compose run --rm web bundle exec rubocop

# 修正箇所指摘 + 自動修正
docker-compose run --rm web bundle exec rubocop -A

# 特定のファイルのみ実行
docker-compose run --rm web bundle exec rubocop app/xxx/xxx.rb
```

## binding.pry でデバッグ

```
docker psでRailsが動いているコンテナを確認し、そのIDをコピーする。
docker attach <コンテナID> を実行する。
binding.pryを挿入している箇所になるとデバッグモードが起動する。
exitでデバッグモードを終了する。ループして終了できないときは!!!で終了する。
```

## RSpec

```
# 全テスト実行
docker-compose run --rm web bundle exec rspec

# 特定のファイルのみ実行
docker-compose run --rm web bundle exec rspec spec/xxx/xxx_spec.rb

# 特定のケースのみ実行 (実行するブロックの行番号を付与)
docker-compose run --rm web bundle exec rspec spec/xxx/xxx_spec.rb:1
```

## credentials の編集

```
docker-compose run --rm web bundle exec rails credentials:edit
```

## Git

- GUI（無理にコマンドで実行しなくても、意外と GUI でできることは多い）  
  [VSCode での Git の基本操作まとめ](https://qiita.com/y-tsutsu/items/2ba96b16b220fb5913be)  
  [Sourcetree](https://www.sourcetreeapp.com/)
- 便利情報  
  [git のコマンドを短くする方法](https://vareal.esa.io/posts/18945)

## データベースの GUI ツール

- MySQL  
  ↓ER 図を自動作成できて便利  
  [MySQLWorkbench](https://www.mysql.com/jp/products/workbench/)

- PostgreSQL  
  [Postico](https://eggerapps.at/postico/)

## 主な gem 一覧

| gem           | 参照 URL                                       | 機能                 |
| ------------- | ---------------------------------------------- | -------------------- |
| rubocop       | https://github.com/rubocop/rubocop-rails       | コーディングチェック |
| pry-byebug    | https://github.com/deivid-rodriguez/pry-byebug | デバッグ             |
| better_errors | https://github.com/BetterErrors/better_errors  | デバッグ             |
| rspec         | https://github.com/rspec/rspec-rails           | テスト               |
| factorybot    | https://github.com/thoughtbot/factory_bot      | テストデータ作成     |
| faker         | https://github.com/faker-ruby/faker            | ダミーデータ作成     |
| bullet        | https://github.com/flyerhzm/bullet             | N+1 問題チェック     |
| annotate      | https://github.com/ctran/annotate_models       | テーブル情報表示     |

# その他

- rubocop.yml の中身は、各々のプロジェクトに合わせて適宜ご修正ください。
- Rails と OS のタイムゾーンは JST、DB のタイムゾーンは UTC に設定してあります。各々のプロジェクトに合わせて適宜ご修正ください。  
  https://zenn.dev/ryouzi/articles/dda18594f2dbd3
