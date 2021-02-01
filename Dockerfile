FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget zsh

# Set up new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Set up Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

# Download Flutter SDK
# RUN git clone https://github.com/flutter/flutter.git
RUN wget -O flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/dev/linux/flutter_linux_1.26.0-1.0.pre-dev.tar.xz
RUN tar xf flutter.tar.xz
ENV PATH "$PATH:/home/developer/flutter/bin"
RUN flutter precache --android

RUN wget -O .zshrc https://raw.githubusercontent.com/tksgi/dotfiles/master/zsh/mainconf.zsh

# Run basic check to download Dark SDK
RUN flutter doctor
