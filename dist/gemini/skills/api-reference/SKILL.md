---
name: api-reference
description: Guidance for setting up API reference documentation generators — TypeDoc, Sphinx, godoc, and rustdoc. Detects project language, recommends the right tool, and provides configuration templates. Use when a project needs automated API documentation from source code comments.
version: "1.0.0"
---

# API Reference Generator Guidance

## Philosophy

API reference docs are the **Reference** quadrant of the Diataxis framework — information-oriented, accurate, and complete. They document every public function, class, method, parameter, and return type.

This skill does **not** generate API docs directly — that's the job of language-specific tools (TypeDoc, Sphinx, godoc, rustdoc). Instead, it provides configuration guidance and comment conventions so those tools produce high-quality output.

## Language Detection

Detect the project language to recommend the appropriate tool:

```bash
# Check for language-specific manifest files
[ -f "package.json" ] && echo "javascript/typescript"
[ -f "tsconfig.json" ] && echo "typescript (confirmed)"
[ -f "pyproject.toml" ] || [ -f "setup.py" ] && echo "python"
[ -f "go.mod" ] && echo "go"
[ -f "Cargo.toml" ] && echo "rust"
```

## TypeScript / JavaScript (TypeDoc)

**Tool:** [TypeDoc](https://typedoc.org/) — generates HTML or Markdown documentation from TypeScript source code and JSDoc comments.

### Installation

```bash
npm install --save-dev typedoc
```

### Configuration

Create `typedoc.json` in the project root:

```json
{
  "$schema": "https://typedoc.org/schema.json",
  "entryPoints": ["src/index.ts"],
  "out": "docs/api",
  "plugin": ["typedoc-plugin-markdown"],
  "readme": "none",
  "excludePrivate": true,
  "excludeProtected": true,
  "excludeInternal": true,
  "categorizeByGroup": true,
  "sort": ["source-order"]
}
```

For Markdown output (recommended for GitHub-hosted docs):
```bash
npm install --save-dev typedoc-plugin-markdown
```

### TSDoc Comment Conventions

```typescript
/**
 * Generates a marketing-friendly README from codebase analysis.
 *
 * Scans the project for features, translates them into benefit-driven
 * language, and outputs a complete README.md following the 4-question
 * framework.
 *
 * @param options - Configuration for README generation
 * @param options.projectPath - Path to the project root
 * @param options.format - Output format: 'github' | 'npm' | 'pypi'
 * @returns The generated README content as a string
 * @throws {ProjectNotFoundError} If projectPath doesn't exist
 *
 * @example
 * ```typescript
 * const readme = await generateReadme({
 *   projectPath: './my-project',
 *   format: 'github'
 * })
 * ```
 *
 * @see {@link FeatureExtractor} for the scanning workflow
 * @since 1.0.0
 */
export async function generateReadme(options: ReadmeOptions): Promise<string> {
```

### package.json Script

```json
{
  "scripts": {
    "docs:api": "typedoc"
  }
}
```

## Python (Sphinx or MkDocs + mkdocstrings)

### Option A: Sphinx + autodoc (traditional, feature-rich)

**Installation:**
```bash
pip install sphinx sphinx-autodoc-typehints sphinx-rtd-theme
```

**Quick setup:**
```bash
mkdir docs && cd docs
sphinx-quickstart --no-sep --project "Project Name" --author "Author"
```

**conf.py additions:**
```python
extensions = [
    'sphinx.ext.autodoc',
    'sphinx.ext.napoleon',  # Google/NumPy-style docstrings
    'sphinx_autodoc_typehints',
]

autodoc_member_order = 'bysource'
autodoc_typehints = 'description'
```

### Option B: MkDocs + mkdocstrings (modern, Markdown-native)

**Installation:**
```bash
pip install mkdocs mkdocs-material mkdocstrings[python]
```

**mkdocs.yml:**
```yaml
site_name: Project Name
theme:
  name: material

plugins:
  - search
  - mkdocstrings:
      handlers:
        python:
          options:
            show_source: true
            show_root_heading: true
```

### Python Docstring Conventions (Google style)

```python
def generate_readme(project_path: str, format: str = "github") -> str:
    """Generate a marketing-friendly README from codebase analysis.

    Scans the project for features, translates them into benefit-driven
    language, and outputs a complete README.md following the 4-question
    framework.

    Args:
        project_path: Path to the project root directory.
        format: Output format. One of 'github', 'npm', 'pypi'.
            Defaults to 'github'.

    Returns:
        The generated README content as a string.

    Raises:
        ProjectNotFoundError: If project_path doesn't exist.
        PermissionError: If project_path is not readable.

    Example:
        >>> readme = generate_readme("./my-project", format="github")
        >>> print(readme[:50])
        # My Project
    """
```

## Go (godoc)

Go has built-in documentation tooling. No extra packages needed.

### Comment Conventions

```go
// GenerateReadme produces a marketing-friendly README from codebase analysis.
//
// It scans the project at projectPath for features, translates them into
// benefit-driven language, and returns a complete README following the
// 4-question framework.
//
// The format parameter controls output: "github", "npm", or "pypi".
//
// Example:
//
//	readme, err := GenerateReadme("./my-project", "github")
//	if err != nil {
//	    log.Fatal(err)
//	}
//	fmt.Println(readme)
func GenerateReadme(projectPath, format string) (string, error) {
```

### Running godoc

```bash
# Local documentation server
godoc -http=:6060

# Generate static HTML
go install golang.org/x/pkgsite/cmd/pkgsite@latest
pkgsite -open .
```

## Rust (rustdoc)

Rust has built-in documentation via `cargo doc`. No extra packages needed.

### Comment Conventions

```rust
/// Generates a marketing-friendly README from codebase analysis.
///
/// Scans the project for features, translates them into benefit-driven
/// language, and outputs a complete README following the 4-question
/// framework.
///
/// # Arguments
///
/// * `project_path` - Path to the project root directory
/// * `format` - Output format: `github`, `npm`, or `pypi`
///
/// # Returns
///
/// The generated README content as a `String`.
///
/// # Errors
///
/// Returns `ReadmeError::ProjectNotFound` if the path doesn't exist.
///
/// # Examples
///
/// ```
/// let readme = generate_readme("./my-project", "github")?;
/// println!("{}", &readme[..50]);
/// ```
pub fn generate_readme(project_path: &str, format: &str) -> Result<String, ReadmeError> {
```

### Running rustdoc

```bash
# Generate and open docs
cargo doc --open --no-deps
```

## Integration with Docs Hub

Once API reference docs are generated, link them from the docs hub page:

```markdown
## Reference

- [API Documentation](reference/api.md) — All public functions, types, and interfaces
- [CLI Reference](reference/cli.md) — All commands, flags, and options
```

And from the README documentation section:

```markdown
## Documentation

| Guide | Description |
|-------|-------------|
| ... | ... |
| [API Reference](docs/reference/api.md) | All public types and functions |
```

## Anti-Patterns

- **Don't hand-write API docs** — they go stale instantly. Generate from source code comments.
- **Don't mix API reference with tutorials** — keep them in separate Diataxis quadrants
- **Don't document private/internal APIs** — only document the public surface area
- **Don't skip examples** — every non-trivial function should have a usage example in its docstring
- **Don't use `@inheritdoc` without checking** — inherited docs may not make sense in the subclass context
