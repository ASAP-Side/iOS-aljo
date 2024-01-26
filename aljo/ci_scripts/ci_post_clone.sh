#!/bin/bash

# PC에 swiftLint 설치하도록 하는 명령어
# brew install swiftlint

brew update
brew install carthage

# Tuist 설치 명령어
echo "➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖"
echo "🔨 Install Tuist"
curl -Ls https://install.tuist.io | bash

# 현재 디렉토리에서 프로젝트 디렉토리로 나가도록 설정
cd ..

# Tuist로 의존성 설치
echo "➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖"
echo "💉 Clean & Fetch Libraries"
tuist clean
tuist fetch

# Tuist 프로젝트 생성
echo "➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖➖"
echo "✅ Generate Tuist XCWorkSpace"
tuist generate