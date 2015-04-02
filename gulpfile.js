var gulp = require('gulp');
var path = require('path');

var home = process.env.HOME;

gulp.task('vimrc', function () {
    return gulp.src('vim/.vimrc')
        .pipe(gulp.dest(home));
});

gulp.task('oh-my-zsh', function () {
    return gulp.src('zsh/custom/**/*')
        .pipe(gulp.dest(path.join(home, '.oh-my-zsh/custom/')));
});

gulp.task('zshrc', function () {
    return gulp.src('zsh/.zshrc')
        .pipe(gulp.dest(home));
});

gulp.task('vim', gulp.parallel('vimrc'));

gulp.task('zsh', gulp.parallel('zshrc', 'oh-my-zsh'));

gulp.task('default', gulp.parallel('vim', 'zsh'));
