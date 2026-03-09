# Changelog

All notable changes to this project are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.18.0](https://github.com/littlebearapps/pitchdocs/compare/v1.17.0...v1.18.0) (2026-03-09)


### Added

* add dark mode logo support and demo screenshot placeholder ([92c4217](https://github.com/littlebearapps/pitchdocs/commit/92c4217d888c7c06532aa80bea1d642cc9eeb19a))
* extract on-demand skills from auto-loaded rules for 56% context token reduction ([#28](https://github.com/littlebearapps/pitchdocs/issues/28)) ([eb0ccb2](https://github.com/littlebearapps/pitchdocs/commit/eb0ccb27b71b1bfdb5d7c084a690afd33667f3d4))

## [Unreleased]

### Added

* **visual-standards skill** — extracted emoji headings, screenshots, device image specs, and caption guidance from auto-loaded `doc-standards` rule into an on-demand skill (`/pitchdocs:visual-standards`)
* **geo-optimisation skill** — extracted GEO patterns (citation capsules, statistics, comparison tables, atomic sections) from auto-loaded `doc-standards` rule into an on-demand skill (`/pitchdocs:geo`)
* **skill-authoring skill** — extracted token budget guidelines for skill authors from auto-loaded `doc-standards` rule into an on-demand skill

### Changed

* **doc-standards rule slimmed by 56%** — reduced from 591 to 168 lines (~5,760 → ~1,872 tokens) by extracting visual, GEO, and token budget sections into on-demand skills; condensed banned phrases table to a single-line list
* **context-quality rule condensed** — removed Signal Gate size guidance (duplicated ai-context skill), condensed tool compatibility table to prose (107 → 59 lines)
* **command instructions deduplicated** — readme, features, and docs-audit commands now reference skills instead of repeating their workflow steps
* **agent instructions trimmed** — removed redundant "load doc-standards rule" from all 3 agents (rules auto-load)
* **skill cross-references updated** — public-readme and pitchdocs-suite skills reference new on-demand skills instead of duplicating content
* **auto-loaded token budget reduced 56%** — from ~7,820 to ~3,415 tokens across all 4 rules

### Documentation

* updated skill/command counts across README, AGENTS.md, CLAUDE.md, llms.txt, and all 6 user guides (15 → 18 skills, 13 → 15 commands)

## [1.17.0](https://github.com/littlebearapps/pitchdocs/compare/v1.16.0...v1.17.0) (2026-03-08)


### Added

* add Signal Gate principle, lifecycle commands, and context health scoring ([#25](https://github.com/littlebearapps/pitchdocs/issues/25)) ([8536449](https://github.com/littlebearapps/pitchdocs/commit/8536449029fcbf541b01e36a5a7c80df78fa5fe0))

## [1.16.0](https://github.com/littlebearapps/pitchdocs/compare/v1.15.0...v1.16.0) (2026-03-07)


### Added

* add auto-memory (MEMORY.md) accommodations to AI context guidance ([#24](https://github.com/littlebearapps/pitchdocs/issues/24)) ([c68175e](https://github.com/littlebearapps/pitchdocs/commit/c68175e71ff11de30ece974f8e72a691ec1c644c))
* add root-level SKILL.md for directory submissions ([7ed7cf9](https://github.com/littlebearapps/pitchdocs/commit/7ed7cf9e6d5fa723e3e91f57a4f67bbb4647daed))


### Documentation

* fix stale counts in other-ai-tools compatibility guide ([27a7fdb](https://github.com/littlebearapps/pitchdocs/commit/27a7fdbac595600110804270ecf3c52ec80e0ed1))

## [1.15.0](https://github.com/littlebearapps/pitchdocs/compare/v1.14.0...v1.15.0) (2026-03-06)


### Added

* add two-tier context doc enforcement to Context Guard ([46e110f](https://github.com/littlebearapps/pitchdocs/commit/46e110f6e8160260a1b26eb69d671f2dc81b09f9))
* add user benefits extraction with persona inference and docs-awareness rule ([c014db5](https://github.com/littlebearapps/pitchdocs/commit/c014db5deb80e92d90c4bbb120465f88ce6d391b))


### Documentation

* improve cross-platform documentation for non-Claude Code users ([0b6d2a5](https://github.com/littlebearapps/pitchdocs/commit/0b6d2a5d459a1fa13f210d058c398139fc12640e))
* sync AI context files with current skill and command counts ([30961d2](https://github.com/littlebearapps/pitchdocs/commit/30961d2a0571eb12290bd8db9a330ebb6dfc37eb))

## [1.14.0](https://github.com/littlebearapps/pitchdocs/compare/v1.13.0...v1.14.0) (2026-03-05)


### Added

* add GitLab and Bitbucket platform support ([3d8fc03](https://github.com/littlebearapps/pitchdocs/commit/3d8fc039132998558049440dc9bccfcab848d1e0))


### Documentation

* strengthen benefit messaging for professional standards, content filter, and context drift ([40bfa7c](https://github.com/littlebearapps/pitchdocs/commit/40bfa7cee7abaab4e8716f35a083282d2adc034d))

## [1.13.0](https://github.com/littlebearapps/pitchdocs/compare/v1.12.1...v1.13.0) (2026-03-05)


### Added

* generate missing AI context files and llms-full.txt ([85c2b69](https://github.com/littlebearapps/pitchdocs/commit/85c2b6918cdb6d456eecc3f93aacb85fa9d4b32c))


### Documentation

* trim README to comply with lobby principle and 4-question test ([9824332](https://github.com/littlebearapps/pitchdocs/commit/9824332fe6f4458c2ce19a7263183614e87b7cf3))

## [1.12.1](https://github.com/littlebearapps/pitchdocs/compare/v1.12.0...v1.12.1) (2026-03-04)


### Documentation

* use pitchdocs: namespace prefix for all user-facing slash commands ([#18](https://github.com/littlebearapps/pitchdocs/issues/18)) ([2a44f73](https://github.com/littlebearapps/pitchdocs/commit/2a44f731207f74b9a8e047b9c3c01c000e090687))

## [1.12.0](https://github.com/littlebearapps/pitchdocs/compare/v1.11.0...v1.12.0) (2026-03-04)


### Added

* add user doc standards — frontmatter, device screenshots, Diátaxis templates ([#16](https://github.com/littlebearapps/pitchdocs/issues/16)) ([84f12b1](https://github.com/littlebearapps/pitchdocs/commit/84f12b18b8d10889f67817168b2a2dccf0b1d5e1))

## [1.11.0](https://github.com/littlebearapps/pitchdocs/compare/v1.10.0...v1.11.0) (2026-03-04)


### Added

* add workflow, troubleshooting, and reference guides ([0a5b82b](https://github.com/littlebearapps/pitchdocs/commit/0a5b82b6aa07d7307cb043bf8f6577ee89cb40db))


### Documentation

* fix context-quality rule description in AGENTS.md ([98b3c77](https://github.com/littlebearapps/pitchdocs/commit/98b3c77fa5409d3922021b60e5c10d85385f5336))
* fix quick start wording and expand documentation links ([a425b54](https://github.com/littlebearapps/pitchdocs/commit/a425b5477d333524a562b6812219234c2a11dfac))
* fix stale counts and broken anchor links in guides ([11af31a](https://github.com/littlebearapps/pitchdocs/commit/11af31ab6e886b9725ec0ac4dae940df4b571646))

## [1.10.0](https://github.com/littlebearapps/pitchdocs/compare/v1.9.0...v1.10.0) (2026-03-02)


### Added

* add content filter mitigation rule, hook, and guidance ([#13](https://github.com/littlebearapps/pitchdocs/issues/13)) ([a88db5a](https://github.com/littlebearapps/pitchdocs/commit/a88db5a0da22c8c986725e0aebeb2f902f74bade))

## [1.9.0](https://github.com/littlebearapps/pitchdocs/compare/v1.8.1...v1.9.0) (2026-03-01)


### Added

* add JTBD mapping, B2B value framework, Time to Hello World, and security credibility extraction ([f941dac](https://github.com/littlebearapps/pitchdocs/commit/f941dacd478d572ff4198b992505125af79cf63a))
* add Lobby Principle for README conciseness with structural budgets ([8a580ee](https://github.com/littlebearapps/pitchdocs/commit/8a580eeac0ce2b64d0320fbe464186abf6cb457e))
* recommend emoji+bold+em-dash as default feature list format ([65c87ad](https://github.com/littlebearapps/pitchdocs/commit/65c87ad0541700944ae1f8dad122933c0ba652c1))


### Documentation

* add paragraph break in What PitchDocs Does section ([ec11249](https://github.com/littlebearapps/pitchdocs/commit/ec11249b7eb32804bf273751fcd42f1d50b66c95))
* add upstream spec tracking and reusability to features list ([fda18eb](https://github.com/littlebearapps/pitchdocs/commit/fda18eb57f7678054f0b9bdca0d19321ac795c6a))
* clean up README hero and add optional hooks install step ([0f25878](https://github.com/littlebearapps/pitchdocs/commit/0f25878b6fa134b9539fc70451bc66d31b0b9759))
* condense README body, remove Why section, improve How It Works diagram ([e5e11f1](https://github.com/littlebearapps/pitchdocs/commit/e5e11f1cd9b7a681cc28b947b7c063b6f2a0566a))
* fix mermaid diagram — compact LR layout, use br tags for line breaks ([7a8678a](https://github.com/littlebearapps/pitchdocs/commit/7a8678a910a008caac7dbaaea99d9df2b8137fd0))
* remove By the Numbers table from README ([1ebe6e6](https://github.com/littlebearapps/pitchdocs/commit/1ebe6e6df11236e8739173bcd18be8a0df4f4b28))
* rewrite features as emoji+bold+em-dash bullets (Untether style) ([1aab3c5](https://github.com/littlebearapps/pitchdocs/commit/1aab3c5ba7e547c292c5984f7492da7246fbe413))
* rewrite What PitchDocs Does — problem-first, one paragraph, no diagram ([61eb6a7](https://github.com/littlebearapps/pitchdocs/commit/61eb6a779604ed2c4af99169e5562a02fbc5521f))
* trim README and move detailed setup guides to docs/ ([426bf5a](https://github.com/littlebearapps/pitchdocs/commit/426bf5aabecc88047d7fd925b2fd75ac6e8b176e))

## [1.8.1](https://github.com/littlebearapps/pitchdocs/compare/v1.8.0...v1.8.1) (2026-02-28)


### Fixed

* handle both relative and absolute paths in structural change hook ([d9562e7](https://github.com/littlebearapps/pitchdocs/commit/d9562e7a21a320bd2b62df2257db7ef098bd1879))

## [1.8.0](https://github.com/littlebearapps/pitchdocs/compare/v1.7.0...v1.8.0) (2026-02-28)


### Added

* add context-guard hooks for AI context file freshness ([ce0e47f](https://github.com/littlebearapps/pitchdocs/commit/ce0e47f615ce7bd6c5d8388b0b74b2e870a7d6c7))
* notify littlebearapps.com on new releases ([de2ab32](https://github.com/littlebearapps/pitchdocs/commit/de2ab328955c706cd7a8254d1024eb67e9f01c67))

## [1.7.0](https://github.com/littlebearapps/pitchdocs/compare/v1.6.0...v1.7.0) (2026-02-28)


### Added

* add /doc-refresh command for version-bump documentation updates ([58af69b](https://github.com/littlebearapps/pitchdocs/commit/58af69b2d278c3c0d7a7768ed180b55c82b21797))
* add AGENTS.md spec to upstream version tracking with v1.1 feature monitoring ([c8c9fa3](https://github.com/littlebearapps/pitchdocs/commit/c8c9fa38ce92d09d06c4a18a392b0a297c494dc4))
* add cross-platform AI tool setup instructions ([3746e05](https://github.com/littlebearapps/pitchdocs/commit/3746e053c071d160b69eac411e240c27dafaff16))
* add cross-platform AI tool setup instructions and AGENTS.md ([b0253df](https://github.com/littlebearapps/pitchdocs/commit/b0253dfd1a0cff0d1ca069ef7d5551fc71d89597))
* add feature-benefits skill and /features command ([d22d9ec](https://github.com/littlebearapps/pitchdocs/commit/d22d9ecc7c5ff908acc4a56efc1f06c65c560325))
* add GEO optimisation, AI context files, docs verification, and launch artifacts ([9bd7a5e](https://github.com/littlebearapps/pitchdocs/commit/9bd7a5e4ee1498ec7d6a2ee1f22e00a8ae908dbc))
* add GitHub repository metadata auditing (topics, website, description) ([ac16eef](https://github.com/littlebearapps/pitchdocs/commit/ac16eef5f8fd73de59b42918bbb5b52805c2c245))
* add llms.txt generation, licence guidance, visual assets, and expanded audit ([7aa4a91](https://github.com/littlebearapps/pitchdocs/commit/7aa4a9178da5bf65b78101ea9ec5fdc0cd4cc770))
* add npm and PyPI package registry documentation guidance ([38540d4](https://github.com/littlebearapps/pitchdocs/commit/38540d4ff1aad7136628d9689535d85730668751))
* add numeric quality scoring (0-100) to docs-verify with grade bands and CI export ([e3a670f](https://github.com/littlebearapps/pitchdocs/commit/e3a670f7fb23a7a57cb07bc0dab5d1cea50ee1a3))
* add PitchDocs logo and update README header ([1b5f018](https://github.com/littlebearapps/pitchdocs/commit/1b5f018925ea2b1105eb4e588dc6988d5e825083))
* add release-please automated versioning ([562b0c1](https://github.com/littlebearapps/pitchdocs/commit/562b0c186d305e1734e263077e279a756ebadf33))
* add repo docs, upstream drift detection, and GitHub templates ([0a70c43](https://github.com/littlebearapps/pitchdocs/commit/0a70c439508d03b0f51a505b29b974e1ffb6d746))
* add security scan check to docs-verify and docs-writer validation ([a1987a1](https://github.com/littlebearapps/pitchdocs/commit/a1987a16429c767a07a86155db96e68f09308fe4))
* add token budget guidelines to doc-standards and token audit check to docs-verify ([053ef50](https://github.com/littlebearapps/pitchdocs/commit/053ef5032fc0c623cb4e50a47b226db58834a2ad))
* add version and upstream fields to all skill frontmatter ([3989731](https://github.com/littlebearapps/pitchdocs/commit/3989731516e34750a0a9145bcc428559e1a660b6))
* add Windsurf, Cline, and Gemini CLI context file generation to ai-context skill ([54df3e1](https://github.com/littlebearapps/pitchdocs/commit/54df3e178cc82216f18f324484da89c14a8cbe38))
* enhance link validation with 4 detection patterns and add docs-ci workflow ([2cd88c5](https://github.com/littlebearapps/pitchdocs/commit/2cd88c540dcef1052d26c545c9df11d37663d0ca))
* increase README logo size and add logo guidance to skills/rules ([c75d350](https://github.com/littlebearapps/pitchdocs/commit/c75d350180a887458108fc7fb63b2d902c1fee54))
* initial repo-docs plugin with marketing-friendly documentation generation ([9b37e73](https://github.com/littlebearapps/pitchdocs/commit/9b37e736c3a654113117dc2e6ef2a3c478ed1cdc))
* PitchDocs v1.5.0 — GEO, AI context, docs verification, launch artifacts ([2fd32c1](https://github.com/littlebearapps/pitchdocs/commit/2fd32c1805794b068b8ba58abc3c850b26514014))
* rename plugin from repo-docs to PitchDocs ([6843e3f](https://github.com/littlebearapps/pitchdocs/commit/6843e3f86b3d9601a509a77a5f975ecf4714150f))
* self-audit improvements — AI context files, comparison table, user guide ([6d91796](https://github.com/littlebearapps/pitchdocs/commit/6d91796d78187f1d1fe465daf9f6735cdd39d3f9))
* use project type auto-detection to select writing tone and template in docs-writer agent ([7e91f70](https://github.com/littlebearapps/pitchdocs/commit/7e91f700e1d4b92bdca9ade978016cdff8124a91))


### Fixed

* add content filter mitigations and visual formatting guidance ([0e89233](https://github.com/littlebearapps/pitchdocs/commit/0e892334fd1ef42d63d2327a95bbe833236ab003))
* add license embed detection and manifest-match validation to pitchdocs-suite ([4d91287](https://github.com/littlebearapps/pitchdocs/commit/4d91287f9f15314f21f8b3a127f87efa1ad3dbac))
* add missing colour to version badge in README ([92a679c](https://github.com/littlebearapps/pitchdocs/commit/92a679c2001a92c70d6096fdc49bab1a740ca741))
* improve hero tagline clarity and features section readability ([c439044](https://github.com/littlebearapps/pitchdocs/commit/c439044d309004fcc94bb72b34de9538f5533c0c))
* increase logo breathing room with double br tag ([87c7744](https://github.com/littlebearapps/pitchdocs/commit/87c7744856ce57b13e389f460a4ae3cb0686af38))
* reduce logo spacing from double to single br tag ([8f4c1d8](https://github.com/littlebearapps/pitchdocs/commit/8f4c1d89025742fddda0150e46f947e56a93b3c0))
* refine hero copy with GitHub repo focus, features extraction, and SEO/GEO ([8210f31](https://github.com/littlebearapps/pitchdocs/commit/8210f31879c28bb43a19254167516e5d7e1433d7))
* rework README hero, get started, and use-case sections ([64c08d1](https://github.com/littlebearapps/pitchdocs/commit/64c08d17fdb7030cef349fdd6c4691d817baa230))
* use query-param badge URL so release-please preserves colour ([f39c1f0](https://github.com/littlebearapps/pitchdocs/commit/f39c1f02a543c709444f1e38dafc2f5209bd53a2))
* use separate p blocks for README hero spacing ([f1ce395](https://github.com/littlebearapps/pitchdocs/commit/f1ce39535fd4c3af693f231a5ec9040075ae1a95))


### Documentation

* add before-after screenshots and move showcase to top of README ([6d482d3](https://github.com/littlebearapps/pitchdocs/commit/6d482d38cc74826d3398da448adb583715f024ea))
* add v1.6.0 changelog, bump version to 1.6.0, and update README features ([5ad5b75](https://github.com/littlebearapps/pitchdocs/commit/5ad5b755b85c3fa9aaf86c98df5a6c8330e5cfda))
* enhance public repo docs with benefits, comparison, and completeness fixes ([2e1cfb3](https://github.com/littlebearapps/pitchdocs/commit/2e1cfb310e0ac7b059753efa0748a8be55cbd1ed))
* pre-submission fixes for awesome list and directory submissions ([339fa85](https://github.com/littlebearapps/pitchdocs/commit/339fa851e186e8e9d6a6430e9c0c34162eff8294))
* propagate enhanced hero, use-case framing, and bold+em-dash patterns into plugin guidance ([536412a](https://github.com/littlebearapps/pitchdocs/commit/536412a8a64084ad5dab3b79352574df24e275de))
* remove Australian English enforcement, update README hero ([9d962a0](https://github.com/littlebearapps/pitchdocs/commit/9d962a0edf133179d266ced30a345a059f081e50))
* restructure README to follow plugin's own Banesullivan framework ([6a09ce0](https://github.com/littlebearapps/pitchdocs/commit/6a09ce0710252c81eb7185ba03d77c018af19d60))
* update getting-started guide and docs hub for v1.6.0 features ([ba068dd](https://github.com/littlebearapps/pitchdocs/commit/ba068dd9a67ba3baa587f968f8e39c7a8743727a))
* update homepage URL to littlebearapps.com/tools/pitchdocs ([610f789](https://github.com/littlebearapps/pitchdocs/commit/610f789547ed40434e52da4b47747a243620bc6f))
* update README to reflect new bullets mode and enhanced skill descriptions ([1eae311](https://github.com/littlebearapps/pitchdocs/commit/1eae311a67e2aac015985c3b4f8730fe83196afc))
* use Claude logo badge and clarify before/after README examples ([dc379bc](https://github.com/littlebearapps/pitchdocs/commit/dc379bcf48f24e301a7f39ded92e8b967dc436a2))

## [1.6.0](https://github.com/littlebearapps/pitchdocs/compare/v1.5.0...v1.6.0) (2026-02-28)

### Added

- **Numeric quality scoring (0–100)** — `/docs-verify score` rates documentation across 5 dimensions (completeness, structure, freshness, link health, evidence) with A–F grade bands — CI mode exports `PITCHDOCS_SCORE` and `PITCHDOCS_GRADE`, supports `--min-score N` threshold
- **Security scanning for generated docs** — `/docs-verify` detects leaked credentials, internal paths (`/Users/`, `/home/`), and internal hostnames so you can catch accidental exposure before shipping
- **Enhanced link validation** — 4 new detection patterns: case-sensitive path checks, fragment-only anchor validation, redirect chain detection, and relative link resolution from nested docs directories
- **Docs CI workflow** — ready-to-use `.github/workflows/docs-ci.yml` with markdownlint-cli2 and lychee link checking, triggered on Markdown changes and monthly schedule
- **Token budget guidelines** — skill token cost targets (reference <3K, workflow <4K, combined <5K) in `doc-standards` rule, plus token audit check in `/docs-verify` to flag oversized skills
- **Skill version tracking** — all 12 skills carry `version:` and `upstream:` fields in YAML frontmatter for provenance and drift detection
- **Project type auto-detection** — docs-writer agent classifies repos (library, CLI, web-app, API, plugin, docs-site, monorepo) and selects writing tone, hero emphasis, and quick start style automatically
- **Windsurf, Cline, and Gemini CLI context files** — `/ai-context` generates `.windsurfrules`, `.clinerules`, and `GEMINI.md` alongside existing formats (7 AI context files total, 9 AI tools supported)
- **AGENTS.md spec tracking** — upstream version monitoring for the AGENTS.md v1.0 spec with v1.1 feature watch (8 upstream specs tracked total)
- **Licence embed detection** — pitchdocs-suite validates that verbatim licence text isn't accidentally embedded in skill/rule/context files, and cross-checks manifest `license` field against the LICENSE file

### Changed

- docs-verify skill version bumped to 1.3.0 (quality scoring, enhanced links, security scan, token audit)
- ai-context skill version bumped to 1.1.0 (3 new context file formats, spec tracking)
- doc-standards rule expanded with token budget guidelines section
- docs-writer agent validation now includes security scan checklist items and project type classification
- Plugin keywords updated for v1.6.0

### Fixed

- Licence file extension check — flags `LICENSE.md` (GitHub prefers extensionless `LICENSE` for automatic detection)

## [1.5.0](https://github.com/littlebearapps/pitchdocs/compare/v1.4.1...v1.5.0) (2026-02-26)

### Added

- **GEO (Generative Engine Optimisation)** — new section in `doc-standards` rule with crisp definitions, atomic sections, concrete statistics, comparison tables, TL;DR blocks, and cross-referencing patterns structured for LLM citation
- **GEO patterns in `public-readme` skill** — first-paragraph-as-definition guidance, comparison table optimisation for "X vs Y" queries, and semantic heading hierarchy enforcement
- **Diataxis framework** in `user-guides` skill — classify docs into tutorials, how-to guides, reference, and explanation quadrants with updated directory layout
- **`ai-context` skill and `/ai-context` command** — generate AGENTS.md, CLAUDE.md, .cursorrules, and .github/copilot-instructions.md from codebase analysis with staleness audit mode
- **`docs-verify` skill and `/docs-verify` command** — validate broken links, stale content (90-day threshold via git blame), llms.txt sync, heading hierarchy, image alt text, badge URLs, and feature coverage with CI-friendly output
- **`launch-artifacts` skill and `/launch` command** — transform README/CHANGELOG into Dev.to articles, Hacker News "Show HN" posts, Reddit posts, Twitter/X threads, awesome list submission PRs, and social preview image guidance
- **`api-reference` skill** — configuration templates and comment conventions for TypeDoc, Sphinx/mkdocstrings, godoc, and rustdoc with language auto-detection
- **AI context files in `pitchdocs-suite` inventory** — AGENTS.md and copilot-instructions.md at Tier 2, CLAUDE.md and .cursorrules at Tier 3
- **Diataxis coverage check in `/docs-audit`** — flags missing documentation quadrants
- **AI context staleness check in `/docs-audit`** — verifies context files match current codebase
- **Documentation verification check in `/docs-audit`** — recommends `/docs-verify` for comprehensive validation
- **Enhanced user guide patterns** — copy-paste-ready code examples, error recovery with collapsible troubleshooting, video/screencast placement guidance, and Diataxis cross-links
- **GitHub Actions docs CI template** — markdownlint + lychee link checking workflow in `docs-verify` skill

### Changed

- `pitchdocs-suite` audit scan now checks for AGENTS.md, CLAUDE.md, .cursorrules, and copilot-instructions.md
- `docs-writer` agent now references 4 additional skills (ai-context, docs-verify, launch-artifacts, api-reference)
- Docs inventory expanded from 17+ to 20+ files across all tiers
- Plugin version bumped to 1.5.0 with new keywords (seo, geo, ai-context, agents-md, diataxis)

## [1.4.1](https://github.com/littlebearapps/pitchdocs/compare/v1.4.0...v1.4.1) (2026-02-26)


### Fixed

* add content filter mitigations and visual formatting guidance ([0e89233](https://github.com/littlebearapps/pitchdocs/commit/0e892334fd1ef42d63d2327a95bbe833236ab003))
* add missing colour to version badge in README ([92a679c](https://github.com/littlebearapps/pitchdocs/commit/92a679c2001a92c70d6096fdc49bab1a740ca741))
* use query-param badge URL so release-please preserves colour ([f39c1f0](https://github.com/littlebearapps/pitchdocs/commit/f39c1f02a543c709444f1e38dafc2f5209bd53a2))

## [1.4.0](https://github.com/littlebearapps/pitchdocs/compare/v1.3.0...v1.4.0) (2026-02-25)


### Added

* rename plugin from repo-docs to PitchDocs ([6843e3f](https://github.com/littlebearapps/pitchdocs/commit/6843e3f86b3d9601a509a77a5f975ecf4714150f))

## [1.3.0](https://github.com/littlebearapps/pitchdocs/compare/v1.2.0...v1.3.0) (2026-02-25)


### Added

* add npm and PyPI package registry documentation guidance ([38540d4](https://github.com/littlebearapps/pitchdocs/commit/38540d4ff1aad7136628d9689535d85730668751))
* add release-please automated versioning ([562b0c1](https://github.com/littlebearapps/pitchdocs/commit/562b0c186d305e1734e263077e279a756ebadf33))

## [1.2.0] - 2026-02-25

### Added

- `llms-txt` skill — llmstxt.org specification reference with generation patterns for repos and docs sites
- `/llms-txt` command — generate llms.txt and llms-full.txt for LLM-friendly content curation
- LICENSE selection framework with decision guidance in `repo-docs-suite` skill
- Visual assets guidance — storage locations, formats, naming conventions, alt text requirements
- Social preview image audit check (1280×640, Settings reminder)
- SUPPORT.md template in `repo-docs-suite` Tier 2
- `.github/release.yml` template for auto-generated GitHub Release notes
- CITATION.cff template (conditional, Tier 3) for academic/research projects
- llms.txt, SUPPORT.md, release.yml, and CITATION.cff presence checks in `/docs-audit`
- Visual assets presence check in `/docs-audit`
- GitHub repository metadata checks in `/docs-audit` — topics, website URL, and description
- Topic suggestion framework in `repo-docs-suite` skill based on project type, language, and ecosystem
- Repository metadata step in `docs-writer` agent workflow
- Validation checklist additions in `docs-writer` agent — visual elements, LICENSE match, social preview, llms.txt

## [1.1.0] - 2026-02-25

### Added

- `feature-benefits` skill — systematic codebase scanning for features with evidence-based benefit translation
- `/features` command — standalone feature extraction with inventory, table, and audit modes
- Feature coverage check in `/docs-audit` — detects undocumented and over-documented features
- Feature-to-Benefit writing principles in `doc-standards` rule

### Changed

- `docs-writer` agent Step 2 now uses the 5-step Feature Extraction Workflow instead of vague bullet points
- `/readme` command loads `feature-benefits` skill and verifies evidence-based features
- `public-readme` skill includes guidance on populating features tables from codebase scans

## [1.0.0] - 2026-02-25

### Added

- `/readme` command — generate marketing-friendly READMEs with the Daytona/Banesullivan 4-question framework
- `/changelog` command — generate changelogs from git history with user-benefit language
- `/roadmap` command — generate roadmaps from GitHub milestones and issues
- `/docs-audit` command — audit documentation completeness across 14 file types
- `/user-guide` command — generate task-oriented user guides in `docs/guides/`
- `public-readme` skill — README structure with hero section, benefit-driven features, and comparison tables
- `changelog` skill — Keep a Changelog format with language transformation rules
- `roadmap` skill — Roadmap structure from GitHub Projects with emoji status indicators
- `repo-docs-suite` skill — complete repo docs inventory with templates for CONTRIBUTING, CODE_OF_CONDUCT, SECURITY, and GitHub templates
- `user-guides` skill — task-oriented how-to documentation with hub page and cross-linking
- `docs-writer` agent — long-form documentation generation with codebase analysis
- `doc-standards` rule — tone, language, badges, and the 4-question framework
- Monthly upstream spec drift detection via GitHub Actions
- Upstream version tracking for Keep a Changelog, Contributor Covenant, Conventional Commits, and Semantic Versioning

[1.2.0]: https://github.com/littlebearapps/pitchdocs/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/littlebearapps/pitchdocs/compare/v1.0.0...v1.1.0
[1.0.0]: https://github.com/littlebearapps/pitchdocs/releases/tag/v1.0.0
