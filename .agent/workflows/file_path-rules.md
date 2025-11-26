---
description: ファイルパスに関するルール
---

このプロジェクトでは、Rails 標準の設定に加えて独自のファイル構成があります。
実装前にこれらのパスの違いを理解し、適切な場所にファイルを配置してください。

## 重要なディレクトリパス

- **ビューディレクトリ**: `app/views/controllers/` - コントローラーに対応するビューファイルはこのディレクトリに配置されています
- **レイアウトファイル**: `app/views/layouts/application.html.erb` - メインのレイアウトファイル
- **コンポーネントディレクトリ**: `app/views/components/` - ViewComponent を使用したコンポーネントが配置されています
- **JavaScript コントローラー**: `app/javascript/controllers/` - Stimulus コントローラー
- **コンポーネントコントローラー**: `app/views/components/[component_name]/component_controller.js` - コンポーネント固有の Stimulus

## ファイル名と配置のルール

1. コントローラーに対応するビューは `app/views/controllers/[controller_name]/` に配置します
2. レイアウト関連のファイルは `app/views/layouts/` に配置します
3. ViewComponent は `app/views/components/` に配置します

## 注意点

- `app/views/` ディレクトリ直下にビューファイルを置かないでください
- コンポーネント固有の JavaScript を作成する場合は、必ず対応するコンポーネントディレクトリ内に `component_controller.js` として配置してください
