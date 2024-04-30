FROM nginx:alpine

RUN apk add --no-cache imagemagick

WORKDIR /usr/share/nginx/html

COPY src/ .

# Optimize all JPEG and PNG images
RUN find . -type f \( -iname \*.jpg -o -iname \*.png \) -exec sh -c 'convert "$1" -strip -quality 10% "$1"' _ {} \;

# Expose port 80 to the host
EXPOSE 80

# Start Nginx and keep it running in the foreground
CMD ["nginx", "-g", "daemon off;"]
