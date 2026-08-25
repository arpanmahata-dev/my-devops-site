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
├── index.html              # Main website
├── README.md               # This file
└── .github/
    └── workflows/
        └── deploy.yml      # CI/CD workflow
```

## 🚀 Live URL
https://your-bucket-name.s3-website-us-east-1.amazonaws.com