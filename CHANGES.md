# Pixar Ruby Extensions Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## \[1.12.0] - 2025-12-01

### Added

- `String#pix_uuid?` Returns true if the string is a UUID in the standard hyphenated format: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'. A different delimiter can be used instead of a hyphen, including nil, empty string, or space, but the positioning of the delimiters is always 8-4-4-4-12.

### Changed

- Use Regexp#match? in String predicates, instead of `=~` and a ternary.

## \[1.11.1] - 2025-09-28

Initial public release.
