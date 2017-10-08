# Set up deps ###########3############################################
FROM elixir:latest as deps

ENV APP=/app
RUN mkdir -p /app

RUN mix do local.hex --force, local.rebar --force
# Cache elixir deps
COPY config/ $APP/config/
COPY mix.exs mix.lock $APP/
# COPY app/myproject_web/mix.exs $HOME/app/myproject_web/
# COPY app/myproject_web/config/ $HOME/app/myproject_web/config/

WORKDIR $APP
RUN mix deps.get


# Node Pre-Compilation ###############################################
FROM node:6 as asset-builder

ENV APP=/app

COPY --from=deps $APP/deps $APP/deps

WORKDIR $APP/assets
COPY assets/ ./
RUN yarn install
RUN ./node_modules/.bin/brunch build --production


# Final ###############################################################
FROM elixir:latest

ARG VERSION=0.0.1
ENV APP=/app
ENV MIX_ENV=prod
ENV PORT=8888
WORKDIR $APP

# RUN apt-get update && \
#     apt-get install -y libssl1.0.0 postgresql-client && \
#     apt-get autoclean

COPY --from=asset-builder $APP/priv/static/ $APP/priv/static/

RUN mix do local.hex --force, local.rebar --force

COPY config/ $APP/config/
COPY mix.exs mix.lock $APP/

RUN mix do deps.get --only $MIX_ENV, deps.compile

COPY . $APP/
RUN mix phx.digest

CMD ["mix", "phx.server"]
