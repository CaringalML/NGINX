# Use the nginx image as the base image alpine
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
