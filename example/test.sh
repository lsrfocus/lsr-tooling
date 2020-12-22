#!/usr/bin/env bash
set -euxo pipefail

# Ensure clean before testing.
[ -z "$(git status --porcelain)" ]

# Mess up the formatting.
echo "const foo='bar'" > index.js

# Ensure dirty.
[ -n "$(git status --porcelain)" ]

yarn run format

# Ensure clean again.
[ -z "$(git status --porcelain)" ]

echo "Success!"
