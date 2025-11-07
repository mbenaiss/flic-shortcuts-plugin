# Contributing to Flic Shortcuts Plugin

Thank you for your interest in contributing! This guide will help you get started.

## Ways to Contribute

### 1. Share Your Shortcuts

Have a useful shortcut? Share it with the community!

**How to share:**
1. Create your shortcut script
2. Test it thoroughly
3. Add documentation
4. Submit a Pull Request

**Submission format:**
```
shortcuts/community/
└── your-username/
    ├── shortcut-name.sh
    └── README.md
```

### 2. Report Bugs

Found a bug? Open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- System info (macOS version, Flic version)

### 3. Suggest Features

Have an idea? Open an issue with:
- Clear description of the feature
- Use case and benefits
- Example implementation (if possible)

### 4. Improve Documentation

- Fix typos
- Add examples
- Improve clarity
- Translate to other languages

## Development Guidelines

### Code Style

**Shell Scripts:**
- Use `#!/bin/bash` or `#!/bin/sh`
- Add descriptive comments
- Follow existing formatting
- Make scripts executable

**JSON Files:**
- Use 2-space indentation
- Validate JSON syntax
- Keep consistent structure

### Testing

Before submitting:
1. Test on macOS (latest version preferred)
2. Verify script permissions
3. Check for errors
4. Test with Flic app

### Commit Messages

Use clear, descriptive commit messages:
```
Add: New Spotify control shortcut
Fix: Microphone toggle script error
Update: README with AppleScript examples
```

## Pull Request Process

1. **Fork the repository**
2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow guidelines above
   - Test thoroughly

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: Your feature description"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**
   - Clear description
   - Link related issues
   - Add screenshots if applicable

## Project Structure

```
Keyboard Shortcuts.FlicPlugin/
├── shortcuts/
│   ├── keyboard/      # Keyboard shortcuts
│   ├── system/        # System commands
│   ├── apps/          # App-specific
│   └── community/     # Community contributions
├── tools/
│   ├── shortcut-generator.sh
│   └── templates/
└── docs/              # Additional documentation
```

## Community Guidelines

- Be respectful and constructive
- Help others when you can
- Share knowledge and experiences
- Follow the Code of Conduct

## Questions?

Open an issue with the `question` label or reach out to the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing! 🎉
