#!/usr/bin/env sh
# 确保脚本抛出遇到的错误
set -e
npm run build # 生成静态文件
cd docs/.vuepress/dist # 进入生成的文件夹

# deploy to github
# echo 'blog.xugaoyi.com' > CNAME
if [ -z "$GITHUB_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:simonzhangs/awesome-fe-interview.git
else
  msg='来自github action的自动部署'
  githubUrl=https://simonzhangs:${GITHUB_TOKEN}@github.com/simonzhangs/awesome-fe-interview.git
  git config --global user.name "simonzhangs"
  git config --global user.email "2863389578@qq.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master  # 推送到github 主分支
# git push -f $githubUrl master:gh-pages # 推送到github

cd -
rm -rf docs/.vuepress/dist
