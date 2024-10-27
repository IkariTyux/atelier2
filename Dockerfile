# Base de l image docker
FROM nginx
COPY --from=pandoc/minimal:2.19.2 /pandoc /usr/bin/pandoc

# Mise en place dans le serveur nginx
COPY webserver /usr/share/nginx/html
COPY nginx.conf /etc/nginx/site-enabled/default.conf

# Génération du site html a partir du markdown
RUN /usr/bin/pandoc -s /usr/share/nginx/html/index.md --template /usr/share/nginx/html/template.html -o /usr/share/nginx/html/index.html && /usr/bin/pandoc -t docx -s /usr/share/nginx/html/index.md -o /usr/share/nginx/html/index.docx

# Lancement de nginx
ENTRYPOINT /usr/sbin/nginx -g 'daemon off;'
