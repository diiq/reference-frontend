'use strict';

import gulp     from 'gulp';
import webpack  from 'webpack';
import path     from 'path';
import sync     from 'run-sequence';
import rename   from 'gulp-rename';
import template from 'gulp-template';
import fs       from 'fs';
import yargs    from 'yargs';
import lodash   from 'lodash';
import gutil    from 'gulp-util';
import serve    from 'browser-sync';
import del      from 'del';
import webpackDevMiddleware from 'webpack-dev-middleware';
import webpackHotMiddleware from 'webpack-hot-middleware';
import colorsSupported      from 'supports-color';
import historyApiFallback   from 'connect-history-api-fallback';

let root = 'client';

// helper method for resolving paths
let resolveToApp = (glob = '') => {
  return path.join(root, 'app', glob); // app/{glob}
};

let resolveToComponents = (glob = '') => {
  return path.join(root, 'app/', glob); // app/components/{glob}
};

// map of all paths
let entries = (config) => {
  return [
    path.join(__dirname, root, 'app/app.coffee'),
    path.join(__dirname, root, 'app/config/' + config + '.coffee'),
  ];
}

let paths = {
  js: resolveToComponents('**/*!(.spec.js).js'), // exclude spec files
  styl: resolveToApp('**/*.scss'), // stylesheets
  html: [
    resolveToApp('**/*.html'),
    path.join(root, 'index.html')
  ],
  output: root,
  blankTemplates: path.join(__dirname, 'generator', 'component/**/*.**'),
  dest: path.join(__dirname, 'dist')
};

// use webpack.config.js to build modules
gulp.task('webpack', ['clean'], (cb) => {
  const config = require('./webpack.dist.config');
  config.entry.app = entries('dist');

  webpack(config, (err, stats) => {
    if(err)  {
      throw new gutil.PluginError("webpack", err);
    }

    gutil.log("[webpack]", stats.toString({
      colors: colorsSupported,
      chunks: false,
      errorDetails: true
    }));

    cb();
  });

  gulp.src(path.join(__dirname, root, 'app/common/favicon.png'))
    .pipe(gulp.dest('dist'));
});

gulp.task('deploy', ['webpack'], () => {
  const awspublish = require('gulp-awspublish');
  const awspublishRouter = require('gulp-awspublish-router');
  var publisher = awspublish.create({ params: {
    Bucket: 'www.reference-board.com'
  }});

  var headers = {
    'Cache-Control': 'max-age=300'
    // ...
  };

  gulp.src('./dist/*')
    .pipe(awspublishRouter({
      routes: {
        cache: {
            // cache for 10 minutes by default
          cacheTime: 6000
        },

        "index.html": {
          cacheTime: 300
        },

        "^.+$": "$&"
      }
    }))
    .pipe(publisher.publish())
    .pipe(publisher.sync())
    .pipe(awspublish.reporter());
});

gulp.task('serve', () => {
  const config = require('./webpack.dev.config');
  config.entry.app = [
    // this modules required to make HRM working
    // it responsible for all this webpack magic
    'webpack-hot-middleware/client?reload=true',
    // application entry point
  ].concat(entries('dev'));

  var compiler = webpack(config);

  serve({
    port: process.env.PORT || 3000,
    open: false,
    server: {baseDir: root},
    middleware: [
      historyApiFallback(),
      webpackDevMiddleware(compiler, {
        stats: {
          colors: colorsSupported,
          chunks: false,
          modules: false
        },
        publicPath: config.output.publicPath
      }),
      webpackHotMiddleware(compiler)
    ]
  });
});

gulp.task('component', () => {
  const cap = (val) => {
    return val.charAt(0).toUpperCase() + val.slice(1);
  };
  const name = yargs.argv.name;
  const parentPath = yargs.argv.parent || '';
  const destPath = path.join(resolveToComponents(), parentPath, name);

  return gulp.src(paths.blankTemplates)
    .pipe(template({
      name: name,
      upCaseName: cap(name)
    }))
    .pipe(rename((path) => {
      path.basename = path.basename.replace('temp', name);
    }))
    .pipe(gulp.dest(destPath));
});

gulp.task('clean', (cb) => {
  del([paths.dest]).then(function (paths) {
    gutil.log("[clean]", paths);
    cb();
  });
});

gulp.task('default', ['serve']);
