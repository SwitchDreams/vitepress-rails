# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Vitepress::Rails is a Rails Engine gem that integrates [Vitepress](https://vitepress.vuejs.org/) into Rails applications. The primary use case is private documentation that leverages Rails authentication.

**Key architectural pattern**: The gem uses High Voltage for static page serving. When Vitepress builds, HTML files are copied to `app/views/pages/` and assets to `public/docs/`. The custom `Vitepress::Rails::Finder` strips `.html` extensions from page lookups.

**Important constraint**: The engine only works when mounted at `/docs` path. The Vitepress config must have `base: '/docs/'`.

## Development Commands

```bash
# Install dependencies and run tests
bin/setup
rake spec

# Run linter
rake rubocop

# Run both (default task)
rake

# Install gem locally for testing in a Rails app
bundle exec rake install

# Interactive console
bin/console
```

## Package Manager Detection

The gem automatically detects and uses the available package manager (npm, yarn, pnpm, or bun) via `Vitepress::Rails::Tasks`:

1. Checks for lock files (`bun.lockb`, `yarn.lock`, `pnpm-lock.yaml`, `package-lock.json`)
2. Falls back to detecting available executables (`bun`, `yarn`, `pnpm`, `npm`)

The `rails vitepress:install` command uses the detected package manager for all operations (installing deps, adding scripts, etc.).

## Build Process (`lib/vitepress/tasks/vitepress/build.rake`)

The `vitepress:build` task (automatically enhanced into `assets:precompile`):

1. Runs package manager install + docs:build command in the `docs/` folder
2. Copies generated HTML files from `docs/.vitepress/dist/**/*.html` to `app/views/pages/`
3. Copies assets from `docs/.vitepress/dist/assets` to `public/docs/assets`
4. Copies any `docs/public` files to `public/docs/`

Skip dependency install during build with `SKIP_VITEPRESS_INSTALL=1`.

## Installation Task (`rails vitepress:install`)

The installer (via `lib/vitepress/tasks/vitepress/init/install.rb`):
- Adds gitignore entries for generated files
- Detects package manager and installs vitepress
- Adds `docs:dev` and `docs:build` scripts using the detected package manager
- Creates default `docs/.vitepress/config.js` and `docs/index.md`

## Routing

`config/routes.rb` defines a catch-all route `/*id` pointing to `pages#show`, with `root` pointing to `pages#index`. The root page always renders `docs/index.md`.

## Dependencies

- `high_voltage` ~> 3.1 - static page serving
- `rails` >= 5.0
- `rubocop`, `rspec` (development)
- `switchcop` (development - custom rubocop config)
