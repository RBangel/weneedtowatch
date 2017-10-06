FROM elixir:latest

RUN apt-get update && \
    apt-get install -y libssl1.0.0 postgresql-client && \
    apt-get autoclean

ARG VERSION=0.0.1

RUN mkdir -p /app
COPY _build/prod/rel/we_need_to_watch/releases/${VERSION}/we_need_to_watch.tar.gz /app/we_need_to_watch.tar.gz
COPY wait-for-postgres.sh /app/wait-for-postgres.sh
WORKDIR /app

RUN tar xzf we_need_to_watch.tar.gz
ENV PORT 8888

CMD ["/app/bin/we_need_to_watch", "foreground"]
