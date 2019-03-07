# gulp-luaminify

Minifies lua content with luamin. [luamin](https://github.com/mathiasbynens/luamin).

## Installation

```bash
npm install gulp-luaminify --save-dev
```

## Usage

```javascript
var luaminify = require('gulp-luaminify');

gulp.task('minify', function () {
    return gulp.src(['path/to/files/*.lua'])
        .pipe(luaminify())
        .pipe(gulp.dest('dist'));
});
```

## LICENSE

(MIT License)