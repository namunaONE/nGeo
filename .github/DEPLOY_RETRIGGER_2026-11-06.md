# Deploy re-trigger — 2026-11-06

The `deploy-pages` job on main run #329 (commit 8afad39, run 42237990291) hit the
known GitHub Pages platform timeout ("Timeout reached, aborting!" at 10m23s) after a
successful build and artifact upload. This comment-only marker re-triggers the full
pipeline so the site deploy can land. No content or behavior change.

References:
- https://github.com/orgs/community/discussions/212117
- https://github.com/namunaONE/nGeo/actions/runs/42237990291
