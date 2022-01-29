if [ -z "$CI" ]; then
  if which swiftlint >/dev/null; then
    swiftlint autocorrect --config ./.configs/swiftlint.yml
    swiftlint lint --config ./.configs/swiftlint.yml
  else
    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
  fi
fi
