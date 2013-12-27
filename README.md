这是一个使用Rails开发的论坛社区。  
Ruby -v 1.9.3  
Rails -v 3.2.13  
Mysql  


这是我开始学习Rails的时候，边学边写的一个关于骑行旅行的论坛社区(30度阳光)[http://www.30dyg.com]，现在已经关闭，遂把代码开源出来。因为学习Ruby和Rails都不是非常深入（web插班生，一接触web就使用Ruby，学的比较“辛苦”），代码写的有点丑，还有许多地方可以优化。如果你是Rails的初学者，可以clone下来参考学习。  

#####usage
```
git clone git@github.com:tailang/thirtysunshine.git

cp config/database.yml.example config/database.yml

bundle install

bundle exec rake db:create

bundle exec rake db:migrate

rails s
```
如果不出意外，应该可以通过http://localhost:3000访问  
注意:因为使用了carrierwave,图片裁剪需要imagemagick,请安装;  
     devise某些功能等需要邮箱，请修改 config/initializers/devise.rb  config/enviroments/development.rb;  
     如果要部署(使用unicorn)，请修改config/environment/production.rb, config/environment/nginx, config/unicorn.rb。我使用mina进行远程部署，根据自己环境修改部署文件config/deploy.rb. 为了安全不要忘记修改config/initializers/secret_token.rb  


