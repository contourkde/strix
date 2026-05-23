# Strix AI Penetration Testing Agent - Railway Template

This template deploys the [Strix AI](https://github.com/usestrix/strix) penetration testing agent as a headless, containerized service on Railway. 

The container is equipped with a full suite of Sandbox tools (Subfinder, Nmap, Nuclei, Sqlmap, TruffleHog, etc.) and operates in `STRIX_SANDBOX_MODE` without needing external Docker access.

## Configuration

This template uses Google Gemini for its LLM provider.

To deploy this template, ensure the following environment variables are set in your Railway project:

- `STRIX_SANDBOX_MODE=true`
- `STRIX_LLM=gemini/gemini-3.1-pro-preview` (or another supported Gemini model)
- `GEMINI_API_KEY` - Your Google Gemini API key.

## Execution

Because this container runs completely headless (`sleep infinity`), it does not expose a public web service by default.

To run a penetration test, use the Railway CLI to execute a command inside your running container:

```bash
# 1. Open a shell into the running container
railway ssh

# 2. Run your Strix command
strix -t example.com -m deep
```

Or execute directly from your local terminal:

```bash
railway ssh -- "strix -t example.com -m deep"
```

## Available Tools

The environment includes Strix's Sandbox dependencies pre-installed:
- **Reconnaissance**: Subfinder, Naabu, httpx, Katana, ffuf, Nmap
- **Scanners**: Nuclei, SQLMap, Wapiti, ZAP
- **Secrets**: TruffleHog, Gitleaks
- **Static Analysis**: Semgrep, ast-grep, Bandit, ESLint
- **Web Testing**: Arjun, Dirsearch, wafw00f

For custom instructions or advanced configuration, refer to the [Official Strix Documentation](https://docs.strix.ai/).
