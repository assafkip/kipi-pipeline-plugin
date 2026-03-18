# Kipi Pipeline Plugin

A Claude Code plugin that adds a multi-phase morning routine pipeline to any founder project. 24 agents across 9 phases produce a daily HTML action plan with copy-paste-ready outreach.

## What it does

Every morning, the pipeline:
1. Pulls data from Calendar, Gmail, Notion CRM, and VC Pipeline API
2. Preps meetings, matches warm intros
3. Scans LinkedIn posts, DMs, and connection accepts
4. Finds threat/market signals, drafts posts for 4 platforms
5. Scores prospect temperature, sources leads, generates engagement hitlist
6. Checks content compliance and positioning health
7. Synthesizes everything into a daily schedule JSON
8. Builds an HTML file with checkboxes, copy-paste blocks, and direct links
9. Pushes actions to Notion

## Install

```bash
# From local path
claude plugin install /path/to/kipi-pipeline-plugin

# For development (live reload)
claude --plugin-dir /path/to/kipi-pipeline-plugin
```

## Prerequisites

Your project needs a `q-system/` directory with:
- `my-project/notion-ids.md` - Notion database IDs (data_source_id + database_id)
- `my-project/current-state.md` - what your product does today
- `canonical/talk-tracks.md` - approved messaging
- `canonical/objections.md` - known pushback + responses
- `my-project/relationships.md` - contact database
- `marketing/templates/` - build script + HTML template (included in plugin)

MCP servers configured:
- Google Calendar (`mcp__claude_ai_Google_Calendar__*`)
- Gmail (`mcp__claude_ai_Gmail__*`)
- Notion API (`mcp__notion_api__*`) - must use data_source_id, not database_id
- Chrome (`mcp__claude-in-chrome__*`) - for LinkedIn and fallback scraping
- Apify (optional) - for lead sourcing. Falls back to Chrome automatically.

## Usage

```
/kipi-pipeline:q-morning    # Full morning routine
/kipi-pipeline:q-debrief    # Post-conversation extraction
/kipi-pipeline:q-wrap       # Evening health check
```

## Architecture

```
Phase 0: Preflight        (1 agent)   - verify tools
Phase 1: Data Ingest      (4 parallel) - calendar, gmail, notion, vc pipeline
Phase 2: Analysis          (2 parallel) - meeting prep, warm intro matching
Phase 3: LinkedIn          (3 sequential) - posts, DMs, prospect pipeline
Phase 4: Content           (2-3 sequential) - signals, value routing, brand post
Phase 5: Pipeline          (4 parallel + 1) - temperature, leads, followups, loops, hitlist
Phase 6: Compliance        (2 parallel) - content check, positioning check
Phase 7: Synthesis         (1 agent, opus) - produces schedule JSON
Phase 8: Build + Verify    (build script + visual check + audit)
Phase 9: Notion Write-back (2 parallel) - push actions, update checklists
```

Agents communicate through JSON files in `bus/{date}/`, not through context. This keeps the main context window light.

## Key Design Decisions

- **Apify fails? Auto Chrome.** No stop-and-ask. Falls back silently.
- **Notion API:** Always `mcp__notion_api__*` with `data_source_id` (full UUID). Never truncated IDs.
- **Bus files overwrite** each run. Each day starts clean.
- **Sandwich pattern:** Copy-generating agents read `_auto-fail-checklist.md` before writing.
- **AUDHD-aware:** If enabled, every output follows A1-A7 actionability rules.
