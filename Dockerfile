FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder

ENV UV_COMPILE_BYTECODE=1 
ENV UV_LINK_MODE=copy
ENV UV_SYSTEM_PYTHON=1

WORKDIR /app

# Create virtual environment and activate it
RUN python -m venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/.venv"

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-install-project

COPY . .
RUN uv sync --frozen

FROM python:3.12-slim-bookworm

WORKDIR /app

# Copy the virtual environment and application files
COPY --from=builder /app/.venv /app/.venv
COPY --from=builder /app /app

ENV PATH="/app/.venv/bin:$PATH"
ENV VIRTUAL_ENV="/app/.venv"

EXPOSE 10000

# Use python -m to ensure we're using the right interpreter
CMD ["python", "-m", "uvicorn", "main:app", "--host=0.0.0.0", "--reload", "--port=10000"]
