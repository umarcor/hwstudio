'use strict';

module.exports = function(grunt) {

  const appFiles = [
    'index.html',
    '*.js',
    '*.css',
    'package.json',
    'fonts/**/*.*',
    'node_modules/**/*.*',
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
    distCommands.push('compress:win' + bits, 'wget:python' + bits, 'exec:nsis' + bits);
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
            'node_modules/**',
            'views/*.html'
          ]
        },
        {
          expand: true,
          cwd: 'app/bower_components/bootstrap/fonts',
          dest: 'dist/tmp/fonts',
          src: '*.*'
        }
      ]
    }
  };

  gruntCfg.toolchain = {
    options: {
      apioMin: '<%=pkg.apio.min%>',
      apioMax: '<%=pkg.apio.max%>',
      buildDir: 'dist/',
      extraPackages: '<%=pkg.apio.extras%>',
      platforms: platforms
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

  gruntCfg.watch = {
    scripts: {
      files: [
        'app/resources/**/*.*',
        'app/js/**/*.*',
        'app/css/**/*.*',
        'app/views/**/*.*'
      ],
      tasks: [
        'wiredep',
        'exec:stopNW',
        'exec:nw'
      ],
      options: {
        atBegin: true,
        interrupt: true
      }
    }
  };

  gruntCfg.wget = {
    python32: {
      options: { overwrite: false },
      src: 'https://www.python.org/ftp/python/3.7.4/python-3.7.4.exe',
      dest: 'cache/python/python-3.7.4.exe'
    },
    python64: {
      options: { overwrite: false },
      src: 'https://www.python.org/ftp/python/3.7.4/python-3.7.4-amd64.exe',
      dest: 'cache/python/python-3.7.4-amd64.exe'
    },
    collection: {
      options: { overwrite: false },
      src: 'https://github.com/FPGAwars/collection-default/archive/v<%=pkg.collection%>.zip',
      dest: 'cache/collection/collection-default-v<%=pkg.collection%>.zip'
    }
  };

  const WIN32 = process.platform === 'win32';

  var pkg = grunt.file.readJSON('app/package.json');

  require('load-grunt-tasks')(grunt, options);

  // Load custom tasks
  grunt.loadTasks('tasks');

  // Project configuration
  grunt.initConfig({
    pkg: pkg,
    appdmg:    gruntCfg.appdmg,    // macOS only
    appimage:  gruntCfg.appimage,  // GNU/Linux only
    compress:  gruntCfg.compress,  // Compress packages usin zip
    copy:      gruntCfg.copy,      // Copy dist files
    nwjs:      gruntCfg.nwjs,      // Execute nw-build packaging
    toolchain: gruntCfg.toolchain, // Create standalone toolchains for each platform
    watch:     gruntCfg.watch,     // Watch files for changes and runs tasks based on the changed files
    wget:      gruntCfg.wget,      // Wget: Python installer and Default collection

    // Automatically inject Bower components into the app
    wiredep: {
      task: {
        directory: 'app/bower_components',
        bowerJson: grunt.file.readJSON('app/bower.json'),
        src: ['index.html']
      }
    },

    // Execute nw application
    exec: {
      nw: 'nw app' + (WIN32 ? '' : ' 2>/dev/null'),
      stopNW: (WIN32 ? 'taskkill /F /IM nw.exe >NUL 2>&1' : 'killall nw 2>/dev/null || killall nwjs 2>/dev/null') + ' || (exit 0)',
      nsis32: 'makensis -DARCH=win32 -DPYTHON="python-3.7.4.exe" -DVERSION=<%=pkg.version%> -V3 scripts/windows_installer.nsi',
      nsis64: 'makensis -DARCH=win64 -DPYTHON="python-3.7.4-amd64.exe" -DVERSION=<%=pkg.version%> -V3 scripts/windows_installer.nsi'
    },

    // Reads HTML for usemin blocks to enable smart builds that automatically
    // concat, minify and revision files. Creates configurations in memory so
    // additional tasks can operate on them
    useminPrepare: {
      html: 'app/index.html',
      options: { dest: 'dist/tmp' }
    },

    // JSON minification plugin without concatination
    'json-minify': {
      json: { files: 'dist/tmp/resources/**/*.json' },
      ice: { files: 'dist/tmp/resources/**/*.ice' }
    },

    // Uglify configuration options:
    uglify: { options: { mangle: false } },

    // Rewrite based on filerev and the useminPrepare configuration
    usemin: { html: ['dist/tmp/index.html'] },

    // Check all js files
    jshint: {
      all: [
        'app/js/**/*.js',
        'tasks/*.js',
        'gruntfile.js'
      ],
      options: { jshintrc: '.jshintrc' }
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

    // Empty folders to start fresh
    clean: {
      tmp: ['.tmp', 'dist/tmp'],
      dist: ['dist'],
      toolchain: [
        'cache/toolchain/default-python-packages',
        'cache/toolchain/default-apio',
        'cache/toolchain/*.zip'
      ],
      collection: ['app/resources/collection']
      // node: ['node_modules'],
      // appnode: ['app/node_modules'],
      // appbower: ['app/bower_components'],
      // cache: ['cache']
    },

    // Generate POT file
    'nggettext_extract': {
      pot: {
        files: {
          'app/resources/locale/template.pot': [
            'app/views/*.html',
            'app/js/**/*.js'
          ]
        }
      },
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
  grunt.registerTask('serve', [
    'nggettext_compile',
    'watch:scripts'
  ]);
  grunt.registerTask('dist', [
    'checksettings',
    'jshint',
    'clean:dist',
    'clean:toolchain',
    'nggettext_compile',
    'useminPrepare',
    'concat',
    'copy:dist',
    'json-minify',
    'uglify',
    'cssmin',
    'usemin',
    'nwjs',
    //'toolchain'
  ]
  .concat(distCommands)
  .concat([
    'clean:tmp'
  ]));
  grunt.registerTask('checksettings', function() {
    if (pkg.apio.external !== '' || pkg.apio.branch !== '') {
      grunt.fail.fatal('Apio settings are in debug mode');
    }
  });
};

// Disable Deprecation Warnings
var os = require('os');
os.tmpDir = os.tmpdir;
