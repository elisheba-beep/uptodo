// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_usage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppUsage {

 String get name; String get usage; IconData get icon; Color get color;
/// Create a copy of AppUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppUsageCopyWith<AppUsage> get copyWith => _$AppUsageCopyWithImpl<AppUsage>(this as AppUsage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppUsage&&(identical(other.name, name) || other.name == name)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,name,usage,icon,color);

@override
String toString() {
  return 'AppUsage(name: $name, usage: $usage, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class $AppUsageCopyWith<$Res>  {
  factory $AppUsageCopyWith(AppUsage value, $Res Function(AppUsage) _then) = _$AppUsageCopyWithImpl;
@useResult
$Res call({
 String name, String usage, IconData icon, Color color
});




}
/// @nodoc
class _$AppUsageCopyWithImpl<$Res>
    implements $AppUsageCopyWith<$Res> {
  _$AppUsageCopyWithImpl(this._self, this._then);

  final AppUsage _self;
  final $Res Function(AppUsage) _then;

/// Create a copy of AppUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? usage = null,Object? icon = null,Object? color = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,usage: null == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}

}


/// Adds pattern-matching-related methods to [AppUsage].
extension AppUsagePatterns on AppUsage {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppUsage() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppUsage value)  $default,){
final _that = this;
switch (_that) {
case _AppUsage():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppUsage value)?  $default,){
final _that = this;
switch (_that) {
case _AppUsage() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String usage,  IconData icon,  Color color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppUsage() when $default != null:
return $default(_that.name,_that.usage,_that.icon,_that.color);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String usage,  IconData icon,  Color color)  $default,) {final _that = this;
switch (_that) {
case _AppUsage():
return $default(_that.name,_that.usage,_that.icon,_that.color);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String usage,  IconData icon,  Color color)?  $default,) {final _that = this;
switch (_that) {
case _AppUsage() when $default != null:
return $default(_that.name,_that.usage,_that.icon,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _AppUsage implements AppUsage {
  const _AppUsage(this.name, this.usage, this.icon, this.color);
  

@override final  String name;
@override final  String usage;
@override final  IconData icon;
@override final  Color color;

/// Create a copy of AppUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppUsageCopyWith<_AppUsage> get copyWith => __$AppUsageCopyWithImpl<_AppUsage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppUsage&&(identical(other.name, name) || other.name == name)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,name,usage,icon,color);

@override
String toString() {
  return 'AppUsage(name: $name, usage: $usage, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class _$AppUsageCopyWith<$Res> implements $AppUsageCopyWith<$Res> {
  factory _$AppUsageCopyWith(_AppUsage value, $Res Function(_AppUsage) _then) = __$AppUsageCopyWithImpl;
@override @useResult
$Res call({
 String name, String usage, IconData icon, Color color
});




}
/// @nodoc
class __$AppUsageCopyWithImpl<$Res>
    implements _$AppUsageCopyWith<$Res> {
  __$AppUsageCopyWithImpl(this._self, this._then);

  final _AppUsage _self;
  final $Res Function(_AppUsage) _then;

/// Create a copy of AppUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? usage = null,Object? icon = null,Object? color = null,}) {
  return _then(_AppUsage(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as String,null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as IconData,null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as Color,
  ));
}


}

// dart format on
