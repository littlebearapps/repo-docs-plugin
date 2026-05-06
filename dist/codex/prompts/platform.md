---
description: "Detect hosting platform and report PitchDocs feature support: $ARGUMENTS"
argument-hint: "[github|gitlab|bitbucket or auto-detect]"
allowed-tools:
  - Read
  - Glob
  - Grep
  - Bash
---

# /platform

Detect the repository's hosting platform and report which PitchDocs features are fully supported, limited, or unavailable.

## Behaviour

1. Load the `platform-profiles` skill
2. Auto-detect the platform from git remote URL and CI config files:
   ```bash
   # Check CI config files
   [ -f ".gitlab-ci.yml" ] && echo "gitlab"
   [ -f "bitbucket-pipelines.yml" ] && echo "bitbucket"
   [ -d ".github" ] && echo "github"
   # Fallback: git remote URL
   git remote get-url origin 2>/dev/null | grep -oE '(github|gitlab|bitbucket)' | head -1
   ```
3. If an argument is provided, use it as the platform override
4. Report:
   - Detected platform
   - Template directory paths for this platform
   - Badge URL patterns for this platform
   - Markdown rendering limitations (if any)
   - CI/CD and release automation equivalents
   - Features that are unavailable or limited on this platform
   - Recommended workarounds for any limitations

## Arguments

- No arguments: auto-detect from git remote and CI config
- `github`: Force GitHub platform profile
- `gitlab`: Force GitLab platform profile
- `bitbucket`: Force Bitbucket platform profile

## Output

Print a platform report to the chat — do not write any files.
