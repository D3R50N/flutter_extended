# ChangeLog

## 0.0.6

- Added `FlutterExtended.debugFlag` for global debug tag prefixing.
- Added `ExtNum` shortcuts: `h`, `w`, `allPadding`, `hPadding`, `vPadding`, `formatCompact`, `percentOf`.
- Added `ExtContext` helpers: `primaryColor`, `backgroundColor`, `responsive`, `isMobile`, `isTablet`, `isDesktop`, `isPortrait`, `isLandscape`, `showModalSheet`, `unfocus`.
- Added `ExtDate` extensions: `isPast`, `isFuture`, `isWeekend`, `isWeekday`, `age`, `addDays`, `subDays`, `startOfDay`, `endOfDay`, `isToday`, `isYesterday`, `isTomorrow`.
- Added `ExtString` helpers: `mask`, `toIntOrNull`, `toDoubleOrNull`, `toTitleCase`, `toCamelCase`, `toSnakeCase`, `isEmail`, `isPhone`, `copyToClipboard`, `initials`.
- Added `ExtList` & `ExtItNum` utilities: `chunk`, `separated`, `average`.
- Added `ExtWidget` helpers: `shimmer`, `card`, `unfocusOnTap`, `expandedIf`, `hero`, `tooltip`, `scrollable`.
- Added `ExtColor` helpers: `darken`, `lighten`, `toHex`.
- Added `shrink` utility (`SizedBox.shrink`).
- Added `ShimmerWidget` component.
- Improved `Duration` formatting extensions with `formatDDHHMMSS`, `formatDDHHMM`, `formatSS`, and adaptive `format`.

## 0.0.4

- Updated `translated` extension method in `ext_widget.dart` to accept `x` and `y` parameters directly for better usability.
- Downgrade `intl` package to version `0.19.0` for improved compatibility.

## 0.0.3

- Added more extensions to num, widget, and other classes for enhanced functionality.

## 0.0.2

- Added exports for `page_transition`, `url_launcher`, `timeago`, and `intl` packages for easier access.

## 0.0.1

- Initial release
