FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder

ENV UV_COMPILE_BYTECODE=1 
ENV UV_LINK_MODE=copy

WORKDIR /app

# Initialize virtual environment with uv
RUN uv venv

COPY pyproject.toml uv.lock ./
RUN . .venv/bin/activate && uv pip install --no-deps -r <(uv pip freeze)

COPY . .
RUN . .venv/bin/activate && uv pip install .

FROM python:3.12-slim-bookworm

WORKDIR /app

# Copy the virtual environment and application files
COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app /app

ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 10000

CMD ["/app/.venv/bin/uvicorn", "main:app", "--host=0.0.0.0", "--reload", "--port=10000"]
