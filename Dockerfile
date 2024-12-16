FROM ubuntu:24.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone
RUN apt update && apt upgrade -y

WORKDIR /artifact

# 必要なAPTパッケージを適当にインストール
RUN apt update && apt install -y git curl p7zip npm gh
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN source ~/.nvm/nvm.sh
RUN nvm install 22
#libatlas-base-dev cmake ninja-build build-essential pip Python3 venv

# Gitリポジトリを展開しても良い
RUN git clone https://github.com/oss-experiment-uec/2024-a2110013-voicevox.git

#カレントディレクトリ
WORKDIR /artifact/2024-a2110013-voicevox

#インストーラーに実行権限を付与
RUN chmod +x VOICEVOX-CPU.Installer.0.21.1.Linux.sh
RUN ./VOICEVOX-CPU.Installer.0.21.1.Linux.sh
RUN npm -i --cpu arm64
#RUN npm ci
# Dockerfileを実行する場所からファイルをコピーする場合
# COPY . /artifact
