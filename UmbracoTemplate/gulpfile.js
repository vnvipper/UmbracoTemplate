var gulp = require('gulp');
var browserSync = require('browser-sync').create();
var cache = require('gulp-cache');
var concat = require('gulp-concat');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var uglify = require('gulp-uglify');
var uglifycss = require('gulp-uglifycss');
var gutil = require('gulp-util');

// Task clear cache
gulp.task('clearCache', function() {
    cache.clearAll();
});

// Task browser sync 
gulp.task('browserSync', function() {
    browserSync.init({
        proxy: 'https://localhost:44394/',
        //host: 'localhost',
        //open: 'external'
    });
});

gulp.task('bs-reload', function () {
    browserSync.reload();
});

// Task compile javascript library files
gulp.task('lib-js', function() {
    return gulp.src(['./assets/libs/jquery-3.2.1.min.js',
                        './assets/libs/jquery-validation/dist/jquery.validate.min.js',
                        './assets/libs/jquery-validation-unobtrusive/jquery.validate.unobtrusive.min.js',
                        './assets/libs/jquery-ajax-unobtrusive/jquery.unobtrusive-ajax.min.js',
                        './assets/libs/bootstrap/dist/js/bootstrap.min.js',
                        './assets/libs/toastr/toastr.min.js',
                        './assets/libs/isotope.pkgd.min.js',
                        './assets/libs/modernizr.min.js'])
    .pipe(concat('plugin-dist.js'))
    .pipe(uglify())
    .on('error', function (err) { gutil.log(gutil.colors.red('[Error]'), err.toString()); })
    .pipe(gulp.dest('./assets/scripts/'))
    .pipe(browserSync.reload({
        stream: true
    }));
});

// Task compile css library files
gulp.task('lib-css', function() {
    return gulp.src(['./assets/libs/bootstrap/dist/css/bootstrap.min.css',
                        './assets/libs/toastr/toastr.min.css'])
    .pipe(concat('lib.css'))
    .pipe(uglifycss())
    .on('error', function (err) { gutil.log(gutil.colors.red('[Error]'), err.toString()); })
    .pipe(gulp.dest('./assets/css/'))
    .pipe(browserSync.reload({
        stream: true
    }));
});

// Task compile javascript files
gulp.task('js', function() {
    return gulp.src('./assets/scripts/script.js')
    .pipe(sourcemaps.init())
    .pipe(concat('script-dist.js'))
    .pipe(uglify())
    .on('error', function (err) { gutil.log(gutil.colors.red('[Error]'), err.toString()); })
    .pipe(sourcemaps.write())
    .pipe(gulp.dest('./assets/scripts/'))
    .pipe(browserSync.reload({
        stream: true
    }));
});

// Task compile scss files
gulp.task('sass', function() {
    gulp.src('./assets/css/style.scss')
        .pipe(sourcemaps.init())
        .pipe(sass({outputStyle: 'compressed'}).on('error', sass.logError))
        .pipe(sourcemaps.write())
        .pipe(gulp.dest('./assets/css/'))
        .pipe(browserSync.reload({
            stream: true
        }));
});

//Watch task
gulp.task('watch', ['browserSync', 'js','sass'], function () {
    gulp.watch('./assets/scripts/script.js', ['js']);
    gulp.watch('./assets/css/**/*.scss', ['sass']);
    gulp.watch('./Views/**/*.cshtml', ['bs-reload']);
});

gulp.task('default', ['watch']);