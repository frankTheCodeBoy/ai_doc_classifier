# 🚀 Codespaces Deployment - What to Do

## Your Setup Script is Already Created! ✅

The file `.devcontainer/setup.sh` **automatically exports all secrets** when Codespaces launches.

---

## When Codespaces Opens

### Option A: Script Already Ran (BEST CASE)
✅ If you see this message in terminal:
```
🚀 AI Resume Classifier - Automated Codespaces Setup
✅ HUGGINGFACE_API_KEY loaded from GitHub Secrets
🚀 Starting services...
✅ Services started
📊 Service Status: (shows running containers)
✅ Setup Complete!
```

**Then just:** Click PORTS tab → Click Streamlit (8502) → **DONE!** ✅

---

### Option B: Script Didn't Run (RARE)
If you see an empty terminal or just the prompt `@codespaces...`:

**Run this ONE command:**
```bash
bash .devcontainer/setup.sh
```

This will:
- ✅ Automatically export GitHub Secrets (HUGGINGFACE_API_KEY)
- ✅ Build Docker images
- ✅ Start FastAPI + Streamlit
- ✅ Show you when it's ready

**Then:** Click PORTS tab → Click Streamlit (8502) → **DONE!** ✅

---

## What This Script Does (Behind the Scenes)

```bash
# 1. Exports GitHub Secret automatically
export HUGGINGFACE_API_KEY="${HUGGINGFACE_API_KEY}"

# 2. Exports other needed variables
export BACKEND_API_KEY="codespaces-key"
export CLASSIFY_API_URL="http://localhost:8000/classify"
export ANALYZE_API_URL="http://localhost:8000/analyze"

# 3. Builds Docker images
docker compose build --quiet

# 4. Starts everything
docker compose up -d

# 5. Shows status
docker compose ps
```

---

## Summary

| What | Details |
|------|---------|
| **Setup Script** | ✅ Already created at `.devcontainer/setup.sh` |
| **GitHub Secrets** | ✅ Automatically exported when script runs |
| **Your Job** | Click button OR run `bash .devcontainer/setup.sh` |
| **Result** | App is LIVE in 2-3 minutes |

---

**That's it!** No manual environment variable exports needed - the script handles everything! 🧠
