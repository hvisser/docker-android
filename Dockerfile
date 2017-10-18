FROM openjdk:8-jdk
MAINTAINER Hugo Visser "hugo@littlerobots.nl"

RUN apt-get -q update &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends unzip \
    curl &&\
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin

RUN mkdir -p /opt/android-sdk/tools &&\
    curl https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip > /opt/android-sdk/tools.zip &&\
    unzip /opt/android-sdk/tools.zip -d /opt/android-sdk &&\
    rm /opt/android-sdk/tools.zip &&\
    mkdir /opt/android-sdk/licenses &&\
    ANDROID_HOME=/opt/android-sdk yes | /opt/android-sdk/tools/bin/sdkmanager --licenses

ENV ANDROID_HOME /opt/android-sdk
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
