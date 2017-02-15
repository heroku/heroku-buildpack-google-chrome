# heroku-buildpack-google-chrome

This buildpack installs the latest version of Chrome Canary and makes the
headless version available under the `google-chrome-unstable` command.

## Notes

To run Chrome on a Heroku dyno, it needs to be started in headless mode with
a few features disabled. This buildpack creates a shim that will add the
required command line arguments (`--headless`, `--no-sandbox`, and
`--disable-gpu`) by default.

When running in headless mode, the browser will exit immediately after loading
the page. You may work around this by using the `--remote-debugging-port` flag.
For example:

```sh
$ google-chrome-unstable --remote-debugging-port=9222
```
