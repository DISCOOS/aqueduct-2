# Changelog
[Fork](https://github.com/DISCOOS/aqueduct-2)
managed by [DISCO Open Source](https://www.discoos.org)

## 1.0.0

- Changed library name to aqueduct_2 (breaking change)
- Upgraded dependencies to latest non-null safe versions
- Changed to forked versions of not maintained or discontinued packages

Prior versions (discontinued)
=============================
Versions of [aqueduct_test](https://pub.dev/packages/aqueduct_test)

## 1.0.1

- Fixes analysis warnings for Dart 2.1.1

## 1.0.0+1

- Bumps some dependency constraints to be more permissive

## 1.0.0

- Initial version from `package:aqueduct`.
- Adds `TestHarness` base class for test harnesses.
- Adds `TestHarnessORMMixin` for testing ORM applications.
- Adds `TestHarnessAuthMixin` for testing OAuth2 applications.
- Renames `TestClient` to `Agent` and adds methods for executing requests without constructing a `TestRequest`.
- Adds default parameters to `Agent` for its requests.