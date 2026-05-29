#!/bin/bash
# Automatic setup script for GitHub Codespaces
# Runs automatically when Codespaces environment is created
# NO manual steps needed - completely automated!

set -e

echo "🚀 AI Resume Classifier - Automated Codespaces Setup"
echo "====================================================="
echo ""

# Step 1: Install dependencies
echo "📦 Installing Python dependencies..."
pip install -q -r requirements.txt
echo "✅ Dependencies installed"
echo ""

# Step 2: Verify GitHub Secrets
echo "🔐 Checking GitHub Secrets..."
if [ -z "$HUGGINGFACE_API_KEY" ]; then
    echo "⚠️  WARNING: HUGGINGFACE_API_KEY not set!"
    echo ""
    echo "To use the app, you need to add your HuggingFace token:"
    echo "1. Go to: https://github.com/frankTheCodeBoy/ai_doc_classifier/settings/secrets/actions"
    echo "2. Click 'New repository secret'"
    echo "3. Name: HUGGINGFACE_API_KEY"
    echo "4. Value: Your HF token (from https://huggingface.co/settings/tokens)"
    echo "5. Restart Codespaces"
    echo ""
    echo "For now, creating .env file for local testing..."
    cp .env.example .env
    echo "⚠️  Edit .env with your token to test locally"
else
    echo "✅ HUGGINGFACE_API_KEY loaded from GitHub Secrets"
fi
echo ""

# Step 3: Export environment variables
echo "📤 Exporting environment variables..."
export HUGGINGFACE_API_KEY="${HUGGINGFACE_API_KEY}"
export BACKEND_API_KEY="codespaces-key"
export ALLOWED_ORIGINS="https://*.githubpreview.dev,http://localhost:8501"
export CLASSIFY_API_URL="http://localhost:8000/classify"
export ANALYZE_API_URL="http://localhost:8000/analyze"
echo "✅ Environment variables exported"
echo ""

# Step 4: Build Docker images
echo "🐳 Building Docker images (first time only)..."
docker compose build --quiet
echo "✅ Docker images built"
echo ""

# Step 5: Start services
echo "🚀 Starting services..."
docker compose up -d
echo "✅ Services started"
echo ""

# Step 6: Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 5

# Step 7: Check service status
echo "📊 Service Status:"
docker compose ps
echo ""

# Step 8: Display access information
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "🎨 Your app is ready!"
echo ""
echo "📍 Access your app:"
echo "   Click the PORTS tab (bottom of screen)"
echo "   Click the Streamlit link (port 8502)"
echo ""
echo "📡 API Documentation:"
echo "   http://localhost:8002/docs"
echo ""
echo "📝 View logs:"
echo "   docker compose logs -f"
echo ""
echo "🛑 Stop the app:"
echo "   docker compose down"
echo ""
echo "Happy analyzing! 🧠"
