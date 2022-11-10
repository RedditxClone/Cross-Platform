FROM instrumentisto/flutter:3.3.7

WORKDIR /app

COPY ./ /app

RUN flutter doctor

RUN flutter build web --dart-define=BASE_URL=${BASE_URL} --web-port=5000

EXPOSE 5000
