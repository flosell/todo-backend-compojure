FROM java:8-jre-alpine

COPY target/todo-backend-compojure-standalone.jar .

CMD java -jar todo-backend-compojure-standalone.jar 80
