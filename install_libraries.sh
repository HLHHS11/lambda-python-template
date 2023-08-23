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

# ラムダ関数のディレクトリに移動
cd "./lambda/$LAMBDA_FUNCTION_NAME"

# 仮想環境に入って依存関係をインストール
source ./.venv/bin/activate
pip3 install -r ./requirements.txt
deactivate