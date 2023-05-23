FROM eclipse-temurin:11

COPY action.yml action.sh /

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -q && apt install -q -y curl && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/action.sh"]
