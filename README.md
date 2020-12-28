# LSR Tooling

Generic tooling for JS apps. Included guides:

- Auto-formatting tool (Prettier)
- Linting tool (ESLint)
- Testing library (Jest)
- Styling library (Material UI)
- Static compilation library (React Static)
- Static hosting (Netlify)
- Configs (e.g. git)

## Purpose

Rather than providing a "boilerplate app" to start from, this is instead
formatted as a guide that can be used for new AND existing apps, as well as
tracking changes to help upgrade old apps.

It can be use by anyone, though I customized the style to my personal
preferences.

## Usage

### Install basic tools

1. `npx install-peerdeps --dev --yarn lsr-tooling`
1. Add to your package.json:

   ```json
     "scripts": {
       "format": "prettier --write '*.{js,md}' --write '{src}/**/*.{js,md}'",
       "lint": "eslint --ext .js .",
       "clean": "rm -rf build dist artifacts tmp"
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
     "browserslist": [
       "defaults",
       "not IE 11",
       "maintained node versions"
     ]
   ```

1. Copy in [.eslintrc](example/.eslintrc)
1. Copy in [.gitignore](.gitignore)

### Optional next steps

#### Test with [Jest](https://jestjs.io/docs/en/getting-started)

1. `yarn add --dev --exact jest jest-watch-typeahead react-test-renderer`
   (automatically includes babel-jest)
1. Add to your package.json:

   ```json
     "scripts": {
       "test": "jest",
     },
     "jest": {
       "roots": [
         "<rootDir>/src"
       ],
       "testMatch": [
         "<rootDir>/src/**/*.test.js"
       ],
       "transform": {
         "\\.js$": "babel-jest",
         "\\.css$": "<rootDir>/config/jest/cssTransform.js",
         "^(?!.*\\.(js|css|json)$)": "<rootDir>/config/jest/fileTransform.js"
       },
       "watchPlugins": [
         "jest-watch-typeahead/filename",
         "jest-watch-typeahead/testname"
       ],
       "resetMocks": true
     },
   ```

1. Copy in [config/jest](example/config) transformers

#### Style with [Material UI](https://material-ui.com/getting-started/installation/)

1. `yarn add --exact @material-ui/core @material-ui/icons fontsource-roboto`
1. Use it:

   ```js
   import {
     createMuiTheme,
     ThemeProvider,
     CssBaseline,
     makeStyles,
   } from '@material-ui/core';
   import 'fontsource-roboto';

   const theme = createMuiTheme({
     // https://material-ui-next.com/customization/themes/#typography
     typography: {
       // Account for base font-size of 62.5%.
       htmlFontSize: 10,
     },
   });

   const useStyles = makeStyles({
     /* ... */
   });

   const App = () => {
     const classes = useStyles();

     return (
       <ThemeProvider theme={theme}>
         <CssBaseline />
         {/* ... */}
       </ThemeProvider>
     );
   };

   export default App;
   ```

   ```css
   html {
     height: 100%;

     /* 1 em = 10 px by default. */
     font-size: 62.5%;
   }

   body {
     position: relative;

     min-height: 100%;
     margin: 0;
     padding: 0;

     /* Re-enlarge fonts as fallback in case MUI doesn't load properly. */
     font-size: 1.4rem;
     font-family: Roboto, sans-serif;

     /* Always show vertical scrollbar to prevent jumpy navigation. */
     overflow-y: scroll;
   }
   ```

#### Render with [React Static](https://github.com/react-static/react-static)

1. Create a template app: `npx react-static create`
1. Either use their template directly or copy in core files; add to your
   package.json:

```json
     "scripts": {
       "start": "react-static start",
       "build": "react-static build",
       "stage": "yarn run build --staging && serve dist -p 3000",
       "analyze": "yarn run build --analyze"
     },
```

1. Integrate with MUI
   ([docs](https://github.com/react-static/react-static/blob/master/docs/guides/material-ui.md)):

   ```js
   // plugins/jss-provider/node.api.js
   import { ServerStyleSheets } from '@material-ui/core';

   export default () => ({
     beforeRenderToHtml: (App, { meta }) => {
       // eslint-disable-next-line no-param-reassign
       meta.muiSheets = new ServerStyleSheets();
       return meta.muiSheets.collect(App);
     },

     headElements: (elements, { meta }) => [
       ...elements,
       meta.muiSheets.getStyleElement(),
     ],
   });
   ```

   ```js
   // static.config.js
   // Docs: https://github.com/react-static/react-static/blob/master/docs/config.md
   export default {
     plugins: ['jss-provider'],

     /* eslint-disable react/prop-types */
     Document: ({ Html, Head, Body, children }) => (
       <Html lang="en">
         <Head>
           <meta charSet="utf-8" />
           <meta
             name="viewport"
             content="width=device-width, initial-scale=1, minimum-scale=1, shrink-to-fit=no"
           />

           <title>Foo</title>

           {/* Favicon: https://realfavicongenerator.net/ */}
           {/* Open Graph markup: https://developers.facebook.com/tools/debug/og/object/ */}
           {/* Analytics: https://matomo.org/ */}
         </Head>

         <Body>
           <noscript>You need to enable JavaScript to run this app.</noscript>
           {children}
         </Body>
       </Html>
     ),
     /* eslint-enable */
   };
   ```

#### Deploy with [Netlify](https://www.netlify.com/pricing/)

1. `yarn add --dev --exact netlify-cli`
1. Add to your package.json:

```json
     "scripts": {
       "deploy": "yarn run build && netlify deploy"
     },
```

## Independent dependencies (optional)

If you want to pick and choose your tools instead of getting them all at once:

### Code auto-formatting

1. `yarn add --dev --exact prettier husky pretty-quick`
1. Modify package.json as described in [Usage](#usage)

### Linting

1. Follow the short instructions at
   [eslint-config-cooperka](https://github.com/cooperka/eslint-config-cooperka)
