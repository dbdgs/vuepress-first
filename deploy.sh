#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github
echo 'b.dbdgs.cn' > CNAME
if [ -z "$TOKEN_GITHUB" ]; then
  msg='deploy'
  githubUrl=git@github.com:dbdgs/dbdgs.github.io
else
  msg='来自github actions的自动部署'
  githubUrl=https://dbdgs:${TOKEN_GITHUB}@github.com/dbdgs/dbdgs.github.io
  git config --global user.name "DaBai"
  git config --global user.email "legege007@yeah.net"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github

cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist