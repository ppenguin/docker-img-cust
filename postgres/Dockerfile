# PG_MAJOR used by make pgvector
ARG PG_MAJOR=16
FROM docker.io/postgres:${PG_MAJOR}-alpine

# PG_MAJOR used by make pgvector
ARG PG_MAJOR=16
ARG PV_TAG="v0.8.0"
ARG VC_TAG="0.5.0"

# Install build tools and dependencies
# we need this split due to unstable requiremets for rust 
# Build and install VectorChord
RUN apk add --no-cache \
      build-base \
      git \
      clang19 \
      llvm19-dev \
      make \
    && git -c advice.detachedHead=false clone --branch ${PV_TAG} --depth 1 https://github.com/pgvector/pgvector.git /tmp/pgvector \
    && cd /tmp/pgvector \
    && make \
    && make install \
    && apk del clang19 llvm19-dev \
    && apk add --no-cache --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main \
        llvm-dev clang clang-dev cargo rustfmt \
    && git -c advice.detachedHead=false clone --branch ${VC_TAG} --depth 1 https://github.com/tensorchord/VectorChord.git /tmp/VectorChord \
    && cd /tmp/VectorChord \
    && make \
    && make install \
    && cd / \
    && rm -rf /tmp/VectorChord /tmp/pgvector \
    && apk del build-base git make clang clang-dev llvm-dev cargo rustfmt

# Entrypoint same as official postgres image
