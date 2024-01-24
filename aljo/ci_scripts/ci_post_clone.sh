#!/bin/bash

# PC에 swiftLint 설치하도록 하는 명령어
brew install swiftlint

# 현재 디렉토리에서 프로젝트 디렉토리로 나가도록 설정
cd ..

# Tuist로 의존성 초기화 및 실행
tuist fetch
tuist generate