# Web Analytics Platform - Azure Container Apps Demo

A production-grade web analytics platform built on Azure Container Apps with Terraform infrastructure and GitHub Actions CI/CD.

## Overview

Privacy-focused web analytics alternative to Google Analytics with real-time tracking, multi-website support, and advanced reporting.

![Umami Demo](docs/images/umami_demo.gif)

## Architecture

```
Azure Front Door → Azure Container Apps → PostgreSQL
```

## Quick Start

### Prerequisites
- Docker and Docker Compose

### Local Development

1. **Clone and setup**
   ```bash
   git clone <repository-url>
   cd aca-web-analytics-gha-demo
   cp .env.example .env
   ```

2. **Start local environment**
   ```bash
   docker-compose up
   ```

### Deployment

1. **Deploy infrastructure**
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

2. **Application deploys automatically** via GitHub Actions on push to main

## Project Structure

```
.
├── .github/workflows/    # CI/CD pipelines
├── src/                 # Next.js application
├── terraform/           # Infrastructure as Code
├── db/                  # Database migrations
└── scripts/            # Build utilities
```

## Key Technologies

- **Frontend**: Next.js 14, React 18, TypeScript
- **Database**: PostgreSQL with Prisma ORM
- **Infrastructure**: Azure Container Apps, ACR, Front Door
- **CI/CD**: GitHub Actions, Terraform
- **Charts**: Chart.js

## License

MIT License
