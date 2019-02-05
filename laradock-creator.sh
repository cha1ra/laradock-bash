# 最初の1行目には #!/bin/bash を必ず書く
# Shell Scriptを記述するということを伝える
# #...hash, !...bang なので #! を shebangと呼ぶ

#!/bin/bash

# $1 ... 第1引数

#-----------------------
#Variable
#-----------------------

PRJ_NAME=$1
SQL_VERSION="5.7"

#-----------------------
#Function
#-----------------------

error_msg() {
    # 文字色を変更 \e[色属性m
    # 0 Black, 1 Red, 2 Green, 3 Yellow, 4 Blue, 5 Magenda
    echo ""
    echo -e "\033[0;31m------------ERROR!------------\033[0;39m"
    echo -e "\033[0;31m$1\033[0;39m"
    echo "Stop this operation."
    echo -e "\033[0;31m------------------------------\033[0;39m"
    exit 1
}


echo -e "
\033[0;35m
++++++++++++++++++++++++++++++
    LARADOCK CREATOR v1.0
Build Laravel env in 10 steps
      by don-bu-rakko
++++++++++++++++++++++++++++++\033[0;39m
"

echo "1. Start Laradock Setup ..."
echo ""

if [ "$PRJ_NAME" = "" ]; then
    echo -e "\033[0;35m[!] Put your Project Name:\033[0;39m"
    read PRJ_NAME
    echo ""
fi

echo "2. Create Project: $PRJ_NAME "
echo ""


echo "3. Make $PRJ_NAME directory"

# ディレクトリがすでに存在した場合、終了する
# if [-e {ディレクトリパス}]; then ....
# -e ... exist
if [ -e "./$PRJ_NAME" ]; then
    error_msg "'$PRJ_NAME' directory already exists!"
fi
mkdir $PRJ_NAME
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

cd "./$PRJ_NAME"

# laradockのインストール
echo "4. Install Laradock from GitHub ... "
git clone https://github.com/LaraDock/laradock.git
# mkdir laradock #FIXME: for Debug
# echo "MYSQL_VERSION=latest   hoheohoehoeoe" > laradock/env-example #FIXME: for Debug
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

cd laradock
cp env-example .env

echo "5. Change MySQL Version to $SQL_VERSION"

if [ ! "$(grep MYSQL_VERSION=latest .env)"="" ]; then
    error_msg "Error occurs when scripts try to override SQL configurations."
fi
sed -i -e "s/MYSQL_VERSION=latest/MYSQL_VERSION=$SQL_VERSION/" .env
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

echo "6. Build Docker containers..."

if ! type docker 2>/dev/null 1>/dev/null 
then
    error_msg "Docker doesn't exists on your computer! Please install Docker first"
fi

docker-compose up -d nginx mysql phpmyadmin
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

echo "7. Build Laravel project..."
echo "This process will take several minutes."
docker-compose exec --user=laradock workspace composer create-project laravel/laravel src
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

echo "8. Overwrite .env file in Laravel project..."
docker-compose exec workspace sed -i -e "s/DB_HOST=127.0.0.1/DB_HOST=mysql/" src/.env
docker-compose exec workspace sed -i -e "s/DB_DATABASE=homestead/DB_DATABASE=default/" src/.env
docker-compose exec workspace sed -i -e "s/DB_USERNAME=homestead/DB_USERNAME=default/" src/.env
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

echo "9. Overwrite .env file in Laradock..."
sed -i -e "s/APP_CODE_PATH_HOST=..\//APP_CODE_PATH_HOST=..\/src\//" .env
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

echo "10. Restart Docker Containers"
docker-compose stop
docker-compose up -d nginx mysql phpmyadmin
echo -e "\033[0;35mSuccess!\033[0;39m"
echo ""

echo "
Congratulations!
Finish installing & setting up Laradock Environment successfully!
"
exit 0
