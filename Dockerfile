FROM n8nio/n8n:latest

USER root

# Instala nginx usando o gerenciador disponível (apk ou apt)
RUN if command -v apk >/dev/null 2>&1; then \
      apk add --no-cache nginx; \
    else \
      apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*; \
    fi

# Copia a config e coloca no local certo, cobrindo variantes (conf.d e http.d)
COPY nginx.conf /tmp/nginx.conf
RUN mkdir -p /etc/nginx/conf.d /etc/nginx/http.d && \
    cp /tmp/nginx.conf /etc/nginx/conf.d/default.conf && \
    cp /tmp/nginx.conf /etc/nginx/http.d/default.conf && \
    rm -f /tmp/nginx.conf

# Script de inicialização
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
