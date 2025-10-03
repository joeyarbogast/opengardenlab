## Story 1.10: CI/CD Pipeline Setup with GitHub Actions

**Story File:** `docs/stories/1.10.cicd-pipeline-github-actions.md`

**As a** developer,
**I want** automated testing and build pipelines using GitHub Actions,
**so that** I can catch bugs early, ensure code quality, and automate builds for firmware and mobile app.

### Acceptance Criteria
1. GitHub Actions workflow file created: `.github/workflows/ci.yml`
2. Firmware testing pipeline configured:
   - Install Python dependencies (requirements.txt)
   - Run pytest for all firmware unit tests
   - Run Python linter (flake8 or pylint)
   - Execute on every pull request and push to main branch
3. Mobile app build pipeline configured:
   - Build Android APK (debug variant)
   - Run unit tests (JUnit for Kotlin or NUnit for .NET MAUI)
   - Run lint checks (Android Lint)
   - Execute on every pull request and push to main branch
4. Test framework dependencies added:
   - `pytest` added to `firmware/requirements.txt`
   - JUnit/Espresso (Kotlin) or NUnit (.NET MAUI) configured in mobile app
5. CI status badge added to README.md showing build status
6. First CI run completes successfully (all tests pass)

### Labels
- `epic-1`
- `story`
