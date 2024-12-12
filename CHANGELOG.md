# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

---

## [2.1.2] - 2024-12-12

- Teleplug can now be ~> 2.0

---

## [2.1.1] - 2024-06-17

### Fixed

- Fix warning on attaching an anonymous function to telemetry [#116](https://github.com/primait/prima_opentelemetry_ex/pull/116) by @hizumisen

---

## [2.1.0] - 2024-05-03

No changes since 2.1.0-pre.0

---

## [2.1.0-pre.0] - 2024-04-25

### Changed

- `service.name` and `country` no longer default to a value

### Added

- Traces now have metadata attached based on the kubernetes environment variables(if present):
  - KUBE_APP_PART_OF
  - KUBE_APP_MANAGED_BY
  - KUBE_APP_VERSION
  - KUBE_APP_INSTANCE

---

## [2.0.6] - 2023-11-27

### Changed

- Fix compile error, thanks to @23Skidoo

---

## [2.0.5] - 2023-09-22

### Changed

- `service.name` now will always be kebab-case

---

## [2.0.4] - 2023-09-01

### Removed

- Removed Telepoison.setup function call, which is deprecated.
- Removed telepoison dependency.

---

## [2.0.3] - 2023-06-29

### Changed

- Fix exclude options not being applied on compile time

---

## [2.0.2] - 2023-06-21

### Added

- Country tag is now added based on the `COUNTRY` env var

---

## [2.0.1] - 2023-04-07

### Fixed

- `:excluded` config is correctly checked at runtime

---

## [2.0.0] - 2023-03-23

### Changed

- Teleplug, telepoison, opentelemetry_absinthe and opentelemetry_ecto are now optional dependencies.
  In order to migrate from the previous version of prima_opentelemetry_ex you will have to add the dependencies explicitly in your mix.exs.
  *Warning*: If you don't add opentelemetry_absinthe or opentelemetry_ecto cause a compile time error.

---

## [1.1.3] - 2022-09-22

### Changed

- Bump min version of the following dependencies to 1.1
  - `:opentelemetry`
  - `:opentelemetry_api`
  - `:opentelemetry_exporter`
  - `:opentelemetry_absinthe`
  - `:teleplug`

---

## [1.1.2] - 2022-09-09

### Changed

- `PrimaOpentelemetryEx.setup()` will raise an error if `opentelemetry` or `opentelemetry_exporter` applications fail to start for some reason

### Fixed

- Fix OTLP exporter not starting in Distillery/Mix releases, due to `opentelemetry` and `opentelemetry_exporter` not being included in the release

---

## [1.1.1] - 2022-09-07

### Fixed

- Fix `:opentelemetry is listed both as a regular application and as an included application` error occurring when
 packaging with Mix Release an application that depends on this library

---

## [1.1.0] - 2022-08-09

### Added

- Added the ability to disable instrumentation for Ecto and/or Absinthe by setting the `exclude` configuration key:  

  ```elixir
  config :prima_opentelemetry_ex, exclude: [:ecto, :absinthe]
  ```

### Changed

- Logger metadata will be propagated in processes spawned by the `TeleTask` module

---

## [1.0.1] - 2022-05-27

### Fixed

- Add `Application.ensure_all_started(:opentelemetry)`

---

## [1.0.0] - 2022-04-14

### Changed

- Bump `opentelemetry_ecto` to `1.0.0` 🎉

---

## [1.0.0-rc.4] - 2022-03-10

### Added

- Add catalog-info ([#13](https://github.com/primait/prima_opentelemetry_ex/pull/13))

### Changed

- Update dependencies out of RC ([#14](https://github.com/primait/prima_opentelemetry_ex/pull/14))
- Update build script
- Update drone pipeline

---

## [1.0.0-rc.3] - 2021-11-03

### Added

- Add wrapper for tasks ([#8](https://github.com/primait/prima_opentelemetry_ex/pull/8))
- Add deployment.environment resource tag ([#10](https://github.com/primait/prima_opentelemetry_ex/pull/10))

### Changed

- Bump dependencies

### Removed

- Remove custom resource detector ([#4](https://github.com/primait/prima_opentelemetry_ex/pull/4))

---

## [1.0.0-rc.2] - 2021-10-20

### Changed

- Bump opentelemetry deps to 1.0.0-rc.3

---

## [1.0.0-rc.1.1] - 2021-10-18

### Removed

- Remove Github dependencies

---

## [1.0.0-rc.1] - 2021-10-18

### Added

- Publish on hex.pm

---

## [0.1.3] - 2021-10-15

### Changed

- Bump teleplug to 1.0.0-rc.5

---

## [0.1.2] - 2021-10-15

### Changed

- Pin dependencies

---

## [0.1.1] - 2021-10-07

### Changed

- Bump deps

---

## [0.1.0] - 2021-10-01

### Added

- Initial release





[Unreleased]: https://github.com/primait/prima_opentelemetry_ex/compare/2.1.1...HEAD
[2.1.1]: https://github.com/primait/prima_opentelemetry_ex/compare/2.1.0...2.1.1
[2.1.0]: https://github.com/primait/prima_opentelemetry_ex/compare/2.1.0-pre.0...2.1.0
[2.1.0-pre.0]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.6...2.1.0-pre.0
[2.0.6]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.5...2.0.6
[2.0.5]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.4...2.0.5
[2.0.4]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.3...2.0.4
[2.0.3]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.2...2.0.3
[2.0.2]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.1...2.0.2
[2.0.1]: https://github.com/primait/prima_opentelemetry_ex/compare/2.0.0...2.0.1
[2.0.0]: https://github.com/primait/prima_opentelemetry_ex/compare/1.1.3...2.0.0
[1.1.3]: https://github.com/primait/prima_opentelemetry_ex/compare/1.1.2...1.1.3
[1.1.2]: https://github.com/primait/prima_opentelemetry_ex/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/primait/prima_opentelemetry_ex/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.1...1.1.0
[1.0.1]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.0-rc.4...1.0.0
[1.0.0-rc.4]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.0-rc.3...1.0.0-rc.4
[1.0.0-rc.3]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.0-rc.2...1.0.0-rc.3
[1.0.0-rc.2]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.0-rc.1.1...1.0.0-rc.2
[1.0.0-rc.1.1]: https://github.com/primait/prima_opentelemetry_ex/compare/1.0.0-rc.1...1.0.0-rc.1.1
[1.0.0-rc.1]: https://github.com/primait/prima_opentelemetry_ex/compare/0.1.3...1.0.0-rc.1
[0.1.3]: https://github.com/primait/prima_opentelemetry_ex/compare/0.1.2...0.1.3
[0.1.2]: https://github.com/primait/prima_opentelemetry_ex/compare/0.1.1...0.1.2
[0.1.1]: https://github.com/primait/prima_opentelemetry_ex/compare/0.1.0...0.1.1
[0.1.0]: https://github.com/primait/prima_opentelemetry_ex/releases/tag/0.1.0
