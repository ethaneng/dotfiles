---
description: Research the current topic with grounded, up-to-date web sources
agent: plan
---
Research the user's current topic or problem using the active conversation context and any explicit details below.

User request:

$ARGUMENTS

Requirements:

- Use web research to gather grounded, current information that is directly relevant to the user's topic or problem.
- If `$ARGUMENTS` is brief or missing, infer the topic from the current conversation before asking for clarification.
- Prioritize authoritative and recent sources such as official docs, changelogs, specs, vendor posts, standards, or well-maintained project resources.
- Call out source freshness when possible, especially for fast-moving tools, APIs, libraries, and platform behavior.
- Separate confirmed facts from interpretation, recommendation, or speculation.
- Summarize the key findings for the user's situation, include practical next steps, and cite the sources you relied on.
- If sources conflict or appear stale, say that clearly and explain which guidance is safest to trust.
