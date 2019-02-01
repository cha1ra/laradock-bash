# 最初の1行目には #!/bin/bash を必ず書く
# Shell Scriptを記述するということを伝える
# #...hash, !...bang なので #! を shebangと呼ぶ

#!/bin/bash




echo "Start Laradock Setup ..."

# $1 ... 第1引数
PRJ_NAME=$1

if [ "$PRJ_NAME" = "" ]; then
    echo "Enter your Project Name: "
    read NAME
fi

echo "Start Creating Project: $PRJ_NAME"

echo "tttttt"


# ディレクトリの作成
if [ -e $PRJ_NAME ]; then
    echo "match"
fi
# mkdir $NAME
cd $PRJ_NAME

# laradockのインストール
# git clone ...
# mkdir laradock #あとで消す
cd laradock


exit 0;
