#!/usr/bin/env bash
# ==============================================================================
# Ukweli OJS 3.5.0-5 Rapid Spinup & Healthcheck Script
# Builds/pulls, starts containers, and verifies HTTP response in <60 seconds.
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "⚡ [1/4] Preparing environment & asset pipeline directories..."
if [ ! -f .env ]; then
    cp .env.example .env
    echo "  -> Created .env from template."
fi

mkdir -p files public/branding public/cards docker/mysql-init plugins/themes/ukweli
chmod -R 777 files public 2>/dev/null || true

echo "⚡ [2/4] Verifying container image aliases..."
# Ensure pkponline/ojs:3.5.0-5 references pkpofficial/ojs:3_5_0-5 locally
if ! docker image inspect pkponline/ojs:3.5.0-5 >/dev/null 2>&1; then
    if docker image inspect pkpofficial/ojs:3_5_0-5 >/dev/null 2>&1; then
        docker tag pkpofficial/ojs:3_5_0-5 pkponline/ojs:3.5.0-5
        echo "  -> Tagged pkpofficial/ojs:3_5_0-5 as pkponline/ojs:3.5.0-5"
    else
        echo "  -> Pulling official OJS 3.5.0-5 image..."
        docker pull pkpofficial/ojs:3_5_0-5
        docker tag pkpofficial/ojs:3_5_0-5 pkponline/ojs:3.5.0-5
    fi
fi

echo "⚡ [3/4] Spinning up Ukweli stack (OJS + MySQL 8.0)..."
docker compose up -d

echo "⚡ [4/4] Running health check on http://localhost:888..."
PORT="${HTTP_PORT:-888}"
TIMEOUT=60
ELAPSED=0

until curl -s -o /dev/null -w "%{http_code}" "http://localhost:${PORT}/" | grep -qE "(200|302|301)"; do
    sleep 2
    ELAPSED=$((ELAPSED + 2))
    if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
        echo "❌ Health check timed out after ${TIMEOUT}s. Check container logs with 'docker compose logs'."
        exit 1
    fi
    printf "."
done

echo ""
echo "================================================================="
echo "✅ UKWELI OJS 3.5.0-5 IS LIVE AND HEALTHY!"
echo "   Endpoint:        http://localhost:${PORT}"
echo "   Domain Alias:    http://journal.ukweli.org:${PORT}"
echo "   Database:        okweli_ojs (user: ojs_admin, host: db)"
echo "   Asset Pipeline:  ./public (cards, branding) | ./files (uploads)"
echo "   Elapsed Time:    ${ELAPSED} seconds"
echo "================================================================="
