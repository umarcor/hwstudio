'use strict';

module.exports = function(grunt) {

  const appFiles = [
    'index.html',
    'package.json',
    'fonts/**/*.*',
    'node_modules/**/*.*',
    'js/**/*.*',
    'css/**/*.*',
    'resources/**/*.*',
    'views/**/*.*'
  ];

  var platforms = [];
  var distCommands = [];
  var options = { scope: ['devDependencies'] };

  function targetLin(bits) {
    platforms.push('linux' + bits);
    distCommands.push('compress:linux' + bits, 'appimage:linux' + bits);
  }
  function targetWin(bits) {
    platforms.push('win' + bits);
    distCommands.push('compress:win' + bits);
  }
  function targetOSX() {
    platforms.push('osx64');
    options.scope.push('darwinDependencies');
    distCommands.push('compress:osx64', 'appdmg');
  }
  var targets = process.env.DIST_TARGET;
  if (targets === undefined) {
    targets = (process.platform === 'darwin') ? 'osx' : 'lin,win';
  }
  targets.split(',').forEach(function (item) {
    switch (item) {
      case 'lin64':
        targetLin('64');
        break;
      case 'lin32':
        targetLin('32');
        break;
      case 'lin':
        targetLin('64');
        targetLin('32');
        break;
      case 'win64':
        targetWin('64');
        break;
      case 'win32':
        targetWin('32');
        break;
      case 'win':
        targetWin('64');
        targetWin('32');
        break;
      case 'osx':
        targetOSX();
        break;
      default:
        grunt.log.errorlns('Unknown target <' + item + '>');
    }
  });

  var gruntCfg = {};

  gruntCfg.copy = {
    dist: {
      files: [
        {
          expand: true,
          cwd: 'app',
          dest: 'dist/tmp',
          src: [
            'index.html',
            'package.json',
            'resources/**',
            'views/*.html',
            'node_modules/**', // FIXME|TODO: SHOULD BE BUNDLED
            //> !!! TEMPORAL
            'js/**',
            'css/**'
            //<
          ]
        },
        {
          expand: true,
          cwd: 'app/node_modules/bootstrap/fonts',
          dest: 'dist/tmp/fonts',
          src: '*.*'
        }
      ]
    }
  };

  gruntCfg.nwjs = {
    options: {
      version: '0.35.5',
      flavor: 'normal',
      zip: false,
      buildDir: 'dist/',
      winIco: 'docs/resources/images/logo/icestudio-logo.ico',
      macIcns: 'docs/resources/images/logo/nw.icns',
      macPlist: { 'CFBundleIconFile': 'app' },
      platforms: platforms
    },
    src: ['dist/tmp/**']
  };

  function appimage(bits) {
    return {
      options: {
        name: 'Icestudio',
        exec: 'icestudio',
        arch: bits + 'bit',
        icons: 'docs/resources/icons',
        comment: 'Visual editor for open FPGA boards',
        archive: 'dist/<%=pkg.name%>-<%=pkg.version%>-linux' + bits + '.AppImage'
      },
      files: [{
        expand: true,
        cwd: 'dist/icestudio/linux' + bits + '/',
        src: ['**'].concat(appFiles)
      }]
    };
  }

  gruntCfg.appimage = {
    linux32: appimage('32'),
    linux64: appimage('64'),
  };

  gruntCfg.appdmg = {
    options: {
      basepath: '.',
      title: 'Icestudio Installer',
      icon: 'docs/resources/images/logo/icestudio-logo.icns',
      background: 'docs/resources/images/installation/installer-background.png',
      window: { size: { width: 512, height: 385 } },
      contents: [
        { x: 345, y: 250, type: 'link', path: '/Applications' },
        { x: 170, y: 250, type: 'file', path: 'dist/icestudio/osx64/icestudio.app' }
      ]
    },
    target: { dest: 'dist/<%=pkg.name%>-<%=pkg.version%>-osx64.dmg' }
  };

  function compressLin(tgt) {
    return {
      options: {
        archive: 'dist/<%=pkg.name%>-<%=pkg.version%>-linux' + tgt + '.zip'
      },
      files: [{
        expand: true,
        cwd: 'dist/icestudio/linux' + tgt + '/',
        src: ['**'].concat(appFiles),
        dest: '<%=pkg.name%>-<%=pkg.version%>-linux' + tgt
      }]
    };
  }

  function compressWin(tgt) {
    return {
      options: {
        archive: 'dist/<%=pkg.name%>-<%=pkg.version%>-win' + tgt + '.zip'
      },
      files: [{
        expand: true,
        cwd: 'dist/icestudio/win' + tgt + '/',
        src: ['**'].concat(appFiles),
        dest: '<%=pkg.name%>-<%=pkg.version%>-win' + tgt
      }]
    };
  }

  function compressOSX(tgt) {
    return {
      options: {
        archive: 'dist/<%=pkg.name%>-<%=pkg.version%>-osx' + tgt + '.zip'
      },
      files: [{
        expand: true,
        cwd: 'dist/icestudio/osx' + tgt + '/',
        src: ['icestudio.app/**'],
        dest: '<%=pkg.name%>-<%=pkg.version%>-osx' + tgt
      }]
    };
  }

  gruntCfg.compress = {
    linux32: compressLin('32'),
    linux64: compressLin('64'),
    win32:   compressWin('32'),
    win64:   compressWin('64'),
    osx32:   compressOSX('32'),
    osx64:   compressOSX('64'),
  };

  const WIN32 = process.platform === 'win32';

  var pkg = grunt.file.readJSON('app/package.json');

  require('load-grunt-tasks')(grunt, options);

  // Project configuration
  grunt.initConfig({
    pkg: pkg,
    appdmg:    gruntCfg.appdmg,    // macOS only
    appimage:  gruntCfg.appimage,  // GNU/Linux only
    compress:  gruntCfg.compress,  // Compress packages usin zip
    copy:      gruntCfg.copy,      // Copy dist files
    nwjs:      gruntCfg.nwjs,      // Execute nw-build packaging

    // Get default collection
    wget: {
      collection: {
        options: { overwrite: false },
        src: 'https://github.com/FPGAwars/collection-default/archive/v<%=pkg.collection%>.zip',
        dest: 'cache/collection/collection-default-v<%=pkg.collection%>.zip'
      }
    },

    // Unzip Default collection
    unzip: {
      'using-router': {
        router: function (filepath) {
          return filepath.replace(/^collection-default-.*?\//g, 'collection/');
        },
        src: 'cache/collection/collection-default-v<%=pkg.collection%>.zip',
        dest: 'app/resources/'
      }
    },

    // Execute nw application
    exec: {
      nw: 'nw app' + (WIN32 ? '' : ' 2>/dev/null'),
      stopNW: (WIN32 ? 'taskkill /F /IM nw.exe >NUL 2>&1' : 'killall nw 2>/dev/null || killall nwjs 2>/dev/null') + ' || (exit 0)'
    },

    // Check all js files
    jshint: {
      all: ['gruntfile.js', 'app/js/**/*.js'],
      options: { jshintrc: '.jshintrc' }
    },

    // Empty folders to start fresh
    clean: {
      tmp: ['.tmp', 'dist/tmp'],
      dist: ['dist'],
      collection: ['app/resources/collection']
      // node: ['node_modules'],
      // appnode: ['app/node_modules'],
      // cache: ['cache']
    },

    // Generate POT file
    'nggettext_extract': {
      pot: { files: { 'app/resources/locale/template.pot': ['app/js/**/*.js', 'app/views/*.html'] } },
    },

    // Compile PO files into JSON
    'nggettext_compile': {
      all: {
        options: { format: 'json' },
        files: [
          { expand: true, cwd: 'app/resources/locale',            dest: 'app/resources/locale',            src: ['**/*.po'], ext: '.json' },
          { expand: true, cwd: 'app/resources/collection/locale', dest: 'app/resources/collection/locale', src: ['**/*.po'], ext: '.json' }
        ]
      }
    }

  });

  grunt.registerTask('getcollection', [
    'clean:collection',
    'wget:collection',
    'unzip'
  ]);
  grunt.registerTask('dist', [
    'jshint',
    'clean:dist',
    'nggettext_compile',
    'copy:dist',
    'nwjs',
  ]
  .concat(distCommands)
  .concat([
    'clean:tmp'
  ]));
};

// Disable Deprecation Warnings
var os = require('os');
os.tmpDir = os.tmpdir;
