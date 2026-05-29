# 🚀 Codespaces Quick Start

## Your App is Ready to Deploy!

### Step 1: Verify Secrets (MUST DO FIRST)
```bash
# Check if your HF token is loaded
echo "HF Token: ${HUGGINGFACE_API_KEY:0:10}..."
```

If empty → Go to GitHub → Settings → Secrets → Check `HUGGINGFACE_API_KEY` exists

### Step 2: Export Secrets & Deploy
```bash
# Export GitHub Secrets to environment
export HUGGINGFACE_API_KEY="${HUGGINGFACE_API_KEY}"
export BACKEND_API_KEY="codespaces-secure-key"

# Build and start
docker compose build --no-cache
docker compose up -d
```

### Step 3: Access Your App
- **Streamlit UI:** http://localhost:8502
- **API Docs:** http://localhost:8002/docs

### Step 4: Get Your Public URL
Click the **PORTS** tab (bottom of screen) → Click Streamlit port (8502) → Copy the URL

**Your Live URL:** `https://your-username-projectname-xxxx.githubpreview.dev:8502`

### Troubleshooting

**"HUGGINGFACE_API_KEY not set"**
```bash
# Manually set it
export HUGGINGFACE_API_KEY="hf_your_token_here"
docker compose up -d
```

**"Docker image pull denied"**
```bash
# Build locally first
docker compose build --no-cache
docker compose up -d
```

**Stop everything**
```bash
docker compose down
```

---

**Next Steps:**
1. Get your live URL from PORTS tab
2. Update README with live link
3. Add custom domain (name.com)
4. Post to LinkedIn
