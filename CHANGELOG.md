# ChangeLog

## 0.0.6

- Updated intl to 0.20.2

- Improved `Duration` formatting extensions with `formatDDHHMMSS`, `formatDDHHMM`, `formatSS`, and adaptive `format`.
- Added iterable utilities: `find` (renamed from `where1`), `toUnique`, and numeric helpers `sum`, `max`, `min`.
- Extended list-to-layout helpers with `spacing` support for `row`, `column`, and `rowSeparated` layout options.
- Simplified `ExtString` by moving widget-building helpers to `ExtAll<T>` and adding `lower`, `upper`, and `random`.
- Improved widget extensions with `clipBehavior` support in `decorated`, positional optional radius in `clipped`, and nullable callbacks in `onTap` / `onLongPress`.
- Added new widgets: `DottedBorder` and `$` (`SizedBox.shrink`) utility.

## 0.0.4

- Updated `translated` extension method in `ext_widget.dart` to accept `x` and `y` parameters directly for better usability.
- Downgrade `intl` package to version `0.19.0` for improved compatibility.

## 0.0.3

- Added more extensions to num, widget, and other classes for enhanced functionality.

## 0.0.2

- Added exports for `page_transition`, `url_launcher`, `timeago`, and `intl` packages for easier access.

## 0.0.1

- Initial release
