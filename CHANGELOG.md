# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Next]

### Changed

- `PrimaOpentelemetryEx.setup()` will raise an error if `opentelemetry` or `opentelemetry_exporter` applications fail to start for some reason

### Fixed

- Fix OTLP exporter not starting in Distillery/Mix releases, due to `opentelemetry` and `opentelemetry_exporter` not being included in the release

## [1.1.1] - 2022-09-07

### Fixed

- Fix `:opentelemetry is listed both as a regular application and as an included application` error occurring when 
 packaging with Mix Release an application that depends on this library

## [1.1.0] - 2022-08-09

### Added

- Added the ability to disable instrumentation for Ecto and/or Absinthe by setting the `exclude` configuration key:  
  ```elixir
  config :prima_opentelemetry_ex, exclude: [:ecto, :absinthe]
  ```

### Changed

- Logger metadata will be propagated in processes spawned by the `TeleTask` module

## [1.0.1] - 2022-05-27

### Fixed

- Add `Application.ensure_all_started(:opentelemetry)`

## [1.0.0] - 2022-04-14

### Changed

- Bump `opentelemetry_ecto` to `1.0.0` 🎉

## [1.0.0-rc.4] - 2022-03-10

### Added

- Add catalog-info ([#13](https://github.com/primait/prima_opentelemetry_ex/pull/13))

### Changed

- Update dependencies out of RC ([#14](https://github.com/primait/prima_opentelemetry_ex/pull/14))
- Update build script
- Update drone pipeline

## [1.0.0-rc.3] - 2021-11-03

### Added

- Add wrapper for tasks ([#8](https://github.com/primait/prima_opentelemetry_ex/pull/8))
- Add deployment.environment resource tag ([#10](https://github.com/primait/prima_opentelemetry_ex/pull/10))

### Changed

- Bump dependencies

### Removed

- Remove custom resource detector ([#4](https://github.com/primait/prima_opentelemetry_ex/pull/4))

## [1.0.0-rc.2] - 2021-10-20

### Changed

- Bump opentelemetry deps to 1.0.0-rc.3

## [1.0.0-rc.1.1] - 2021-10-18

### Removed

- Remove Github dependencies

## [1.0.0-rc.1] - 2021-10-18

### Added

- Publish on hex.pm

## [0.1.3] - 2021-10-15

### Changed

- Bump teleplug to 1.0.0-rc.5

## [0.1.2] - 2021-10-15

### Changed

- Pin dependencies

## [0.1.1] - 2021-10-07

### Changed

- Bump deps

## [0.1.0] - 2021-10-01

### Added

- Initial release

[Next]: https://github.com/primait/prima_opentelemetry_ex/compare/1.1.1...HEAD
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
