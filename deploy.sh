#!/bin/bash


webDeploy() {
  echo "🍏 Web build started" 

  flutter build web --base-href /$REPOSITORY_NAME/

  rsync -av --remove-source-files build/web/ docs/

  git add .

  open -n -a "Google Chrome.app" --args https://sushiosushi.github.io/zapland_web/$REPOSITORY_NAME  --profile-directory="Profile 3"

  echo "🍏 Web build completed"
}


# Increment version
perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml

source .env
# Deploy
webDeploy &

wait
echo "A build finished 🎉🎉🎉"