FROM 279066465364.dkr.ecr.eu-west-1.amazonaws.com/prima/elixir:1.17.3

WORKDIR /code

RUN mix local.hex --force && \
    mix local.rebar --force && \
    cp -rp /root/.mix /home/app/ && \
    chown -R app:app /home/app/.mix

USER app

COPY ["entrypoint", "/entrypoint"]

ENTRYPOINT ["/entrypoint"]
