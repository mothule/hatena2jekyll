# hatena2jekyll
the tool is converter to jekyll from hatena blog.
hatena blog is blog service in japan.
so, this repository will write japanese.

はてなブログのエクスポートのMovableType型式のテキストデータからJekyll向けMarkdown型式に変換するスクリプトです。

## 内容
MovableTypeとしてパース後に
不要な情報やフィルタリング、使用しているmarkdown変換ツールに適した型式に差し替えています。

## 使い方
特に汎用的な作りにしていません。
必要に応じて改修してください。
対象ファイルや出力先、ローカルにコードダウンロードしてから、main.rbを実行することで内部でハードコーディングされたファイルに対して
_posts/フォルダに記事別でmarkdownファイルを出力します。

## 備考
もともと個人のブログ移行目的に用意したスクリプトなので、コードも何もかもてきとうです。
ただニーズが意外と多いのであれば、少しばかりメンテしやすいコードにするかもしれません。
