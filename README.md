# Social Media Agent 🤖⚡
### Agentic AI companion for multichannel social media management
> **Powered by IBM watsonx.ai · IBM Langflow · React + Tailwind**

---

## Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    React Dashboard (port 3000)               │
│  Dashboard │ Content Studio │ Sentiment │ Hashtags │ ...    │
└─────────────────────┬───────────────────────────────────────┘
                      │ REST API calls
┌─────────────────────▼───────────────────────────────────────┐
│               FastAPI Backend (port 8000)                    │
│  /api/agent  │ /api/analytics │ /api/platforms │ /api/schedule│
└──┬───────────┬──────────────┬──────────────────┬────────────┘
   │           │              │                  │
   ▼           ▼              ▼                  ▼
IBM watsonx  IBM Langflow  Platform          PostgreSQL
Granite LLM  Flow Engine   Connectors        + Redis
                           (X/LI/IG/FB)
```

---

## Features

| Feature | Description |
|---------|-------------|
| **Content Studio** | Generate posts via text, image upload, or voice — multi-platform, brand-tone aware |
| **Sentiment Tracker** | 24h sentiment timeline with drift alerts via IBM watsonx analysis |
| **Trending Hashtags** | AI-forecasted top-10 trending hashtags for the next 12 hours |
| **Competitor Intelligence** | Engagement benchmarking + AI-generated strategy insights |
| **Campaign Forecast** | Predict reach, impressions, and engagement before publishing |
| **Posting Scheduler** | Optimal time-slot recommendations + post queue with approval workflow |

---

## Quick Start (Local Dev — No Docker)

### 1. Clone & setup backend

```bash
cd social-media-agent/backend
python -m venv .venv
# Windows:
.venv\Scripts\activate
# macOS/Linux:
source .venv/bin/activate

pip install -r requirements.txt

cp .env.example .env
# Edit .env and add your API keys
```

### 2. Run backend

```bash
uvicorn main:app --reload --port 8000
# API docs: http://localhost:8000/docs
# Health:   http://localhost:8000/health
```

### 3. Run frontend

```bash
cd social-media-agent/frontend
npm install
npm run dev
# UI: http://localhost:3000
```

---

## Quick Start (Docker Compose)

```bash
cd social-media-agent

# 1. Copy and fill in your keys
cp backend/.env.example backend/.env

# 2. Build and start all services
docker compose up --build

# Frontend: http://localhost:3000
# Backend:  http://localhost:8000
# API docs: http://localhost:8000/docs
```

---

## API Keys — How to Obtain Each

### IBM watsonx.ai (REQUIRED for AI generation)
1. Go to [cloud.ibm.com](https://cloud.ibm.com) → Create account
2. Navigate to **watsonx.ai** → Create a project
3. Go to **Manage → Access (IAM)** → **API Keys** → Create API key
4. Copy `WATSONX_API_KEY` and `WATSONX_PROJECT_ID` to `.env`

### IBM Langflow (optional — falls back to direct watsonx)
1. Deploy IBM Langflow via IBM Cloud or locally
2. Create a flow → copy the Flow ID from the URL
3. Generate a Langflow API key from Settings
4. Set `LANGFLOW_API_URL`, `LANGFLOW_FLOW_ID`, `LANGFLOW_API_KEY`

### Twitter / X API v2
1. Go to [developer.twitter.com](https://developer.twitter.com)
2. Create a project + app → Apply for Elevated access for full search
3. Under **Keys and Tokens** → copy Bearer Token, API Key/Secret, Access Token/Secret

### LinkedIn API
1. Go to [linkedin.com/developers](https://www.linkedin.com/developers/)
2. Create an app → Request `r_organization_social` permission
3. Generate an access token via OAuth 2.0 flow

### Instagram / Facebook Graph API
1. Go to [developers.facebook.com](https://developers.facebook.com/)
2. Create a Meta App → Add Instagram Basic Display + Facebook Login products
3. Generate a Page Access Token with `pages_read_engagement` scope

---

## Without API Keys (Mock Mode)
The app runs fully without any API keys configured. All connectors and services fall back to realistic mock data automatically. Perfect for development and demos.

---

## Backend API Reference

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Health check |
| `/api/agent/generate` | POST | Run AI agent (text prompt) |
| `/api/agent/multimodal` | POST | Multimodal (text + image) |
| `/api/analytics/sentiment/timeline` | GET | 24h sentiment data |
| `/api/analytics/hashtags/forecast` | GET | Trending hashtag predictions |
| `/api/analytics/engagement/overview` | GET | Platform KPIs |
| `/api/analytics/engagement/timeseries` | GET | Daily engagement (N days) |
| `/api/analytics/competitors` | GET | Competitor intelligence report |
| `/api/analytics/campaign/forecast` | POST | Campaign performance prediction |
| `/api/platforms/all` | GET | Posts from all platforms |
| `/api/schedule/recommendations` | GET | Best posting time slots |
| `/api/schedule/queue` | GET/POST | View/add post queue |
| `/api/schedule/approve` | POST | Approve a queued post |

Full interactive docs at `http://localhost:8000/docs`

---

## Tech Stack

- **AI/ML**: IBM watsonx.ai (granite-13b-chat-v2), IBM Langflow
- **Backend**: Python 3.11 · FastAPI · Uvicorn · asyncpg
- **Frontend**: React 18 · Vite · Tailwind CSS · Recharts · Lucide
- **Database**: PostgreSQL 16 · Redis 7
- **Social APIs**: Twitter v2 (Tweepy) · LinkedIn API v2 · Meta Graph API
- **Infra**: Docker · Docker Compose · Nginx
