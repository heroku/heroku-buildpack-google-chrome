# heroku-buildpack-google-chrome

This buildpack downloads and installs (headless) Google Chrome from your choice
of release channels.

While headless Chrome is stable, some use cases (like filling in fields via
Selenium) require an X window server to be active. For those cases, please
see the [heroku-xvfb-google-chrome buildpack](https://github.com/heroku/heroku-buildpack-xvfb-chrome)
instead.

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

To use Selenium with this buildpack, you'll also need Chrome's webdriver.
This buildpack does not install chromedriver, but there is a
[chromedriver buildpack](https://github.com/heroku/heroku-buildpack-chromedriver)
also available.

Additionally, chromedriver expects Chrome to be installed at `/usr/bin/google-chrome`,
but that's a read-only filesystem in a Heroku slug. You'll need to tell Selenium/chromedriver
that the chrome binary is at `/app/.apt/usr/bin/google-chrome` instead.

## Early termination

This buildpack will run Chrome with the `--headless` flag, so you may have
issues where Chrome immediately shuts down after your command. You can use
the `--remote-debugging-port` flag to keep Chrome running. For example:

```sh
$ google-chrome --remote-debugging-port=9222
```
