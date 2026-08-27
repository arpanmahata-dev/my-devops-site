# FROM: Start with a lightweight Nginx base image (Alpine = tiny Linux)
FROM nginx:alpine

# LABEL: Add metadata (optional, good practice)
LABEL maintainer="your-email@example.com"
LABEL description="Static website served by Nginx"

# COPY: Copy your website files into the container
# Nginx serves files from /usr/share/nginx/html by default
COPY index.html /usr/share/nginx/html/

# (Optional) Copy custom nginx config
# COPY nginx.conf /etc/nginx/nginx.conf

# EXPOSE: Document which port the app listens on (informational)
EXPOSE 80

# CMD: The command to run when the container starts
# This base image already runs nginx by default, but being explicit helps
CMD ["nginx", "-g", "daemon off;"]