FROM rust:1.75-bookworm as builder
WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/src/app/target/release/cerberus-opsct /usr/local/bin/cerberus-opsct
ENTRYPOINT ["cerberus-opsct"]
