#!/bin/bash
# Deploy script for Codespaces/Production
# Automatically loads GitHub Secrets and starts the app

set -e

echo "🚀 AI Resume Classifier - Production Deploy"
echo "==========================================="

# Check if we're in Codespaces
if [ -n "$CODESPACES" ]; then
    echo "✅ Running in GitHub Codespaces"
    
    # Codespaces automatically sets secrets as environment variables
    # Make sure HUGGINGFACE_API_KEY is available
    if [ -z "$HUGGINGFACE_API_KEY" ]; then
        echo "❌ ERROR: HUGGINGFACE_API_KEY not found in Codespaces secrets"
        echo "Please add it to GitHub Secrets:"
        echo "  Settings → Secrets and variables → Actions → New repository secret"
        echo "  Name: HUGGINGFACE_API_KEY"
        echo "  Value: hf_your_token_here"
        exit 1
    fi
    
    echo "✅ HUGGINGFACE_API_KEY loaded from GitHub Secrets"
fi

# Export environment variables for docker-compose
export HUGGINGFACE_API_KEY="${HUGGINGFACE_API_KEY}"
export BACKEND_API_KEY="${BACKEND_API_KEY:-changeme123}"
export ALLOWED_ORIGINS="${ALLOWED_ORIGINS:-http://localhost:8501,http://127.0.0.1:8501}"
export CLASSIFY_API_URL="${CLASSIFY_API_URL:-http://api:8000/classify}"
export ANALYZE_API_URL="${ANALYZE_API_URL:-http://api:8000/analyze}"

echo "📦 Building Docker image..."
docker compose build --no-cache

echo "🚀 Starting services..."
docker compose up -d

echo ""
echo "✅ Deployment successful!"
echo ""
echo "📊 Service Status:"
docker compose ps

echo ""
echo "🌐 Access your app:"
echo "   Streamlit UI: http://localhost:8502"
echo "   FastAPI Docs: http://localhost:8002/docs"
echo ""
echo "📝 View logs:"
echo "   docker compose logs -f"
echo ""
echo "🛑 Stop services:"
echo "   docker compose down"
