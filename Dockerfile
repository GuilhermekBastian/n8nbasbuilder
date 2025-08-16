FROM n8nio/n8n:latest

USER root

# Instala nginx (compatível com Debian ou Alpine)
RUN if command -v apk >/dev/null 2>&1; then \
      apk add --no-cache nginx; \
    else \
      apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*; \
    fi

# Copia a config e instala em caminhos compatíveis
COPY nginx.conf /tmp/nginx.conf
RUN mkdir -p /etc/nginx/conf.d /etc/nginx/http.d && \
    cp /tmp/nginx.conf /etc/nginx/conf.d/default.conf || true && \
    cp /tmp/nginx.conf /etc/nginx/http.d/default.conf || true && \
    rm -f /tmp/nginx.conf

EXPOSE 8080

# Sobe nginx (daemon) e mantém n8n em primeiro plano
CMD ["/bin/sh", "-lc", "nginx && exec n8n"]
