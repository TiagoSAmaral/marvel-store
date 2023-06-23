fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios lint_code

```sh
[bundle exec] fastlane ios lint_code
```

Check code style

### ios clear_xcov_report

```sh
[bundle exec] fastlane ios clear_xcov_report
```

Clear XCov output folder

### ios coverage

```sh
[bundle exec] fastlane ios coverage
```

Create coverage report

### ios check_code

```sh
[bundle exec] fastlane ios check_code
```

Used by Development to keep code quality. Use command: 'fastlane check_code dev:true'

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
