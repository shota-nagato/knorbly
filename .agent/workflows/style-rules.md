---
description: スタイルに関するルール
---

- テキスト・カラーに関するスタイルは必ず`application.tailwind.css`で定義しているものを利用する
- ボタンなどのコンポーネントは`views/components`配下で定義されていないかを確認・定義されていればそれを利用する
- svg iconを利用する場合は`app/helpers/icon_helper`の`icon`メソッドを利用すること
  - 利用したいiconファイルが`app/assets/svgs/`内に存在しない場合は実装を中断してその旨を伝えること