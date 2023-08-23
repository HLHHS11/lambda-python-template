#!/bin/bash
# jqのインストールが必要

# シェルスクリプトが置かれているディレクトリのパスを取得
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Lambdaのディレクトリに移動
cd "$SCRIPT_DIR/lambda"

# コマンドライン引数からLambda関数の名前を取得
LAMBDA_FUNCTION_NAME="$1"

# コマンドライン引数からテスト用JSONの名前を取得
JSON_NAME="$2"

# 関数名とエンドポイントURLの対応表JSONを取得
ENDPOINTS_FILE="endpoints.json"
ENDPOINT_URL=$(cat ./endpoints.json | jq -r ".\"$LAMBDA_FUNCTION_NAME\"") # 変数を展開しながらエスケープ

FILE_CONTENT=$(cat ./$LAMBDA_FUNCTION_NAME/test/in/$JSON_NAME)

curl -X POST -H "Content-Type: application/json" \
  -d "$FILE_CONTENT" \
  $ENDPOINT_URL
