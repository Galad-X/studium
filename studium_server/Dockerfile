# Build stage
FROM dart:3.3.0 AS build
WORKDIR /app
COPY . .

# Install dependencies and compile the server executable
RUN dart pub get
RUN dart compile exe bin/main.dart -o bin/server
RUN dart compile exe bin/worker.dart -o bin/worker

# Final stage
FROM alpine:latest

# Environment variables
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# Copy runtime dependencies
COPY --from=build /runtime/ /

# Copy compiled server executable
COPY --from=build /app/bin/server server
COPY --from=build /app/bin/worker worker

# Copy public configuration files only. Runtime secrets are injected through
# SERVERPOD_PASSWORDS_B64 and materialized in the container at startup.
COPY --from=build /app/config/development.yaml config/development.yaml
COPY --from=build /app/config/staging.yaml config/staging.yaml
COPY --from=build /app/config/production.yaml config/production.yaml
COPY --from=build /app/config/test.yaml config/test.yaml
COPY --from=build /app/web/ web/
COPY --from=build /app/migrations/ migrations/

# This file is required to enable the endpoint log filter in Insights.
COPY --from=build /app/lib/src/generated/protocol.yaml lib/src/generated/protocol.yaml

# Expose ports
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# Define the entrypoint command
ENTRYPOINT ["/bin/sh", "-c", "if [ -n \"${SERVERPOD_PASSWORDS_B64:-}\" ]; then printf '%s' \"$SERVERPOD_PASSWORDS_B64\" | base64 -d > config/passwords.yaml; fi; if [ \"$role\" = \"worker\" ]; then exec ./worker --mode=$runmode --server-id=$serverid --logging=$logging --role=maintenance; else exec ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role; fi"]
