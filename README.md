# LSR Tooling

Generic tooling for JS apps. Included:

- Code auto-formatting

## Usage

1. `npx install-peerdeps --dev --yarn lsr-tooling`
1. Add to your package.json:

   ```json
     "scripts": {
       "format": "prettier --write '*.js' --write '{src,__mocks__}/**/*.js'"
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

## Independent instructions

### Code auto-formatting

1. `yarn add --dev prettier husky pretty-quick`
1. Modify package.json as described in [Usage](#usage)
