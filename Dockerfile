FROM g5search/debian-util:v1.2.1
MAINTAINER G5 Devops <devops@getg5.com>

ENV PGBOUNCER_VERSION=0.0.3

RUN curl -Lo pgbouncer_exporter-$PGBOUNCER_VERSION.linux-amd64.tar.gz https://github.com/larseen/pgbouncer_exporter/releases/download/$PGBOUNCER_VERSION/pgbouncer_exporter-$PGBOUNCER_VERSION.linux-amd64.tar.gz && \
    tar -zxvf pgbouncer_exporter-$PGBOUNCER_VERSION.linux-amd64.tar.gz && \
    mv pgbouncer_exporter-$PGBOUNCER_VERSION.linux-amd64/pgbouncer_exporter /usr/local/bin/ && \
    rm -fR pgbouncer_exporter-$PGBOUNCER_VERSION.linux-amd64.tar.gz

EXPOSE 9127

ENV POSTGRES_USERNAME= \
    POSTGRES_PASSWORD= \
    POSTGRES_HOSTNAME= \
    POSTGRES_PORT="6432" \
    POSTGRES_DBNAME="pgbouncer" \
    POSTGRES_SSLMODE="disable"

CMD [ "pgbouncer_exporter", "-pgBouncer.connectionString=postgres://$POSTGRES_USERNAME:$POSTGRES_PASSWORD@$POSTGRES_HOSTNAME:$POSTGRES_PASSWORD/$POSTGRES_DBNAME?sslmode=$POSTGRES_SSLMODE" ]
