#!/bin/bash

# コマンドライン引数からLambda関数の名前を取得
LAMBDA_FUNCTION_NAME="$1"

# ファイル・ディレクトリのパス
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZIP_FILE_PATH="$SCRIPT_DIR/dist/$LAMBDA_FUNCTION_NAME.zip"
LAMBDA_DIR="$SCRIPT_DIR/lambda/$LAMBDA_FUNCTION_NAME"

# すでに存在しているzipファイルを削除
rm "$ZIP_FILE_PATH"

# ラムダ関数のディレクトリに移動
cd "$LAMBDA_DIR"

# 仮想環境内のモジュールファイルをzipに格納
# TODO: pythonのバージョンも指定できるようにする
cd .venv/lib/python3.10/site-packages
zip -r "$ZIP_FILE_PATH" .

# ソースコードをzipに格納
cd "$LAMBDA_DIR/src"
zip -r -g "$ZIP_FILE_PATH" .

# Lambda関数の更新
aws lambda update-function-code --function-name "$LAMBDA_FUNCTION_NAME" --zip-file "fileb://$SCRIPT_DIR/dist/$LAMBDA_FUNCTION_NAME.zip"