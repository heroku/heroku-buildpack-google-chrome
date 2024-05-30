## WARNING: `heroku-buildpack-google-chrome` is deprecated

This buildpack is deprecated and is no longer being maintained. Use (https://github.com/heroku/heroku-buildpack-chrome-for-testing.

# heroku-buildpack-google-chrome

This buildpack downloads and installs (headless) Google Chrome from your choice
of release channels.

> [!IMPORTANT]
> When used with Chromedriver, the Chromedriver version (installed by a different buildpack) falls out of sync with Chrome causing build failures.
> 
> **Instead, please use [Chrome for Testing buildpack](https://github.com/heroku/heroku-buildpack-chrome-for-testing)**, which installs  [matching Chrome + Chromedriver versions](https://googlechromelabs.github.io/chrome-for-testing/).

## Channels

You can choose your release channel by specifying `GOOGLE_CHROME_CHANNEL` as
a config var for your app, in your app.json (for Heroku CI and Review Apps),
or in your pipeline settings (for Heroku CI).

Valid values are `stable`, `beta`, and `unstable`. If unspecified, the `stable`
channel will be used.

## Shims and Command Line Flags

This buildpack installs shims that always add `--headless`, `--disable-gpu`, 
`--no-sandbox`, and `--remote-debugging-port=9222` to any `google-chrome` 
command as you'll have trouble running Chrome on a Heroku dyno otherwise.

You'll have two of these shims on your path: `google-chrome` and
`google-chrome-$GOOGLE_CHROME_CHANNEL`. They both point to the binary of
the selected channel.

## Selenium

> [!CAUTION]
> To use Selenium, do not install this buildpack.
>
> **Instead, please use [Chrome for Testing buildpack](https://github.com/heroku/heroku-buildpack-chrome-for-testing)**, which installs  [matching Chrome + Chromedriver versions](https://googlechromelabs.github.io/chrome-for-testing/).

## Releasing a new version

Make sure you publish this buildpack in the buildpack registry

`heroku buildpacks:publish heroku/google-chrome master`
