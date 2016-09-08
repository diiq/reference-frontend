### Developing

* `npm install -g gulp karma karma-cli webpack` install global cli dependencies
* `npm install`
* `cd client; bower install`

### Deploying

You'll need to set up credentials in your ~/.aws/credentials file.

* `gulp deploy`

Or run `gulp webpack` to build a deploy locally, in the dist directory.

### Based on

Based on https://github.com/AngularClass/NG6-starter

### Generating Components

To generate a component, run `gulp component --name componentName`.
