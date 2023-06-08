#!/bin/sh

# コンテナ新規作成時の一連の作業

eval "$(rbenv init -)"

cd $_RAILS_DIR

# reactインストール
yarn add react react-dom axios html-react-parser react-markdown remark-gfm rehype-raw rehype-sanitize
# jest系インストール（本体、babel、react対応、TypeScript対応）
yarn add --dev jest babel-jest @babel/core @babel/preset-env @babel/preset-react react-test-renderer @babel/preset-typescript

# Bundler経由でのrailsインストール
bundle init
bundle install --path vendor/bundle
# Rails は bundler 配下の管理とする。
bundle exec rails new . --force --database=postgresql -j esbuild --skip-hotwire
rm ./Gemfile.lock
bundle install --path vendor/bundle
bundle lock --add-platform x86_64-linux
# bundle exec bin/rails importmap:install # 二度目以降は不要な作業のためコメントアウト

# DB作成
bundle exec rails db:create

exit 0
