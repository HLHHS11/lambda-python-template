# AWS Lambda Python開発用テンプレート
ASW Lambdaの開発において，シェルスクリプトを利用して開発環境の構築やデプロイを一部自動化するテンプレートです。  

事前に`aws cli`のインストール及びセットアップ（APIキーの設定など）を行っておいてください。  

## Lambdaのローカル開発環境の構築 ([`newenv.sh`](newenv.sh))
[`newenv.sh`](newenv.sh)を利用します。以下のように，コマンドライン引数にラムダ関数の名前を指定して，シェルスクリプトを実行します。  
``` sh
./newenv.sh <LAMBDA_FUNCTION_NAME>
```
これを実行すると，[`lambda`ディレクトリ](lambda)内に以下のようなファイルが生成されます。  
```
lambda
├── foo_function
    ├── requirements.txt
    ├── src
    │   └── lambda_function.py
    └── test
        ├── in
        └── out

```
各ファイルの説明:  
- `requirements.txt`: lambdaランタイムで使用するライブラリの情報を記す。[`install_libraries.sh`](install_libraries.sh)でライブラリのインストールをする際に使用する。  
- `lambda_fucntion.py`: lambda関数のエントリポイント。コードの雛形も書き込まれている。  
- `test`ディレクトリ: [`test.sh`](test.sh)の実行時に使用。

## Lambda関数ランタイムに対するPythonライブラリのインストール ([`install_libraries.sh`](install_libraries.sh))
コマンドライン引数で指定したラムダ関数について，ラムダ関数のディレクトリ直下に置かれた`requirements.txt`をもとにライブラリのインストールを行います。
``` sh
./install_libraries.sh <LAMBDA_FUNCTION_NAME>
```

## Lambda関数のデプロイ ([`deploy.sh`](deploy.sh))
コマンドライン引数で指定した名前のラムダ関数をデプロイします。  
``` sh
./deploy.sh <LAMBDA_FUNCTION_NAME>
```

## Lambda関数のテスト ([`test.sh`](test.sh))
Lambdaの関数URLを利用したAPIを開発する場合に，各Lambdaディレクトリ内の`test`ディレクトリ内部に用意されたテストケースを用いてテストします。  
**TODO: ちゃんとしたテストツールを導入したい。一応outディレクトリも作ってあるが，返ってきた値の自動検証機能はついていない。**
各Lambda関数URLの対応表を，[`lambda/endpoints.json`](lambda/endpoints.json)内に書き込んでおいてください。（key: ラムダ関数名，value: 関数URLエンドポイント）
``` sh
./test.sh <LAMBDA_FUNCTION_NAME> <JSON_NAME>
```
第1引数: テストしたいLambda関数の名前，第2引数: テストに用いるインプットファイルの名前
