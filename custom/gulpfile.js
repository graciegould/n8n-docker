const gulp = require('gulp');
const swc = require('gulp-swc');
const sourcemaps = require('gulp-sourcemaps');
const del = require('del');
const nodemon = require('nodemon');
const { spawn } = require('child_process');

// Clean dist directory
function clean() {
  return del(['dist/**/*']);
}

// Build TypeScript with SWC
function build() {
  return gulp.src('src/**/*.ts')
    .pipe(sourcemaps.init())
    .pipe(swc()) // Uses .swcrc configuration automatically
    .pipe(sourcemaps.write('.'))
    .pipe(gulp.dest('dist'));
}

// Copy SVG files
function copySvgs() {
  return gulp.src('src/**/*.svg')
    .pipe(gulp.dest('dist'));
}

// Watch for changes and rebuild
function watch() {
  return gulp.watch('src/**/*.ts', build);
}

// Development mode with hot reload
function dev() {
  // Start watching for changes
  const tsWatcher = gulp.watch('src/**/*.ts', build);
  const svgWatcher = gulp.watch('src/**/*.svg', copySvgs);
  
  // Log file changes
  tsWatcher.on('change', function(path) {
    console.log(`🔄 TypeScript file changed: ${path}`);
  });
  
  tsWatcher.on('add', function(path) {
    console.log(`➕ TypeScript file added: ${path}`);
  });
  
  tsWatcher.on('unlink', function(path) {
    console.log(`➖ TypeScript file removed: ${path}`);
    // Remove corresponding file from dist
    const distPath = path.replace('src/', 'dist/').replace('.ts', '.js');
    del([distPath]);
  });
  
  svgWatcher.on('change', function(path) {
    console.log(`🔄 SVG file changed: ${path}`);
  });
  
  svgWatcher.on('add', function(path) {
    console.log(`➕ SVG file added: ${path}`);
  });
  
  svgWatcher.on('unlink', function(path) {
    console.log(`➖ SVG file removed: ${path}`);
    // Remove corresponding file from dist
    const distPath = path.replace('src/', 'dist/');
    del([distPath]);
  });
  
  console.log('🚀 Development mode started. Watching for changes...');
  console.log('📁 Source files: src/**/*.ts, src/**/*.svg');
  console.log('📦 Output directory: dist/');
}

// Build and watch (alias for dev)
const watchTask = gulp.series(clean, build, copySvgs, dev);

// Default task
const defaultTask = gulp.series(clean, build, copySvgs);

// Export tasks
exports.clean = clean;
exports.build = build;
exports.copySvgs = copySvgs;
exports.watch = watch;
exports.dev = gulp.series(clean, build, copySvgs, dev);
exports.default = defaultTask;
