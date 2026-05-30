#!/bin/bash
# Automated Deployment Script for AI Resume Classifier
# Exports GitHub Secrets and deploys the app
# Usage: bash deploy.sh

set -e

echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  🚀 AI Resume Classifier - Automated Deployment Script     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# ============================================================================
# STEP 1: Check if running in Codespaces
# ============================================================================
if [ -n "$CODESPACES" ]; then
    echo "✅ Environment: GitHub Codespaces"
else
    echo "📌 Environment: Local Machine"
fi
echo ""

# ============================================================================
# STEP 2: Verify and Export GitHub Secrets
# ============================================================================
echo "🔐 Step 1: Loading GitHub Secrets..."
echo "─────────────────────────────────────────────────────────────"

if [ -z "$HUGGINGFACE_API_KEY" ]; then
    echo "❌ ERROR: HUGGINGFACE_API_KEY not found in GitHub Secrets!"
    echo ""
    echo "📝 To fix this:"
    echo "   1. Go to: https://github.com/frankTheCodeBoy/ai_doc_classifier/settings/secrets/actions"
    echo "   2. Click 'New repository secret'"
    echo "   3. Name: HUGGINGFACE_API_KEY"
    echo "   4. Value: Your HuggingFace token (from https://huggingface.co/settings/tokens)"
    echo "   5. Restart Codespaces"
    echo ""
    exit 1
fi

echo "✅ HUGGINGFACE_API_KEY loaded from GitHub Secrets"
echo "   Token preview: ${HUGGINGFACE_API_KEY:0:20}..."
echo ""

# ============================================================================
# STEP 3: Export All Environment Variables
# ============================================================================
echo "📤 Step 2: Exporting environment variables..."
echo "─────────────────────────────────────────────────────────────"

export HUGGINGFACE_API_KEY="${HUGGINGFACE_API_KEY}"
export BACKEND_API_KEY="codespaces-secure-key"
export ALLOWED_ORIGINS="https://*.githubpreview.dev,http://localhost:8501,http://127.0.0.1:8501"
export CLASSIFY_API_URL="http://localhost:8000/classify"
export ANALYZE_API_URL="http://localhost:8000/analyze"

echo "✅ Environment variables exported:"
echo "   - HUGGINGFACE_API_KEY: ✓ Set"
echo "   - BACKEND_API_KEY: ✓ Set"
echo "   - ALLOWED_ORIGINS: ✓ Set"
echo "   - CLASSIFY_API_URL: ✓ Set"
echo "   - ANALYZE_API_URL: ✓ Set"
echo ""

# ============================================================================
# STEP 4: Install Dependencies
# ============================================================================
echo "📦 Step 3: Installing dependencies..."
echo "─────────────────────────────────────────────────────────────"

if command -v pip &> /dev/null; then
    pip install -q -r requirements.txt
    echo "✅ Dependencies installed"
else
    echo "⚠️  pip not found, skipping dependency installation"
fi
echo ""

# ============================================================================
# STEP 5: Build Docker Images
# ============================================================================
echo "🐳 Step 4: Building Docker images..."
echo "─────────────────────────────────────────────────────────────"

if command -v docker &> /dev/null; then
    docker compose build --no-cache
    echo "✅ Docker images built successfully"
else
    echo "❌ ERROR: Docker not installed!"
    exit 1
fi
echo ""

# ============================================================================
# STEP 6: Start Services
# ============================================================================
echo "🚀 Step 5: Starting services..."
echo "─────────────────────────────────────────────────────────────"

docker compose up -d

echo "✅ Services launched"
echo ""

# ============================================================================
# STEP 7: Wait for Services to Be Ready
# ============================================================================
echo "⏳ Step 6: Waiting for services to be ready..."
echo "─────────────────────────────────────────────────────────────"

sleep 5

# ============================================================================
# STEP 8: Verify Services Are Running
# ============================================================================
echo "📊 Step 7: Checking service status..."
echo "─────────────────────────────────────────────────────────────"

docker compose ps

echo ""

# ============================================================================
# STEP 9: Display Success Message
# ============================================================================
echo "╔════════════════════════════════════════════════════════════╗"
echo "║  ✅ DEPLOYMENT COMPLETE!                                  ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

echo "🎨 Your AI Resume Classifier is ready!"
echo ""
echo "📍 Access your app:"
if [ -n "$CODESPACES" ]; then
    echo "   1. Click the PORTS tab (bottom of screen)"
    echo "   2. Click the link for port 8502 (Streamlit UI)"
    echo "   3. Your app opens in browser! 🎉"
else
    echo "   Streamlit UI:   http://localhost:8502"
    echo "   FastAPI Docs:   http://localhost:8002/docs"
fi
echo ""

echo "📝 Useful commands:"
echo "   View logs:       docker compose logs -f"
echo "   Stop services:   docker compose down"
echo "   Restart:         docker compose up -d"
echo ""

echo "📊 Services running:"
docker compose ps --format "table {{.Names}}\t{{.Status}}"

echo ""
echo "🧠 Happy analyzing!"
echo ""
