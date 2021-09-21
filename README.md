# heroku-buildpack-ffmpeg-latest

Fork of https://github.com/jonathanong/heroku-buildpack-ffmpeg-latest all credit goes to the original maintainer, but since the code is published under a MIT License, we decided to fork it to prevent any supply channel security issues and due to the download of a static ffmpeg from johnvansickle.com failing randomly.

A Heroku buildpack for ffmpeg that always downloads the latest [static build](http://johnvansickle.com/ffmpeg/).
Unlike other build packs, I never compile anything.

## Usage

Run the following from the heroku command line:

```
heroku buildpacks:add --index 1 https://github.com/vaha-technology/heroku-buildpack-ffmpeg-latest.git
```

You can set a custom download URL by setting the variable `FFMPEG_DOWNLOAD_URL`.

Note: This buildpack should be added before the main language buildpack (by using `--index 1`),
since the application process types are calculated from the last buildpack in the list if no
`Procfile` is specified.
