# README

This README would normally document whatever steps are necessary to get the
application up and running.

## 環境構築

### Docker Compose を使った開発環境のセットアップ

1. **Docker イメージのビルド**

   ```bash
   docker compose build
   ```

2. **データベースの作成**

   ```bash
   docker compose run --rm web rails db:create
   ```

3. **マイグレーションの実行**

   ```bash
   docker compose run --rm web rails db:migrate
   ```

4. **JavaScript パッケージのインストール**

   ```bash
   docker compose run --rm web yarn install
   ```

5. **アプリケーションの起動**
   ```bash
   docker compose up
   ```

アプリケーションは http://localhost:3000 でアクセスできます。

### 一括セットアップ

初回セットアップを一括で行う場合：

```bash
docker-compose build
docker-compose run --rm web rails db:create db:migrate
docker-compose run --rm web yarn install
docker-compose up
```

Things you may want to cover:

- Ruby version

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

## View Components

このプロジェクトでは view_component を使用してコンポーネントベースの UI 開発を行っています。

### コンポーネントの自動生成

新しい view_component を作成する場合は、以下のコマンドを使用してください：

```bash
rails g view_component コンポーネント名 [option]
```

例：

```bash
rails g view_component Button
rails g view_component Card title content
```

このコマンドにより、コンポーネントクラスファイル（.rb）とテンプレートファイル（.html.erb）が自動生成されます。

- ...
