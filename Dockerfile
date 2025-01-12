# Stage 1: Build
FROM rust:latest AS builder

# Set the working directory
WORKDIR /app

# Copy the Cargo manifest and lock file
COPY Cargo.toml Cargo.lock ./

# Copy the source code
COPY src ./src

# Build the application in release mode
RUN cargo build --release

# Stage 2: Runtime
FROM debian:bookworm-slim AS runtime

# Install necessary runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && apt-get clean

# Set the working directory
WORKDIR /app

# Copy the compiled binary from the builder stage
COPY --from=builder /app/target/release/hello_world .

# Expose the application port
EXPOSE 8080

# Command to run the application
CMD ["./hello_world"]
