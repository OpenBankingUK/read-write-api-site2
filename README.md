# `read-write-api-site`

Fork of <https://github.com/OpenBankingUK/read-write-api-site2>.

## Live

* <https://banaio-read-write-api-site2.netlify.com/>.
* <https://github.com/banaio/read-write-api-site2>.

## Status

[![Netlify Status](https://api.netlify.com/api/v1/badges/d523b90e-cb71-41eb-984b-ae31ac9353e6/deploy-status)](https://app.netlify.com/sites/banaio-read-write-api-site2/deploys)

## Build

```sh
git clone git@github.com:banaio/read-write-api-site2.git
cd read-write-api-site2
yarn install --frozen-lockfile --non-interactive
yarn docs:dev
yarn docs:build
```

## Development

```sh
git clone git@github.com:banaio/read-write-api-site2.git
cd read-write-api-site2
yarn install --frozen-lockfile --non-interactive
yarn docs:dev
... # Make changes
yarn lint-md
```

## Deploy

### Netlify

The [Netlify](https://www.netlify.com/) is automatically deployed to <https://banaio-read-write-api-site2.netlify.com/> when a commit is pushed to `master`:

> Auto publishing is on. Deploys from master are published automatically.

See <https://app.netlify.com/sites/banaio-read-write-api-site2/deploys> for all the deploys.

### GitHub Pages

The [GitHub Pages](https://pages.github.com/) needs a manual deploy.

Manually deploy to the `gh-pages` branch using the script, then delete the `docs/.vuepress/dist` folder:

```sh
./deploy.sh && rm -fr docs/.vuepress/dist
```

then go to <https://github.com/banaio/read-write-api-site2>.

## IFrame

See [./examples/EXAMPLES.md](./examples/EXAMPLES.md).
