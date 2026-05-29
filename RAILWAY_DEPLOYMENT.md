# Deploy to Railway

## Prerequisites
- GitHub account (already have)
- Railway account (free at https://railway.app)

## Deployment Steps

### 1. Create Railway Account
- Go to https://railway.app
- Click "Login with GitHub"
- Authorize Railway to access your GitHub

### 2. Create New Project
- Click "New Project"
- Select "Deploy from GitHub repo"
- Choose `ai_doc_classifier` repository
- Click "Deploy"

### 3. Set Environment Variables
Railway will auto-detect the Dockerfile. Once deployment starts:

1. Go to your project settings
2. Click "Variables"
3. Add these variables:
   ```
   BACKEND_API_KEY=changeme123
   ALLOWED_ORIGINS=*
   CLASSIFY_API_URL=http://localhost:8000/classify
   ANALYZE_API_URL=http://localhost:8000/analyze
   HUGGINGFACE_API_KEY=<your-hf-token>
   ```

### 4. Configure Ports
- Railway will auto-detect ports from Dockerfile
- FastAPI: 8000
- Streamlit: 8501

### 5. Get Live URL
After deployment completes:
- Backend API: `https://your-app.railway.app:8000`
- Streamlit UI: `https://your-app.railway.app:8501`

## GitHub Integration
Railway auto-deploys when you push to main branch.

To trigger deployment:
```bash
git add .
git commit -m "deployment updates"
git push origin main
```

## Monitoring
- View logs: Railway Dashboard → Deployments → View Logs
- Monitor CPU/Memory usage
- Check deployment status

## Costs
- Free tier: $5/month credit (enough for light usage)
- GitHub Student Pack: Additional $10/month credit
- Total: $15/month free credit
