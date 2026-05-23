# Future Enhancements for Strix Template

## 1. FastAPI Wrapper
Currently, the Strix container runs in a completely headless mode (`sleep infinity`) and requires manual execution via the Railway CLI or `docker exec`. 
To integrate Strix into automated workflows, we need to build a persistent web server (e.g., using FastAPI) that listens for incoming scan requests.

**Tasks:**
- Create a `server.py` using FastAPI.
- Expose a POST `/scan` endpoint that takes target parameters and triggers the Strix CLI subprocess or internal Python API.
- Update `railway.toml` to start the server instead of `sleep infinity`.

## 2. API-Based Scan Webhooks
Once the FastAPI wrapper is in place, we should implement a webhook callback mechanism. Penetration tests can take significant time to run.

**Tasks:**
- Add a `webhook_url` parameter to the `/scan` endpoint.
- Configure the agent to post scan results back to the provided webhook URL upon completion.
- Provide authentication mechanisms (like a shared secret or bearer token) to secure the `/scan` endpoint.
