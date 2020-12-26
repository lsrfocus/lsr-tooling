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
   import { compose } from 'ramda';
   import {
     createMuiTheme,
     withStyles,
     Reboot,
     MuiThemeProvider,
   } from 'material-ui';
   import 'fontsource-roboto';

   const muiTheme = createMuiTheme({
     // https://material-ui-next.com/customization/themes/#typography
     typography: {
       // Account for base font-size of 62.5%.
       htmlFontSize: 10,
     },
   });

   export default compose(withStyles(styles))(() => (
     <MuiThemeProvider theme={muiTheme}>
       <Reboot />
     </MuiThemeProvider>
   ));
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
1. Integrate with MUI:

   ```js
   // static.config.js

   /**
    * Render and capture the MUI CSS.
    * https://material-ui.com/guides/server-rendering
    */
   renderToHtml: (render, Component, renderMeta) => {
     const sheetsRegistry = new SheetsRegistry();
     const generateClassName = createGenerateClassName();
     const muiTheme = createMuiTheme(theme);

     const html = render(
       <JssProvider registry={sheetsRegistry} generateClassName={generateClassName}>
         <MuiThemeProvider theme={muiTheme} sheetsManager={new Map()}>
           <Component />
         </MuiThemeProvider>
       </JssProvider>,
     );

     // eslint-disable-next-line no-param-reassign
     renderMeta.jssStyles = sheetsRegistry.toString();

     return html;
   },

   /* eslint-disable react/prop-types */
   Document: ({ Html, Head, Body, children, siteData, renderMeta }) => (
     <Html lang="en">
       <Head>
         <meta charSet="utf-8" />
         <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1" />

         <title>Foo</title>

         {/* Favicon: https://realfavicongenerator.net/ */}
         {/* Open Graph markup: https://developers.facebook.com/tools/debug/og/object/ */}
         {/* Analytics: https://matomo.org/ */}
       </Head>

       <Body>
         <noscript>
           You need to enable JavaScript to run this app.
         </noscript>

         {children}

         <style id={string.JSS_SERVER_SIDE_ID}>{renderMeta.jssStyles}</style>
       </Body>
     </Html>
   ),
   /* eslint-enable */
   ```

   ```js
   class App {
     /**
      * Remove the statically injected CSS.
      * https://material-ui.com/guides/server-rendering
      */
     componentDidMount() {
       const jssStyles = document.getElementById(string.JSS_SERVER_SIDE_ID);
       if (jssStyles && jssStyles.parentNode) {
         jssStyles.parentNode.removeChild(jssStyles);
       }
     }
   }
   ```

## Independent instructions (optional)

If you want to pick and choose your tools instead of getting them all at once:

### Code auto-formatting

1. `yarn add --dev prettier husky pretty-quick`
1. Modify package.json as described in [Usage](#usage)

### Linting

1. Follow the short instructions at
   [eslint-config-cooperka](https://github.com/cooperka/eslint-config-cooperka)
