# LSR Tooling

Generic tooling for JS apps. Included:

- Code auto-formatting (Prettier)
- Code linting (ESLint)
- Configs (e.g. git)

## Usage

1. `npx install-peerdeps --dev --yarn lsr-tooling`
1. Add to your package.json:

   ```json
     "scripts": {
       "format": "prettier --write '*.js' --write '{src,__mocks__}/**/*.js'",
       "lint": "eslint --ext .js ."
     },
     "prettier": {
       "singleQuote": true,
       "trailingComma": "all",
       "proseWrap": "always"
     },
     "husky": {
       "hooks": {
         "pre-commit": "pretty-quick --staged"
       }
     },
   ```

1. Copy in [.eslintrc](example/.eslintrc)
1. Copy in [.gitignore](.gitignore)

## Independent instructions (optional)

If you want to pick and choose your tools instead of getting them all at once:

### Code auto-formatting

1. `yarn add --dev prettier husky pretty-quick`
1. Modify package.json as described in [Usage](#usage)

### Linting

1. Follow the short instructions at
   [eslint-config-cooperka](https://github.com/cooperka/eslint-config-cooperka)
