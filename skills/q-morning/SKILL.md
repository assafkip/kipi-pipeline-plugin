---
name: q-morning
description: "Run the full morning routine pipeline. 9 phases, 24 agents, produces a daily HTML action plan. Use when the user says 'morning', 'q-morning', 'daily routine', 'start my day', or 'what should I do today'."
user-invocable: true
---

# Morning Routine Pipeline

Run the full morning routine using the agent pipeline orchestrator.

## Instructions

1. Read the orchestrator: `${CLAUDE_SKILL_DIR}/../../agents/step-orchestrator.md`
2. Follow it exactly. It defines 9 phases of sub-agent execution.
3. Replace template variables:
   - `{{DATE}}` = today's date (YYYY-MM-DD)
   - `{{BUS_DIR}}` = `q-system/.q-system/agent-pipeline/bus/{date}`
   - `{{AGENTS_DIR}}` = the plugin's agents directory
   - `{{QROOT}}` = the project's q-system directory
4. Spawn sub-agents per phase using the Agent tool with each agent's prompt file.
5. After Phase 8 (build), run the audit:
   ```bash
   python3 ${CLAUDE_SKILL_DIR}/../../scripts/bus-to-log.py {date}
   python3 ${CLAUDE_SKILL_DIR}/../../scripts/audit-morning.py q-system/output/morning-log-{date}.json
   ```
6. Show the audit output to the founder.

## Key Rules
- Do NOT read commands.md or preflight.md in full (token discipline)
- Do NOT skip steps to save context. Tell the founder if context is low.
- If Apify fails, auto-fallback to Chrome (do not ask)
- Bus files are overwritten each run, never appended
- Notion: use `mcp__notion_api__*` tools with data_source_id (full UUID) from `q-system/my-project/notion-ids.md`
