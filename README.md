# jollycast

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## CI/CD

This project uses GitHub Actions for continuous integration and deployment.

### Continuous Integration

The CI pipeline runs automatically on:
- Push to `master`, `main`, or `develop` branches
- Pull requests to `master`, `main`, or `develop` branches

The CI pipeline includes:
- **Code Quality Checks**: Format verification and static analysis
- **Tests**: Unit and widget tests with coverage reports
- **Builds**: Automated builds for all supported platforms:
  - Android (APK and App Bundle)
  - iOS
  - Web
  - Windows
  - Linux
  - macOS

Build artifacts are automatically uploaded and available for 30 days.

### Releases

To create a release:
1. Create and push a git tag with version format: `v1.0.0`
2. The release workflow will automatically:
   - Build Android APK and App Bundle
   - Build Web version
   - Create a GitHub release with the artifacts

Example:
```bash
git tag v1.0.0
git push origin v1.0.0
```

### Workflow Files

- `.github/workflows/ci.yml` - Main CI pipeline
- `.github/workflows/release.yml` - Automated release workflow
