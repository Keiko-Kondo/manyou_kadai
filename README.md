#herokuへのデプロイ方法  

1. $ rails assets:precompile RAILS_ENV=production を記述し、アセットプリコンパイルを行う。  
* $ git add -A　→　$ git commit -m "init"　にてコミットをする。  
* $ heroku create　にてherokuに新しいアプリを作成する。  
 $ git push heroku master　にてherokuにデプロイする。  
