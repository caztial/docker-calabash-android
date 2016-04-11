############################################################
# Dockerfile to run Calabash-android acceptance testing testing.
############################################################

FROM ruby:2.3.0

# install jdk

RUN apt-get update
RUN apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*

# Install android sdk

RUN wget http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN tar -xvzf android-sdk_r24.4.1-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk
RUN rm android-sdk_r24.4.1-linux.tgz

# Install Android tools
RUN echo y | /usr/local/android-sdk/tools/android update sdk --filter tools,platform-tools,build-tools-21.1.1,build-tools-21.1.0,android-21,extra-google-google_play_services,extra-android-support,extra-android-m2repository,extra-google-analytics_sdk_v2 --no-ui --force -a

#install android dependencies

RUN apt-get update
RUN apt-get -y install lib32stdc++6 lib32z1 lib32z1-dev

#install calabash-android

RUN gem install calabash-android

ENV ANDROID_HOME /usr/local/android-sdk
ENV GRADLE_HOME /usr/local/gradle
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk
