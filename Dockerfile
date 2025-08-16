FROM n8nio/n8n:latest

USER root

# Instala nginx (imagem base do n8n é Debian)
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Configuração do nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Script de inicialização
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

# Sobe nginx e depois o n8n
CMD ["/start.sh"]
