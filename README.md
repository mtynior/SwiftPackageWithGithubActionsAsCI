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
  build:
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
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: macos-11

    steps:
    - uses: actions/checkout@v2
    - uses: maxim-lobanov/setup-xcode@v1.4.0
      with:
        xcode-version: '13.1'
        
    - name: Build Package
      run: swift build -v
      
    - name: Run tests
      run: swift test --enable-code-coverage -v
      
    - name: Gather code coverage
      run: xcrun llvm-cov export -format="lcov" .build/debug/{YOUR_PACKAGE_NAME}PackageTests.xctest/Contents/MacOS/{YOUR_PACKAGE_NAME}PackageTests -instr-profile .build/debug/codecov/default.profdata > coverage_report.lcov
```
