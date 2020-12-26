# LSR Tooling

Generic tooling for JS apps. Included guides:

- Auto-formatting tool (Prettier)
- Linting tool (ESLint)
- Styling library (Material UI)
- Static compilation library (React Static)
- Configs (e.g. git)

## Purpose

Rather than providing a "boilerplate app" to start from, this is instead
formatted as a guide that can be used for new AND existing apps, as well as
tracking changes to help upgrade old apps.

It can be use by anyone, though I customized the style to my personal
preferences.

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

### Optional next steps

#### Style with [Material UI](https://material-ui.com/getting-started/installation/)

1. `yarn add @material-ui/core @material-ui/icons fontsource-roboto`
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

1. `npx react-static create`
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

## Independent dependencies (optional)

If you want to pick and choose your tools instead of getting them all at once:

### Code auto-formatting

1. `yarn add --dev prettier husky pretty-quick`
1. Modify package.json as described in [Usage](#usage)

### Linting

1. Follow the short instructions at
   [eslint-config-cooperka](https://github.com/cooperka/eslint-config-cooperka)
