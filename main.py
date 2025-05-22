from fastapi import FastAPI
from pydantic import BaseModel
from crawl4ai import AsyncWebCrawler
from gitingest import ingest

app = FastAPI()

class WebsiteURL(BaseModel):
    url: str

# Crawl a website: https://docs.crawl4ai.com/
@app.get("/crawl")
async def crawl_website(url: str):
    print(f"Crawling: {url}")
    async with AsyncWebCrawler() as crawler:
        result = await crawler.arun(url=url)
    return {"markdown": result.markdown}


# Ingest a github repo: https://github.com/cyclotruc/gitingest
@app.get("/ingest-github-repo")
def ingest_github_repo(url: str):
    print(f"Ingesting: {url}")
    summary, tree, content = ingest(url)
    return {"summary": summary, "tree": tree, "content": content}


if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=10000, reload=True)