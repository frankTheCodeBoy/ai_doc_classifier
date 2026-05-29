# Deploy to DigitalOcean (Free with GitHub Student Pack)

## Get Free Credits
1. Go to: https://www.digitalocean.com/github-students
2. Click "Claim Free Credit"
3. Verify with your GitHub Student Pack account
4. Receive **$200 free credit** (≈ 40 months free!)

## Deployment Steps

### Step 1: Create DigitalOcean Account
- Sign up with GitHub
- Apply GitHub Student Pack benefits
- Receive $200 credit

### Step 2: Create App Platform Project
1. Go to DigitalOcean Dashboard
2. Click "Create" → "App"
3. Select "GitHub"
4. Choose repository: `ai_doc_classifier`
5. Select branch: `main`
6. Choose region (e.g., `nyc` or `lon`)

### Step 3: Configure Service
DigitalOcean will auto-detect your Dockerfile:
- Source: GitHub repo
- Dockerfile path: `/Dockerfile` (auto-detected)
- Instance type: Basic ($5/month, but free with credits)
- Region: Choose nearest to you

### Step 4: Set Environment Variables
In the App Platform settings, add:
```
BACKEND_API_KEY=changeme123
ALLOWED_ORIGINS=*
CLASSIFY_API_URL=http://localhost:8000/classify
ANALYZE_API_URL=http://localhost:8000/analyze
HUGGINGFACE_API_KEY=<your-hf-token>
```

### Step 5: Add Custom Domain
1. Go to App settings
2. Click "Domains"
3. Add your custom domain
4. Follow DNS setup instructions
5. Point to DigitalOcean nameservers

### Step 6: Deploy
1. Click "Create App"
2. DigitalOcean builds and deploys automatically
3. Takes ~10-15 minutes
4. You get a live URL immediately

## Access Your App
- **Streamlit UI:** `https://your-domain.com:8501`
- **API Docs:** `https://your-domain.com:8000/docs`

## Auto-Deployment
Every push to `main` branch triggers automatic deployment!

## Monitoring
- DigitalOcean Dashboard shows logs in real-time
- CPU/Memory monitoring
- Auto-restart on failure
- Free SSL certificate

## Cost Breakdown
- **With Student Credit:** FREE for 40 months
- **After credit expires:** $5/month (Basic instance)
- Custom domain: $12/year (Name.com via Student Pack)
- **Total long-term:** ~$17/month for everything

## Support
- DigitalOcean has excellent documentation
- Community forums
- GitHub integration support

---

**Next Steps:**
1. Claim your $200 DigitalOcean credit
2. Create App Platform project
3. Connect this GitHub repo
4. Set environment variables
5. Deploy!
