// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'channel_subscription_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ChannelSubscriptionPlan _$ChannelSubscriptionPlanFromJson(
    Map<String, dynamic> json) {
  return _ChannelSubscriptionPlan.fromJson(json);
}

/// @nodoc
class _$ChannelSubscriptionPlanTearOff {
  const _$ChannelSubscriptionPlanTearOff();

// ignore: unused_element
  _ChannelSubscriptionPlan call({@required ChannelSubscriptionPlan channel}) {
    return _ChannelSubscriptionPlan(
      channel: channel,
    );
  }

// ignore: unused_element
  ChannelSubscriptionPlan fromJson(Map<String, Object> json) {
    return ChannelSubscriptionPlan.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ChannelSubscriptionPlan = _$ChannelSubscriptionPlanTearOff();

/// @nodoc
mixin _$ChannelSubscriptionPlan {
  ChannelSubscriptionPlan get channel;

  Map<String, dynamic> toJson();
  $ChannelSubscriptionPlanCopyWith<ChannelSubscriptionPlan> get copyWith;
}

/// @nodoc
abstract class $ChannelSubscriptionPlanCopyWith<$Res> {
  factory $ChannelSubscriptionPlanCopyWith(ChannelSubscriptionPlan value,
          $Res Function(ChannelSubscriptionPlan) then) =
      _$ChannelSubscriptionPlanCopyWithImpl<$Res>;
  $Res call({ChannelSubscriptionPlan channel});

  $ChannelSubscriptionPlanCopyWith<$Res> get channel;
}

/// @nodoc
class _$ChannelSubscriptionPlanCopyWithImpl<$Res>
    implements $ChannelSubscriptionPlanCopyWith<$Res> {
  _$ChannelSubscriptionPlanCopyWithImpl(this._value, this._then);

  final ChannelSubscriptionPlan _value;
  // ignore: unused_field
  final $Res Function(ChannelSubscriptionPlan) _then;

  @override
  $Res call({
    Object channel = freezed,
  }) {
    return _then(_value.copyWith(
      channel: channel == freezed
          ? _value.channel
          : channel as ChannelSubscriptionPlan,
    ));
  }

  @override
  $ChannelSubscriptionPlanCopyWith<$Res> get channel {
    if (_value.channel == null) {
      return null;
    }
    return $ChannelSubscriptionPlanCopyWith<$Res>(_value.channel, (value) {
      return _then(_value.copyWith(channel: value));
    });
  }
}

/// @nodoc
abstract class _$ChannelSubscriptionPlanCopyWith<$Res>
    implements $ChannelSubscriptionPlanCopyWith<$Res> {
  factory _$ChannelSubscriptionPlanCopyWith(_ChannelSubscriptionPlan value,
          $Res Function(_ChannelSubscriptionPlan) then) =
      __$ChannelSubscriptionPlanCopyWithImpl<$Res>;
  @override
  $Res call({ChannelSubscriptionPlan channel});

  @override
  $ChannelSubscriptionPlanCopyWith<$Res> get channel;
}

/// @nodoc
class __$ChannelSubscriptionPlanCopyWithImpl<$Res>
    extends _$ChannelSubscriptionPlanCopyWithImpl<$Res>
    implements _$ChannelSubscriptionPlanCopyWith<$Res> {
  __$ChannelSubscriptionPlanCopyWithImpl(_ChannelSubscriptionPlan _value,
      $Res Function(_ChannelSubscriptionPlan) _then)
      : super(_value, (v) => _then(v as _ChannelSubscriptionPlan));

  @override
  _ChannelSubscriptionPlan get _value =>
      super._value as _ChannelSubscriptionPlan;

  @override
  $Res call({
    Object channel = freezed,
  }) {
    return _then(_ChannelSubscriptionPlan(
      channel: channel == freezed
          ? _value.channel
          : channel as ChannelSubscriptionPlan,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ChannelSubscriptionPlan implements _ChannelSubscriptionPlan {
  _$_ChannelSubscriptionPlan({@required this.channel})
      : assert(channel != null);

  factory _$_ChannelSubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$_$_ChannelSubscriptionPlanFromJson(json);

  @override
  final ChannelSubscriptionPlan channel;

  @override
  String toString() {
    return 'ChannelSubscriptionPlan(channel: $channel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ChannelSubscriptionPlan &&
            (identical(other.channel, channel) ||
                const DeepCollectionEquality().equals(other.channel, channel)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(channel);

  @override
  _$ChannelSubscriptionPlanCopyWith<_ChannelSubscriptionPlan> get copyWith =>
      __$ChannelSubscriptionPlanCopyWithImpl<_ChannelSubscriptionPlan>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChannelSubscriptionPlanToJson(this);
  }
}

abstract class _ChannelSubscriptionPlan implements ChannelSubscriptionPlan {
  factory _ChannelSubscriptionPlan(
      {@required ChannelSubscriptionPlan channel}) = _$_ChannelSubscriptionPlan;

  factory _ChannelSubscriptionPlan.fromJson(Map<String, dynamic> json) =
      _$_ChannelSubscriptionPlan.fromJson;

  @override
  ChannelSubscriptionPlan get channel;
  @override
  _$ChannelSubscriptionPlanCopyWith<_ChannelSubscriptionPlan> get copyWith;
}

Channel _$ChannelFromJson(Map<String, dynamic> json) {
  return _Channel.fromJson(json);
}

/// @nodoc
class _$ChannelTearOff {
  const _$ChannelTearOff();

// ignore: unused_element
  _Channel call(
      {@required SubscriptionPlan subscriptionPlan,
      @required String typename}) {
    return _Channel(
      subscriptionPlan: subscriptionPlan,
      typename: typename,
    );
  }

// ignore: unused_element
  Channel fromJson(Map<String, Object> json) {
    return Channel.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Channel = _$ChannelTearOff();

/// @nodoc
mixin _$Channel {
  SubscriptionPlan get subscriptionPlan;
  String get typename;

  Map<String, dynamic> toJson();
  $ChannelCopyWith<Channel> get copyWith;
}

/// @nodoc
abstract class $ChannelCopyWith<$Res> {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) then) =
      _$ChannelCopyWithImpl<$Res>;
  $Res call({SubscriptionPlan subscriptionPlan, String typename});

  $SubscriptionPlanCopyWith<$Res> get subscriptionPlan;
}

/// @nodoc
class _$ChannelCopyWithImpl<$Res> implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._value, this._then);

  final Channel _value;
  // ignore: unused_field
  final $Res Function(Channel) _then;

  @override
  $Res call({
    Object subscriptionPlan = freezed,
    Object typename = freezed,
  }) {
    return _then(_value.copyWith(
      subscriptionPlan: subscriptionPlan == freezed
          ? _value.subscriptionPlan
          : subscriptionPlan as SubscriptionPlan,
      typename: typename == freezed ? _value.typename : typename as String,
    ));
  }

  @override
  $SubscriptionPlanCopyWith<$Res> get subscriptionPlan {
    if (_value.subscriptionPlan == null) {
      return null;
    }
    return $SubscriptionPlanCopyWith<$Res>(_value.subscriptionPlan, (value) {
      return _then(_value.copyWith(subscriptionPlan: value));
    });
  }
}

/// @nodoc
abstract class _$ChannelCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$ChannelCopyWith(_Channel value, $Res Function(_Channel) then) =
      __$ChannelCopyWithImpl<$Res>;
  @override
  $Res call({SubscriptionPlan subscriptionPlan, String typename});

  @override
  $SubscriptionPlanCopyWith<$Res> get subscriptionPlan;
}

/// @nodoc
class __$ChannelCopyWithImpl<$Res> extends _$ChannelCopyWithImpl<$Res>
    implements _$ChannelCopyWith<$Res> {
  __$ChannelCopyWithImpl(_Channel _value, $Res Function(_Channel) _then)
      : super(_value, (v) => _then(v as _Channel));

  @override
  _Channel get _value => super._value as _Channel;

  @override
  $Res call({
    Object subscriptionPlan = freezed,
    Object typename = freezed,
  }) {
    return _then(_Channel(
      subscriptionPlan: subscriptionPlan == freezed
          ? _value.subscriptionPlan
          : subscriptionPlan as SubscriptionPlan,
      typename: typename == freezed ? _value.typename : typename as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Channel implements _Channel {
  _$_Channel({@required this.subscriptionPlan, @required this.typename})
      : assert(subscriptionPlan != null),
        assert(typename != null);

  factory _$_Channel.fromJson(Map<String, dynamic> json) =>
      _$_$_ChannelFromJson(json);

  @override
  final SubscriptionPlan subscriptionPlan;
  @override
  final String typename;

  @override
  String toString() {
    return 'Channel(subscriptionPlan: $subscriptionPlan, typename: $typename)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Channel &&
            (identical(other.subscriptionPlan, subscriptionPlan) ||
                const DeepCollectionEquality()
                    .equals(other.subscriptionPlan, subscriptionPlan)) &&
            (identical(other.typename, typename) ||
                const DeepCollectionEquality()
                    .equals(other.typename, typename)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(subscriptionPlan) ^
      const DeepCollectionEquality().hash(typename);

  @override
  _$ChannelCopyWith<_Channel> get copyWith =>
      __$ChannelCopyWithImpl<_Channel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChannelToJson(this);
  }
}

abstract class _Channel implements Channel {
  factory _Channel(
      {@required SubscriptionPlan subscriptionPlan,
      @required String typename}) = _$_Channel;

  factory _Channel.fromJson(Map<String, dynamic> json) = _$_Channel.fromJson;

  @override
  SubscriptionPlan get subscriptionPlan;
  @override
  String get typename;
  @override
  _$ChannelCopyWith<_Channel> get copyWith;
}

SubscriptionPlan _$SubscriptionPlanFromJson(Map<String, dynamic> json) {
  return _SubscriptionPlan.fromJson(json);
}

/// @nodoc
class _$SubscriptionPlanTearOff {
  const _$SubscriptionPlanTearOff();

// ignore: unused_element
  _SubscriptionPlan call(
      {@required String id,
      dynamic parentPlanType,
      dynamic parentPlanId,
      @required String productType,
      @required String productId,
      @required String name,
      @required int amount,
      @required String currency,
      @required String interval,
      @required int intervalCount,
      @required bool isPurchasable,
      @required @JsonKey(name: '__typename') dynamic typename}) {
    return _SubscriptionPlan(
      id: id,
      parentPlanType: parentPlanType,
      parentPlanId: parentPlanId,
      productType: productType,
      productId: productId,
      name: name,
      amount: amount,
      currency: currency,
      interval: interval,
      intervalCount: intervalCount,
      isPurchasable: isPurchasable,
      typename: typename,
    );
  }

// ignore: unused_element
  SubscriptionPlan fromJson(Map<String, Object> json) {
    return SubscriptionPlan.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $SubscriptionPlan = _$SubscriptionPlanTearOff();

/// @nodoc
mixin _$SubscriptionPlan {
  String get id;
  dynamic get parentPlanType;
  dynamic get parentPlanId;
  String get productType;
  String get productId;
  String get name;
  int get amount;
  String get currency;
  String get interval;
  int get intervalCount;
  bool get isPurchasable;
  @JsonKey(name: '__typename')
  dynamic get typename;

  Map<String, dynamic> toJson();
  $SubscriptionPlanCopyWith<SubscriptionPlan> get copyWith;
}

/// @nodoc
abstract class $SubscriptionPlanCopyWith<$Res> {
  factory $SubscriptionPlanCopyWith(
          SubscriptionPlan value, $Res Function(SubscriptionPlan) then) =
      _$SubscriptionPlanCopyWithImpl<$Res>;
  $Res call(
      {String id,
      dynamic parentPlanType,
      dynamic parentPlanId,
      String productType,
      String productId,
      String name,
      int amount,
      String currency,
      String interval,
      int intervalCount,
      bool isPurchasable,
      @JsonKey(name: '__typename') dynamic typename});
}

/// @nodoc
class _$SubscriptionPlanCopyWithImpl<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  _$SubscriptionPlanCopyWithImpl(this._value, this._then);

  final SubscriptionPlan _value;
  // ignore: unused_field
  final $Res Function(SubscriptionPlan) _then;

  @override
  $Res call({
    Object id = freezed,
    Object parentPlanType = freezed,
    Object parentPlanId = freezed,
    Object productType = freezed,
    Object productId = freezed,
    Object name = freezed,
    Object amount = freezed,
    Object currency = freezed,
    Object interval = freezed,
    Object intervalCount = freezed,
    Object isPurchasable = freezed,
    Object typename = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      parentPlanType: parentPlanType == freezed
          ? _value.parentPlanType
          : parentPlanType as dynamic,
      parentPlanId: parentPlanId == freezed
          ? _value.parentPlanId
          : parentPlanId as dynamic,
      productType:
          productType == freezed ? _value.productType : productType as String,
      productId: productId == freezed ? _value.productId : productId as String,
      name: name == freezed ? _value.name : name as String,
      amount: amount == freezed ? _value.amount : amount as int,
      currency: currency == freezed ? _value.currency : currency as String,
      interval: interval == freezed ? _value.interval : interval as String,
      intervalCount: intervalCount == freezed
          ? _value.intervalCount
          : intervalCount as int,
      isPurchasable: isPurchasable == freezed
          ? _value.isPurchasable
          : isPurchasable as bool,
      typename: typename == freezed ? _value.typename : typename as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$SubscriptionPlanCopyWith<$Res>
    implements $SubscriptionPlanCopyWith<$Res> {
  factory _$SubscriptionPlanCopyWith(
          _SubscriptionPlan value, $Res Function(_SubscriptionPlan) then) =
      __$SubscriptionPlanCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      dynamic parentPlanType,
      dynamic parentPlanId,
      String productType,
      String productId,
      String name,
      int amount,
      String currency,
      String interval,
      int intervalCount,
      bool isPurchasable,
      @JsonKey(name: '__typename') dynamic typename});
}

/// @nodoc
class __$SubscriptionPlanCopyWithImpl<$Res>
    extends _$SubscriptionPlanCopyWithImpl<$Res>
    implements _$SubscriptionPlanCopyWith<$Res> {
  __$SubscriptionPlanCopyWithImpl(
      _SubscriptionPlan _value, $Res Function(_SubscriptionPlan) _then)
      : super(_value, (v) => _then(v as _SubscriptionPlan));

  @override
  _SubscriptionPlan get _value => super._value as _SubscriptionPlan;

  @override
  $Res call({
    Object id = freezed,
    Object parentPlanType = freezed,
    Object parentPlanId = freezed,
    Object productType = freezed,
    Object productId = freezed,
    Object name = freezed,
    Object amount = freezed,
    Object currency = freezed,
    Object interval = freezed,
    Object intervalCount = freezed,
    Object isPurchasable = freezed,
    Object typename = freezed,
  }) {
    return _then(_SubscriptionPlan(
      id: id == freezed ? _value.id : id as String,
      parentPlanType: parentPlanType == freezed
          ? _value.parentPlanType
          : parentPlanType as dynamic,
      parentPlanId: parentPlanId == freezed
          ? _value.parentPlanId
          : parentPlanId as dynamic,
      productType:
          productType == freezed ? _value.productType : productType as String,
      productId: productId == freezed ? _value.productId : productId as String,
      name: name == freezed ? _value.name : name as String,
      amount: amount == freezed ? _value.amount : amount as int,
      currency: currency == freezed ? _value.currency : currency as String,
      interval: interval == freezed ? _value.interval : interval as String,
      intervalCount: intervalCount == freezed
          ? _value.intervalCount
          : intervalCount as int,
      isPurchasable: isPurchasable == freezed
          ? _value.isPurchasable
          : isPurchasable as bool,
      typename: typename == freezed ? _value.typename : typename,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_SubscriptionPlan implements _SubscriptionPlan {
  _$_SubscriptionPlan(
      {@required this.id,
      this.parentPlanType,
      this.parentPlanId,
      @required this.productType,
      @required this.productId,
      @required this.name,
      @required this.amount,
      @required this.currency,
      @required this.interval,
      @required this.intervalCount,
      @required this.isPurchasable,
      @required @JsonKey(name: '__typename') this.typename})
      : assert(id != null),
        assert(productType != null),
        assert(productId != null),
        assert(name != null),
        assert(amount != null),
        assert(currency != null),
        assert(interval != null),
        assert(intervalCount != null),
        assert(isPurchasable != null),
        assert(typename != null);

  factory _$_SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$_$_SubscriptionPlanFromJson(json);

  @override
  final String id;
  @override
  final dynamic parentPlanType;
  @override
  final dynamic parentPlanId;
  @override
  final String productType;
  @override
  final String productId;
  @override
  final String name;
  @override
  final int amount;
  @override
  final String currency;
  @override
  final String interval;
  @override
  final int intervalCount;
  @override
  final bool isPurchasable;
  @override
  @JsonKey(name: '__typename')
  final dynamic typename;

  @override
  String toString() {
    return 'SubscriptionPlan(id: $id, parentPlanType: $parentPlanType, parentPlanId: $parentPlanId, productType: $productType, productId: $productId, name: $name, amount: $amount, currency: $currency, interval: $interval, intervalCount: $intervalCount, isPurchasable: $isPurchasable, typename: $typename)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SubscriptionPlan &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.parentPlanType, parentPlanType) ||
                const DeepCollectionEquality()
                    .equals(other.parentPlanType, parentPlanType)) &&
            (identical(other.parentPlanId, parentPlanId) ||
                const DeepCollectionEquality()
                    .equals(other.parentPlanId, parentPlanId)) &&
            (identical(other.productType, productType) ||
                const DeepCollectionEquality()
                    .equals(other.productType, productType)) &&
            (identical(other.productId, productId) ||
                const DeepCollectionEquality()
                    .equals(other.productId, productId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality()
                    .equals(other.currency, currency)) &&
            (identical(other.interval, interval) ||
                const DeepCollectionEquality()
                    .equals(other.interval, interval)) &&
            (identical(other.intervalCount, intervalCount) ||
                const DeepCollectionEquality()
                    .equals(other.intervalCount, intervalCount)) &&
            (identical(other.isPurchasable, isPurchasable) ||
                const DeepCollectionEquality()
                    .equals(other.isPurchasable, isPurchasable)) &&
            (identical(other.typename, typename) ||
                const DeepCollectionEquality()
                    .equals(other.typename, typename)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(parentPlanType) ^
      const DeepCollectionEquality().hash(parentPlanId) ^
      const DeepCollectionEquality().hash(productType) ^
      const DeepCollectionEquality().hash(productId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(interval) ^
      const DeepCollectionEquality().hash(intervalCount) ^
      const DeepCollectionEquality().hash(isPurchasable) ^
      const DeepCollectionEquality().hash(typename);

  @override
  _$SubscriptionPlanCopyWith<_SubscriptionPlan> get copyWith =>
      __$SubscriptionPlanCopyWithImpl<_SubscriptionPlan>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_SubscriptionPlanToJson(this);
  }
}

abstract class _SubscriptionPlan implements SubscriptionPlan {
  factory _SubscriptionPlan(
          {@required String id,
          dynamic parentPlanType,
          dynamic parentPlanId,
          @required String productType,
          @required String productId,
          @required String name,
          @required int amount,
          @required String currency,
          @required String interval,
          @required int intervalCount,
          @required bool isPurchasable,
          @required @JsonKey(name: '__typename') dynamic typename}) =
      _$_SubscriptionPlan;

  factory _SubscriptionPlan.fromJson(Map<String, dynamic> json) =
      _$_SubscriptionPlan.fromJson;

  @override
  String get id;
  @override
  dynamic get parentPlanType;
  @override
  dynamic get parentPlanId;
  @override
  String get productType;
  @override
  String get productId;
  @override
  String get name;
  @override
  int get amount;
  @override
  String get currency;
  @override
  String get interval;
  @override
  int get intervalCount;
  @override
  bool get isPurchasable;
  @override
  @JsonKey(name: '__typename')
  dynamic get typename;
  @override
  _$SubscriptionPlanCopyWith<_SubscriptionPlan> get copyWith;
}