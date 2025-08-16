#!/bin/sh
set -e

# Sobe o nginx em segundo plano
nginx

# Executa o n8n como processo principal
exec n8n
