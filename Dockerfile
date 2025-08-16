FROM n8nio/n8n:latest

USER root

# Instalar nginx
RUN apk add --no-cache nginx supervisor

# Configuração do nginx para remover headers de segurança
RUN mkdir -p /etc/nginx/sites-enabled && \
    echo 'server { \
    listen 8080;
    server_name _; \
    \
    location / { \
        proxy_pass http://localhost:5678; \
        proxy_http_version 1.1; \
        proxy_set_header Upgrade $http_upgrade; \
        proxy_set_header Connection "upgrade"; \
        proxy_set_header Host $host; \
        proxy_set_header X-Real-IP $remote_addr; \
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; \
        proxy_set_header X-Forwarded-Proto $scheme; \
        \
        # Remover headers de segurança \
        proxy_hide_header X-Frame-Options; \
        proxy_hide_header Content-Security-Policy; \
        \
        # Adicionar headers permitindo iframe \
        add_header X-Frame-Options ""; \
        add_header Content-Security-Policy ""; \
    } \
}' > /etc/nginx/http.d/default.conf

# Configuração do supervisor para rodar nginx e n8n
RUN echo '[supervisord] \n\
nodaemon=true \n\
\n\
[program:nginx] \n\
command=nginx -g "daemon off;" \n\
autostart=true \n\
autorestart=true \n\
stderr_logfile=/var/log/nginx.err.log \n\
stdout_logfile=/var/log/nginx.out.log \n\
\n\
[program:n8n] \n\
command=n8n \n\
autostart=true \n\
autorestart=true \n\
user=node \n\
environment=HOME="/home/node",USER="node" \n\
stderr_logfile=/var/log/n8n.err.log \n\
stdout_logfile=/var/log/n8n.out.log' > /etc/supervisord.conf

EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
