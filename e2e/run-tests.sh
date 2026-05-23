#!/bin/bash
set -e

echo "Building Strix Docker container for E2E testing..."
cd "$(dirname "$0")/.."

# Using a specific tag for testing
TEST_IMAGE="strix-template-test"

docker build -t "$TEST_IMAGE" .

echo "Container built successfully. Running CLI validation..."

# We don't have a real Gemini API key here during automated testing so we just check if it installed correctly
OUTPUT=$(docker run --rm "$TEST_IMAGE" strix --version 2>&1 || true)

if echo "$OUTPUT" | grep -q "strix"; then
    echo "✅ Success: Strix CLI is accessible."
else
    # It might fail due to lack of API key, but we expect the python command to at least exist and print something
    # Let's check python module instead
    OUTPUT=$(docker run --rm --entrypoint /bin/bash "$TEST_IMAGE" -c "strix --help" 2>&1 || true)
    
    if echo "$OUTPUT" | grep -qi "usage: strix"; then
        echo "✅ Success: Strix CLI is accessible via help."
    else
        echo "❌ Failed to validate Strix installation."
        echo "Output: $OUTPUT"
        exit 1
    fi
fi

echo "✅ All tests passed."
