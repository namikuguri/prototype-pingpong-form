# Prototype PingPong Form

## Development
start => deploy => doc の順で回す。

### start
```sh
$ grunt
# grunt watch タスクを実行。
# http://localhost:8080/ を開く。
# slim, scss ファイルを監視して自動コンパイル、ファイル変更の際にページを再読み込みする。
```

### deploy
`grunt deploy` で `validation` 処理したり、CSS のプロパティに `prefix` をつけたりする:

```sh
$ grunt deploy
# grunt htmllint, csslint, autoprefixer タスクを実行。
```

### doc
`README.md` やスタイルガイドに変更がある時は `grunt doc` を実行する:

```sh
$ grunt doc
# grunt styleguide タスクを実行。
# ファイルの変更に合わせて http://localhost:8080/docs/styledocco/ を更新。
```

変更が無い時は `git add` => `git commit` のいつもの流れ。

## スタイルガイド
[StyleDocco](http://jacobrask.github.io/styledocco/) を使ってる。

### contents to be included
各ファイルの先頭にはファイル名を書く。そして、このボックスにはファイルに含めるモジュールのことについて書く:

```
// # Base
// ここではできるだけ User Agent Style に上書きするようなスタイルのみ書くように心がけましょう
```

ページ固有のスタイルシートの場合は `( Page ) {file-name}` のように書く:

```
// # ( Page ) Signup
// 新規会員登録ページで使うモジュール
```

### format
`/* hoge */` ではなく `// hoge` の形式でコメントを書く。( `/* hoge */` の形式で書くとコンパイル後の CSS にコメントとして残ってしまうため。 )

### insertion position
Style Guide ページでは、`#form-modules` 内の `.docs` 、`.codes` がちゃんと関連づくようにスタイルガイドを書く。
以下のように書くと `form-input-checkbox` が `Form Input Text` の項目内に入ってしまうので良くない:

```css
// # Form Input Text
.form-input-text {
  ...
}

.form-input-checkbox {
  ...
}

// # Form Input Radio
```
