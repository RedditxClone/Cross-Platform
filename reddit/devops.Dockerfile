FROM instrumentisto/flutter:3.3.7 AS build

WORKDIR /app

COPY ./ /app

RUN flutter doctor

RUN flutter build web --dart-define=BASE_URL=https://swproject.demosfortest.com/api/ --dart-define=MEDIA_URL=https://static.swproject.demosfortest.com/

FROM nginx:latest

COPY --from=build /app/build/web/ /usr/share/nginx/html

EXPOSE 80
