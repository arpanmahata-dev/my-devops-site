# 🚀 My First CI/CD Pipeline

A static website deployed automatically using GitHub Actions and AWS S3.

## 🛠️ Tech Stack
- **HTML/CSS** — The website
- **Git** — Version control
- **GitHub Actions** — CI/CD automation
- **AWS S3** — Cloud hosting

## 🔄 How It Works
1. Edit `index.html` locally
2. Run `git push origin main`
3. GitHub Actions workflow triggers automatically
4. Files upload to AWS S3 bucket
5. Website is live! 🎉

## 📁 Project Structure
```
my-devops-site/
│
├── index.html                  ← Your website (from Project #1)
├── Dockerfile                  ← 🆕 Defines the container
├── .dockerignore               ← 🆕 Files to exclude from image
├── nginx.conf                  ← 🆕 Optional: custom Nginx config
│
└── .github/
    └── workflows/
        └── deploy.yml          ← 🔄 Updated to build + push Docker image
```
## 🚀 Live URL
http://first-devops-site.s3-website.ap-south-1.amazonaws.com/

# 🐳 Containerised CI/CD Pipeline on AWS

![Deploy](https://github.com/arpanmahata-dev/my-devops-site/actions/workflows/deploy.yml/badge.svg)

A production-style pipeline that builds a Docker image and deploys it
to AWS EC2 automatically on every push to `main`.

**🌐 Live:** http://13.233.144.154

---

## Architecture

![Architecture](docs/architecture.png)

```
Developer → git push → GitHub Actions
                            │
                    ┌───────┴───────┐
                    │  Build image  │
                    │  Push to ECR  │
                    └───────┬───────┘
                            │ SSH
                            ▼
                    EC2 (Docker + Nginx)
                            │
                            ▼
                          Users
```

## Tech Stack

| Layer | Technology |
|---|---|
| Container | Docker, Nginx Alpine |
| Registry | Amazon ECR |
| Compute | Amazon EC2 (Ubuntu 22.04) |
| CI/CD | GitHub Actions |
| Storage | Amazon S3 (static variant) |

## Pipeline Stages

1. **Validate** — confirm `index.html` exists and is non-empty
2. **Build** — build Docker image, tag with commit SHA
3. **Push** — upload to Amazon ECR
4. **Deploy** — SSH to EC2, pull image, restart container
5. **Verify** — smoke test the live endpoint

## Problems I Solved

**Secret leak blocked by GitHub Push Protection**
Committed an AWS credentials file. Push Protection rejected it before
it reached the remote. Rotated the IAM key, rewrote git history with
`git commit --amend`, and added a `.gitignore` with credential patterns.

**Silent deploy failure from region mismatch**
Workflow was green but the S3 bucket stayed empty. The bucket lived in
`ap-south-1` while the workflow used `us-east-1`. Added a post-deploy
verification step that fails the build if the object isn't present.

**Docker socket permission denied on EC2**
`usermod -aG docker` succeeded but `docker run` still failed. Linux
caches group membership at login — the session predated the change.
Learned this also affects non-interactive CI sessions over SSH.

**SSH key rejected on Windows**
`.pem` files inherit permissive Windows ACLs; OpenSSH refuses keys
readable by other principals. `chmod` doesn't exist in PowerShell —
used `icacls /inheritance:r /grant:r` instead.

## Local Development

```bash
docker build -t my-site .
docker run -d -p 8080:80 --name my-site my-site
# → http://localhost:8080
```

## Deployment

Push to `main`. That's it.

```bash
git push origin main
```

## Roadmap

- [ ] Migrate to OIDC (remove long-lived AWS keys)
- [ ] CloudFront + ACM for HTTPS
- [ ] Provision infrastructure with Terraform
- [ ] Container vulnerability scanning (Trivy)