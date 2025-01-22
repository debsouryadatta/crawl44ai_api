FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder

ENV UV_COMPILE_BYTECODE=1 
ENV UV_LINK_MODE=copy
ENV UV_SYSTEM_PYTHON=1

WORKDIR /app

COPY pyproject.toml uv.lock ./

# Install dependencies using uv sync
RUN uv venv && \
    uv sync --frozen --no-install-project

COPY . .
RUN uv sync --frozen

FROM python:3.12-slim-bookworm

WORKDIR /app

COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app /app

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 10000

CMD ["/app/.venv/bin/uvicorn", "main:app", "--host=0.0.0.0", "--reload", "--port=10000"]
