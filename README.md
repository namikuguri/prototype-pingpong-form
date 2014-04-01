# Prototype PingPong Form

## Development
### start
```sh
$ grunt
# grunt watch タスクを実行。
# http://localhost:8080/ を開く。
# slim, scss ファイルを監視して自動コンパイル、ファイル変更の際にページを再読み込みする。
```

### completion
スタイルガイドに変更がある時は `grunt deploy` を実行する:

```sh
$ grunt deploy
# grunt styleguide タスクを実行。
# ファイルの変更に合わせて http://localhost:8080/docs/styledocco/ を更新。
```

変更が無い時は `git add` => `git commit` のいつもの流れ。

## スタイルガイド
[StyleDocco](http://jacobrask.github.io/styledocco/) を使ってる。

`/* hoge */` ではなく `// hoge` の形式でコメントを書く。( `/* hoge */` の形式で書くとコンパイル後の CSS にコメントとして残ってしまうため。 )

Style Guide ページでは、`#form-modules` 内の `.docs` 、`.codes` がちゃんと関連づくようにスタイルガイドを書く。
以下のように書くと `form-field-header-optional` が `Form Required` の項目内に入ってしまうので良くない:

```css
// # Form Parts Text
// ```
// <div class="form-parts-cover"><input class="form-parts-text" placeholder="Placeholder" type="text"></div>
// ```
.form-parts-text {
  ...
}

.form-parts-checkbox {
  ...
}

// # hoge
```
