FROM nginx:1.27.3

# Set user and group to use when running the container
ARG USER
ARG UID
ARG GROUP
ARG GID

# Add user and group
RUN addgroup --gid $GID $GROUP
RUN adduser --disabled-password --gecos '' --uid $UID --gid $GID $USER

# Set working directory
WORKDIR /app

# Give ownership of the working directory to the user
RUN chown -R $USER:$GROUP /app && chmod -R 755 /app && \
    chown -R $USER:$GROUP /var/cache/nginx && \
    chown -R $USER:$GROUP /var/log/nginx && \
    chown -R $USER:$GROUP /etc/nginx/conf.d
RUN touch /var/run/nginx.pid && \
    chown -R $USER:$GROUP /var/run/nginx.pid

# Run the container as the user
USER $USER

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
