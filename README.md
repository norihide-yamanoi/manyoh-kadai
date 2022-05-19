## Userモデル  

|カラム名|データ型|
|:--:|:--:|
|name|string|
|email|string|
|password_digest|string|

## Taskモデル

|カラム名|データ型|
|:--:|:--:|
|name|string|
|detail|text|
|dead_line|string|
|priority|string|
|status|string|

## Labelモデル

|カラム名|データ型|
|:--:|:--:|
|name|string|


## Herokuのデプロイの手順

1.アプリのrootの設定

2.Herokuに新しいアプリケーションを作成する　　

$ heroku create

3.コミットする

$ git add -A  
$ git commit -m "コメント"

4.Heroku buildpackを追加する

$ heroku buildpacks:set heroku/ruby  
$ heroku buildpacks:add --index 1 heroku/nodejs

5.Herokuにデプロイをする  

$ git push heroku master
