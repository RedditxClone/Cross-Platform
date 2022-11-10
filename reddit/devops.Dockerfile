FROM instrumentisto/flutter:3.3.7

WORKDIR /app

COPY ./ /app

RUN flutter doctor

RUN flutter build web

EXPOSE 5000
