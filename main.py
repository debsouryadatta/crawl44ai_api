from fastapi import FastAPI
from pydantic import BaseModel
from crawl4ai import AsyncWebCrawler

app = FastAPI()

class WebsiteURL(BaseModel):
    url: str

@app.get("/crawl")
async def crawl_website(url: str):
    print(f"Crawling: {url}")
    async with AsyncWebCrawler() as crawler:
        result = await crawler.arun(url=url)
    return {"markdown": result.markdown}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("main:app", host="0.0.0.0", port=10000, reload=True)