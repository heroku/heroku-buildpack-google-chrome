# heroku-buildpack-google-chrome

This buildpack installs the latest version of Chrome Canary and makes it available under the `google-chrome-unstable` command.

## Notes

Chrome must be started with a few flags to work correctly.

```sh
$ google-chrome-unstable --headess --no-sandbox --disable-gpu
```

When running in headless mode, the browser will exit immediately after loading the page. A work around is to use the `--remote-debugging-port` flag.

```sh
$ google-chrome-unstable --headess --no-sandbox --disable-gpu --remote-debugging-port=9222
```
