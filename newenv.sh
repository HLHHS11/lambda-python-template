#!/bin/bash

# コマンドライン引数からLambda関数の名前を取得
LAMBDA_FUNCTION_NAME="$1"

# Lambda関数の名前が指定されていなければエラー
if [ -z "$LAMBDA_FUNCTION_NAME" ]; then
  echo "Lambda関数の名前を指定してください。"
  exit 1
fi


# シェルスクリプトが置かれているディレクトリに移動
cd "$(dirname "${BASH_SOURCE[0]}")"

# ラムダ関数用のディレクトリを作成し移動
mkdir "./lambda/$LAMBDA_FUNCTION_NAME"
cd "./lambda/$LAMBDA_FUNCTION_NAME"

# ソースコードディレクトリを作成
mkdir "./src"
touch "./src/lambda_function.py"
cat <<EOF > "./src/lambda_function.py"
import json

def lambda_handler(event, context):
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
EOF

# テスト用ディレクトリを作成
mkdir "./test"
mkdir "./test/in"
mkdir "./test/out"

# requirements.txtを作成
touch "./requirements.txt"

# 仮想環境を作成
python3 -m venv .venv