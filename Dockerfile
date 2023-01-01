FROM crystallang/crystal:latest-alpine
LABEL org.opencontainers.image.source=https://github.com/aerphanas/Aswad
LABEL org.opencontainers.image.description="Indonesia Islamic Prayer Times and Interpretation of the Koran "
WORKDIR /git
RUN apk add --no-cache ncurses-dev zlib-dev openssl-dev \
    && git clone https://github.com/aerphanas/Aswad.git \
    && crystal build --release ./Aswad/src/aswad.cr
ENTRYPOINT [ "./aswad" ]
CMD ["./aswad", "-h", "-c"]