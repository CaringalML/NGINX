# NGINX
This is the Official NGINX Web Server docker container for .Net Web API port 5000, working 100% in AWS ECS Fargate (serverless)


Replace the nginx.conf with this if your running in local environment like docker desktop:


worker_processes 1;

events { worker_connections 1024; }

http {

    sendfile on;

    upstream web-site {
        server host.docker.internal:5000;
    }

    server {
        listen 80;
        server_name $hostname;
        location / {
            proxy_pass         http://web-site;
            proxy_redirect     off;
            proxy_http_version 1.1;
            proxy_cache_bypass $http_upgrade;
            proxy_set_header   Upgrade $http_upgrade;
            proxy_set_header   Connection keep-alive;
            proxy_set_header   Host $host;
            proxy_set_header   X-Real-IP $remote_addr;
            proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header   X-Forwarded-Proto $scheme;
            proxy_set_header   X-Forwarded-Host $server_name;
        }
    }
}

