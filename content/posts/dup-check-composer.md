---
title: "Duplication Check — Composer (structure)"
date: 2025-08-23
publishDate: 2025-08-23
lastmod: 2025-08-23
draft: true

# ✅ This flag should make route-post.html choose the "structure" renderer
structure:
  # Use a NO-OP block name that your render-block will just skip or label.
  # If your render-block requires a known block, change "noop" to any simple block you know you have
  # e.g. "prose" or "markdown" with a `content:` field.
  - block: prose
    content: |
      Hello from Composer.

# Optional: turn on your green diagnostics if you still have them
composer_debug: true
---

If your renderer supports a simple text block instead of noop, replace the structure above with:
structure:
  - block: prose
    content: |
      Body rendered via Composer.
