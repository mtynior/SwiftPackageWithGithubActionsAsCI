# GACalc
A simple package to show how to setup and use GitHub Actions as a CI for Swift Packages

<div align="center">
  <img src="https://img.shields.io/badge/language-Swift-orange" />
  <a href="https://github.com/mtynior/GACalc/actions/workflows/test_and_get_codecov.yml">
    <img src="https://github.com/mtynior/GACalc/actions/workflows/test_and_get_codecov.yml/badge.svg?branch=main"/>
  </a>
  <a href="https://codecov.io/gh/mtynior/GACalc">
    <img src="https://codecov.io/gh/mtynior/GACalc/branch/main/graph/badge.svg?token=U3YPVL4SR5"/>
  </a>
</div>

## Available environments on GitHib
List of the all available environments and tools is [here](https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md)

## Actions
Below you will find a list of actions that can be used for Swift Package Development. Simply create a new action on GitHub, and copy & paste the code.

### Build package
```yaml
name: Build Package

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-11

    steps:
    - uses: actions/checkout@v2
        
    - name: Build
      run: swift build -v
``` 

### Test package
```yaml
name: Test Package

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: macos-11

    steps:
    - uses: actions/checkout@v2
        
    - name: Build Package
      run: swift build -v
      
    - name: Run tests
      run: swift test -v
```

### Test package & Gather Code Coverage using codecov.io
Replace the `{YOUR_PACKAGE_NAME}` with the name of your package. For example if the name of the package is `gacalc`, then replace the fragment `{YOUR_PACKAGE_NAME}PackageTests` with `GacalcPackageTests`. 

Note: Even though, the name of the package is all lowercased, the replaced name starts with uppercased first letter!

When this action is executed for a pull request, the codevcov bot will add a comment with a new code coverage statistics:
<img src="https://user-images.githubusercontent.com/6362174/138331737-c70b6561-fcb9-42f0-be03-f33cc7ca6f22.png">

```yaml
name: Test Package

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: macos-11

    steps:
      - name: Get Sources
        uses: actions/checkout@v2

      - name: Build Package
        run: swift build -v

      - name: Run tests
        run: swift test --enable-code-coverage -v
      
      - name: Setup Xcode
        uses: maxim-lobanov/setup-xcode@v1.4.0
        with:
          xcode-version: "13.1"

      - name: Gather code coverage
        run: xcrun llvm-cov export -format="lcov" .build/debug/{YOUR_PACKAGE_NAME}PackageTests.xctest/Contents/MacOS/{YOUR_PACKAGE_NAME}PackageTests -instr-profile .build/debug/codecov/default.profdata > coverage_report.lcov

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v2
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          fail_ci_if_error: true
          files: ./coverage_report.lcov
          verbose: true
```

### Code linting using SwiftLint
Linting using `macOS` as host machine:
```yaml
name: Lint code

on:
  pull_request:
    paths:
      - '.github/workflows/codelint.yml'
      - '.swiftlint.yml'
      - '**/*.swift'

jobs:
  SwiftLint:
    runs-on: macos-11
    steps:
      - uses: actions/checkout@v1
      
      - name: Lint code using SwiftLint
        run: swiftlint lint --reporter github-actions-logging
```

Linting using `ubuntu` as host machine with a [SwiftLint Github Action](https://github.com/marketplace/actions/github-action-for-swiftlint):
```yaml
name: Lint code

on:
  pull_request:
    paths:
      - '.github/workflows/codelint.yml'
      - '.swiftlint.yml'
      - '**/*.swift'

jobs:
  SwiftLint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      
      - name: Lint code using SwiftLint
        uses: norio-nomura/action-swiftlint@3.2.1
```

Both options lint the code, and add warning and errors as comments to the code:
<img src="https://user-images.githubusercontent.com/6362174/138337201-7d3dde21-f888-4135-98e4-c212e2434e05.png">

