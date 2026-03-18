---
name: q-debrief
description: "Post-conversation extraction. Use after any call with an investor, customer, partner, or advisor. Highest priority workflow. Auto-triggers when a conversation transcript is pasted."
user-invocable: true
---

# Structured Debrief

Run the full debrief workflow using the template at `${CLAUDE_SKILL_DIR}/../../templates/debrief-template.md`.

## Instructions

1. Read the debrief template
2. If conversation text was provided via $ARGUMENTS, use it as input
3. If no text provided, ask the founder: "Who did you talk to? Paste the transcript, summary, or tell me what happened."
4. Run all 12 strategic implication lenses from the template
5. Route extracted insights to the correct canonical files:
   - New objections -> `q-system/canonical/objections.md`
   - New talk track language -> `q-system/canonical/talk-tracks.md`
   - Relationship updates -> `q-system/my-project/relationships.md`
   - Market intel -> `q-system/canonical/market-intelligence.md`
   - Competitive intel -> `q-system/my-project/competitive-landscape.md`
6. For practitioner/buyer conversations: generate a Design Partner conversion message (copy-paste ready)
7. Create follow-up Actions in Notion if configured

## Key Rules
- DEBRIEF is the highest-priority workflow
- Mark unvalidated claims with {{UNVALIDATED}}
- Check canonical files before asserting any product claim
