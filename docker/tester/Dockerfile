FROM dslwa525/dependencies:1.0
WORKDIR /workspace

# Copy everything
COPY . .

# Ensure Go modules are downloaded
RUN if [ -f go.mod ]; then go mod download; fi

# Run tests and export logs
CMD ["sh", "-c", "mkdir -p output && make test > output/test_log.log 2>&1; cat output/test_log.log"]
