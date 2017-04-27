# heroku-buildpack-google-chrome

This buildpack downloads and installs (headless) Google Chrome from your choice
of release channels.

## Channels

You can choose your release channel by specifying `GOOGLE_CHROME_CHANNEL` as
a config var for your app, in your app.json (for Heroku CI and Review Apps),
or in your pipeline settings (for Heroku CI).

Valid values are `stable`, `beta`, and `unstable`. If unspecified, the `stable`
channel will be used.

## Shims and Command Line Flags

This buildpack installs shims that always add `--headless`, `--disable-gpu`,
and `--no-sandbox` to any `google-chrome` command  as they are required for 
Chrome to run on a Heroku dyno.

You'll have two of these shims on your path: `google-chrome` and
`google-chrome-$GOOGLE_CHROME_CHANNEL`. They both point to the binary of
the selected channel.

## Selenium

If you are using this buildpack with Selenium and webdriver, you'll need to
tell Selenium where to find the chrome binary. Selenium expects the binary to
live at `/usr/bin/google-chrome`, but that's a read-only filesystem on Heroku.
You'll have to tell Selenium and/or chromedriver that Chrome is at
`/app/.apt/usr/bin/google-chrome` instead.

## Early termination

This buildpack will run Chrome with the `--headless` flag, so you may have
issues where Chrome immediately shuts down after your command. You can use
the `--remote-debugging-port` flag to keep Chrome running. For example:

```sh
$ google-chrome --remote-debugging-port=9222
```
