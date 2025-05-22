# Crawl44AI & Gitingest API

A FastAPI service that provides endpoints for web crawling and GitHub repository ingestion.

## Features

- Web page crawling with markdown conversion
- GitHub repository ingestion
- RESTful API endpoints

## API Endpoints

### Web Crawling

Crawls a website and returns the content as markdown.

```
GET /crawl?url=<website_url>
```

**Parameters:**
- `url`: The URL of the website to crawl

**Response:**
```json
{
  "markdown": "# Website Title\n\nContent of the website converted to markdown..."
}
```

### GitHub Repository Ingestion

Ingests a GitHub repository and returns a summary, file tree, and content.

```
GET /ingest-github-repo?url=<github_repo_url>
```

**Parameters:**
- `url`: The URL of the GitHub repository to ingest

**Response:**
```json
{
  "summary": "Summary of the repository",
  "tree": "File structure of the repository",
  "content": "Content of the repository files"
}
```

## Usage

Run the API server:

```bash
python main.py
```

The server will start at `http://0.0.0.0:10000` with hot reloading enabled.

## Dependencies

- FastAPI
- Pydantic
- crawl4ai
- gitingest
- uvicorn

---

## Crawl4ai can bypass all the below methods
### 5 diff. Ways to prevent scraping
1. Block by Google Recaptcha
2. Block by 'user-agent' - Some scrapers stay in headless mode and they don't configure the agent(Fetch will include puppet or headless or bot)
3. Block by geo location
4. Block by rate limit

### Puppeteer
1. We can by-pass the 'user-agent' by simulating as an actual user
2. Disabling the automation flags which tells the site that a bot is accessing it
3. By-passing the recaptcha by using puppeteer random movements just to behave as human