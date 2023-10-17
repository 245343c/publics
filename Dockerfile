# Stage 1: Build
FROM node:gallium AS build
WORKDIR /app

COPY . /app
RUN yarn && \
    yarn build

# Stage 2: Nginx
FROM nginx:stable

# Copy nginx configuration
COPY ./.nginx/nginx.conf /etc/nginx/nginx.conf

# Remove the default Nginx content
RUN rm -rf /usr/share/nginx/html/*

# Copy built files from the build stage
COPY --from=build /app/dist /usr/share/nginx/html



# Expose port 80
EXPOSE 80