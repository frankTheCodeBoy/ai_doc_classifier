# Alternate Deployment Configurations (Archived)

This folder contains deployment configurations for alternative hosting platforms that were evaluated but not currently active.

## Available Configs

### 1. Azure Deployment (`ARCHIVED_AZURE_CONFIG.yml`)
- Original Azure Container Registry + App Service setup
- Requires credit card
- Status: ❌ Not in use

### 2. Railway Deployment (`ARCHIVED_RAILWAY_CONFIG.json`)
- Railway.app configuration
- Free tier with credits
- Status: ❌ Deployment failed

### 3. DigitalOcean Deployment (`ARCHIVED_DIGITALOCEAN_GUIDE.md`)
- DigitalOcean App Platform setup
- $200 student credit
- Status: ❌ Requires credit card

## Current Active Deployment

**Replit** (REPLIT_DEPLOYMENT.md)
- ✅ 100% free
- ✅ No credit card
- ✅ Works with Docker
- ✅ Automatic deployments

## To Use Archived Configs

If you want to switch to an archived platform:
1. Review the corresponding config file
2. Follow the setup instructions
3. Deploy accordingly

## Adding New Platforms

When testing new deployment platforms:
1. Create config in this `docs/` folder
2. Name as `ARCHIVED_<PLATFORM>_<TYPE>.ext`
3. Document setup steps
4. Move main deployment when ready
