FROM node:22-slim

LABEL maintainer="ShopClaw AI"
LABEL description="ShopClaw AI — AI Customer Service for E-commerce"

# Install OpenClaw
RUN npm install -g openclaw@latest

# Create workspace
RUN mkdir -p /app /root/.openclaw/workspace/skills

WORKDIR /app

# Copy project files
COPY skills/ /root/.openclaw/workspace/skills/
COPY workspace/AGENTS.md /root/.openclaw/workspace/
COPY workspace/SOUL.md /root/.openclaw/workspace/
COPY workspace/TOOLS.md /root/.openclaw/workspace/
COPY data/ /root/.openclaw/workspace/data/
COPY config/openclaw.json /root/.openclaw/openclaw.json

# Expose gateway port
EXPOSE 18789

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:18789/health || exit 1

# Start OpenClaw
CMD ["openclaw", "start", "--no-daemon"]
