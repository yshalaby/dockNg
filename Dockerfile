#First Stage Build
#start with nodejs image as base image for building the app and give it alias build 
FROM node:lts-alpine3.19 AS build

#set working directory inside the the container
WORKDIR /app
#copy the packages file from the code folder to the orking directory inside the container
COPY packag*.json ./
#run npm install to install node_modules inside the conntainer
RUN  npm install

#copy the code files to the container working directory

COPY . .

#start build angular app inside the container

RUN npm run build --prod

#Final Stage
# uaw nginx image for hosting 
FROM nginx 

#copy dist files to html folder in the new nginx based  container 
COPY --from=build /app/dist/* /usr/share/nginx/html/

#in build you should build with (--tag or -t ) with name 