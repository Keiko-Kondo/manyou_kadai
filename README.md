#herokuへのデプロイ方法  

1. $ rails assets:precompile RAILS_ENV=production を記述し、アセットプリコンパイルを行う。  
2. $ git add -A　→　$ git commit -m "init"　にてコミットをする。  
3. $ heroku create　にてherokuに新しいアプリを作成する。  
4. $ git push heroku master　にてherokuにデプロイする。  
