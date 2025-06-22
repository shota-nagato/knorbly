# README

RSS リーダーサービス

## 使用技術

### 言語

```
Ruby v3.4.3
Ruby on Rails v8.0.2
Node.js v24.2.0
```

### その他

- Tailwind CSS
- ESBuild
- PostgreSQL

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
