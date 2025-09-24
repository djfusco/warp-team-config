# 🤝 Contributing to Warp Team Configuration

Thank you for contributing to our team's shared Warp configuration! This guide will help you contribute effectively.

## 🎯 Ways to Contribute

### 1. Adding New Workflows
- Create useful workflows in Warp
- Export them using our scripts
- Submit via pull request

### 2. Improving Documentation
- Fix typos or unclear instructions
- Add examples and use cases
- Update troubleshooting guides

### 3. Enhancing Scripts
- Improve the profile manager
- Add new functionality
- Fix bugs

### 4. Reporting Issues
- Report bugs or problems
- Suggest improvements
- Request new features

## 📝 Workflow Guidelines

### Adding Workflows

1. **Test First**: Always test workflows in your personal profile before sharing
2. **Use Descriptive Names**: Make workflow names clear and searchable
3. **Add Descriptions**: Include helpful descriptions for complex workflows
4. **Consider Security**: Never include sensitive data in workflows

### Good Workflow Examples
```json
{
  "name": "Run tests with coverage",
  "command": "npm test -- --coverage",
  "description": "Run all tests and generate coverage report"
}
```

```json
{
  "name": "Deploy to staging environment", 
  "command": "npm run deploy:staging && npm run verify:staging",
  "description": "Deploy to staging and verify deployment success"
}
```

### Bad Workflow Examples
```json
{
  "name": "Do stuff",  // Too vague
  "command": "some-command"
}
```

```json
{
  "name": "Deploy with API key",
  "command": "deploy --api-key=sk_live_abc123...",  // Contains secrets!
  "description": "Deploy to production"
}
```

## 🔄 Contribution Process

### For Workflow Contributions

1. **Switch to team profile**:
   ```bash
   warp-team
   ```

2. **Create and test your workflow in Warp**

3. **Export workflows**:
   ```bash
   cd ~/warp-team-config
   ./scripts/export-workflows.sh
   ```

4. **Review changes**:
   ```bash
   git status
   git diff
   ```

5. **Create a branch**:
   ```bash
   git checkout -b add-workflow-name
   ```

6. **Commit changes**:
   ```bash
   git add workflows/your-new-workflow.json
   git commit -m "Add workflow: descriptive name

   - Brief description of what it does
   - When to use it
   - Any prerequisites"
   ```

7. **Push and create PR**:
   ```bash
   git push origin add-workflow-name
   ```

### For Documentation/Script Changes

1. **Create a branch**:
   ```bash
   git checkout -b improve-documentation
   ```

2. **Make your changes**

3. **Test changes** (for script modifications):
   ```bash
   ./scripts/warp-profile-manager.sh --help
   # Test functionality
   ```

4. **Commit with clear message**:
   ```bash
   git add .
   git commit -m "Improve setup documentation

   - Add troubleshooting for common issue X
   - Clarify installation steps
   - Fix typos in examples"
   ```

5. **Push and create PR**

## 📋 Pull Request Guidelines

### PR Title Format
- `Add workflow: [workflow name]`
- `Fix: [brief description]` 
- `Improve: [what was improved]`
- `Docs: [documentation change]`

### PR Description Template
```markdown
## What does this change?
Brief description of your changes

## Type of change
- [ ] New workflow
- [ ] Bug fix
- [ ] Documentation update
- [ ] Script improvement
- [ ] Other: ___________

## How to test
Steps to test your changes:
1. Step one
2. Step two
3. Expected result

## Screenshots (if applicable)
Add screenshots for UI-related changes

## Checklist
- [ ] I tested this change locally
- [ ] I updated documentation if needed
- [ ] Workflow names are descriptive
- [ ] No sensitive data is included
- [ ] Scripts have proper permissions
```

## ✅ Quality Standards

### Workflow Quality
- **Tested**: All workflows must be tested before submission
- **Documented**: Include clear descriptions
- **Secure**: No secrets, passwords, or sensitive data
- **Portable**: Should work across team member environments

### Code Quality
- **Functional**: Scripts must work on macOS/Linux
- **Readable**: Clear variable names and comments
- **Safe**: Include appropriate error handling
- **Documented**: Update README for new features

### Documentation Quality
- **Clear**: Easy to understand for new team members
- **Complete**: Include all necessary steps
- **Current**: Keep up-to-date with changes
- **Examples**: Provide practical examples

## 🚫 What Not to Include

### Never Include:
- **Passwords or API keys**
- **Personal file paths** (use relative paths or variables)
- **Company-specific secrets**
- **Hardcoded sensitive URLs**

### Avoid:
- **Overly complex workflows** (break into smaller pieces)
- **Workflows with many dependencies** (document requirements)
- **Platform-specific commands** (unless clearly marked)

## 🧪 Testing Guidelines

### Before Submitting Workflows
```bash
# Switch to clean team profile
warp-team

# Test your workflow multiple times
# Try with different inputs (if applicable)
# Verify it works in different directories

# Export and review the JSON
./scripts/export-workflows.sh
jq . workflows/your-new-workflow.json
```

### Testing Script Changes
```bash
# Test profile switching
./scripts/warp-profile-manager.sh create-defaults
./scripts/warp-profile-manager.sh list
./scripts/warp-profile-manager.sh load team
./scripts/warp-profile-manager.sh load private

# Test import/export
./scripts/export-workflows.sh
./scripts/import-workflows.sh
```

## 🐛 Reporting Issues

### Bug Reports
Please include:
1. **System information** (OS, shell, Warp version)
2. **Steps to reproduce** the issue
3. **Expected behavior**
4. **Actual behavior**
5. **Error messages** (if any)
6. **Screenshots** (if helpful)

### Feature Requests
Please include:
1. **Problem description** - what are you trying to solve?
2. **Proposed solution** - how should it work?
3. **Alternatives considered** - other approaches you've thought of
4. **Use cases** - when would this be useful?

## 📚 Resources

### Warp Documentation
- [Warp Workflows Guide](https://docs.warp.dev/features/workflows)
- [Warp Drive](https://docs.warp.dev/features/warp-drive)

### Git Best Practices
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)

### JSON Tools
- [jq Manual](https://stedolan.github.io/jq/manual/)
- [JSON Formatter](https://jsonformatter.org/)

## 🆘 Getting Help

### Stuck?
1. Check the [SETUP.md](SETUP.md) for common issues
2. Review [docs/EXAMPLES.md](docs/EXAMPLES.md) for usage patterns
- Search existing [GitHub issues](https://github.com/djfusco/warp-team-config/issues)
4. Create a new issue if needed

### Questions?
- Ask in team chat
- Create a GitHub discussion
- Tag maintainers in issues

---

**Thanks for helping make our team more productive! 🚀**