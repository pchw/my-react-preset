Express使ってreactなアプリを作るためのオレオレquick start環境

- appディレクトリ以下にexpressのinitしたっぽいやつ
- clientディレクトリ以下にreactとapp/public以下にコピーされるもの

を入れた．
`gulp watch`とか`gulp bundle`ってやれば`node app/bin/www`で動く感じのが整う．

```
├── app
│   ├── app.coffee
│   ├── bin
│   │   └── www
│   ├── routes
│   │   ├── index.js
│   │   └── users.js
│   └── views
│       ├── error.jade
│       ├── index.jade
│       └── layout.jade
├── bower.json
├── client
│   ├── bower_components
│   ├── images
│   ├── robot.txt
│   ├── scripts
│   │   ├── index.coffee
│   │   └── template
│   └── styles
│       └── style.styl
├── gulpfile.coffee
├── node_modules
└── package.json
```