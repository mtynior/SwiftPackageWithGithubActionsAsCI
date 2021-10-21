# GACalc
A simple package to show how to setup and use GitHub Actions as a CI for Swift Packages

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
        run: xcrun llvm-cov export -format="lcov" .build/debug/GACalcPackageTests.xctest/Contents/MacOS/GACalcPackageTests -instr-profile .build/debug/codecov/default.profdata > coverage_report.lcov

      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v2
        with:
          token: ${{ secrets.CODECOV_TOKEN }}
          fail_ci_if_error: true
          files: ./coverage_report.lcov
          verbose: true
```
