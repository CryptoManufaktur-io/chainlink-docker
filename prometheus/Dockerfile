FROM prom/prometheus


COPY ./prom-with-vars.yml /etc/prometheus/
COPY ./prometheus-fill-scrape-vars.sh /usr/local/bin/

ENTRYPOINT prometheus-fill-scrape-vars.sh
CMD ["/bin/prometheus", "--storage.tsdb.path=/prometheus", "--web.console.libraries=/usr/share/prometheus/console_libraries", "--web.console.templates=/usr/share/prometheus/consoles"]
