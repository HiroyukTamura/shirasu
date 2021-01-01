import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shirasu/model/base_model.dart';
import 'package:shirasu/model/mixins/currency_mixin.dart';
import 'package:shirasu/model/mixins/plan_type.dart';

part 'channel_data.freezed.dart';

part 'channel_data.g.dart';

@freezed
abstract class ChannelData with _$ChannelData {
  const factory ChannelData({
    @required Channel channel,
  }) = _ChannelData;

  factory ChannelData.fromJson(Map<String, dynamic> json) =>
      _$ChannelDataFromJson(json);
}

@freezed
abstract class Channel with _$Channel implements BaseChannel {
  const factory Channel({
    @required String id,
    @required String name,
    dynamic icon,
    String twitterUrl,
    String facebookUrl,
    String textOnPurchaseScreen,
    @required String detail,
    @required
    @Assert('typename == "Channel"')
    @JsonKey(name: '__typename')
        String typename,
    @required SubscriptionPlan subscriptionPlan,
    @required ChannelPrograms programs,
    @required Announcements announcements,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}

@freezed
abstract class Announcements
    with _$Announcements
    implements BaseModelChannelAnnouncementConnection {
  const factory Announcements({
    @required List<AnnouncementsItem> items,
    String nextToken,
    @required
    @JsonKey(name: '__typename')
    @Assert('typename == "ModelChannelAnnouncementConnection"')
        String typename,
  }) = _Announcements;

  factory Announcements.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementsFromJson(json);
}

@freezed
abstract class AnnouncementsItem
    with _$AnnouncementsItem
    implements BaseChannelAnnouncement {
  const factory AnnouncementsItem({
    @required String id,
    @required bool isOpen,
    @required bool isSubscriberOnly,
    @required String title,
    @required String text,
    @required DateTime publishedAt,
    @required DateTime createdAt,
    @required DateTime updatedAt,
    @required
    @JsonKey(name: '__typename')
    @Assert('typename == "ChannelAnnouncement"')
        String typename,
  }) = _AnnouncementsItem;

  factory AnnouncementsItem.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementsItemFromJson(json);
}

@freezed
abstract class ChannelPrograms
    implements _$ChannelPrograms, BaseModelProgramConnection {
  const factory ChannelPrograms({
    @required List<ProgramsItem> items,
    String nextToken,
    @required
    @JsonKey(name: '__typename')
    @Assert('typename == "ModelProgramConnection"')
        String typename,
  }) = _ChannelPrograms;

  const ChannelPrograms._();

  factory ChannelPrograms.fromJson(Map<String, dynamic> json) =>
      _$ChannelProgramsFromJson(json);

  ChannelPrograms append(ChannelPrograms newOne) {
    items.addAll(newOne.items);
    return ChannelPrograms(
      items: items,
      typename: newOne.typename,
      nextToken: newOne.nextToken,
    );
  }
}

@freezed
abstract class ProgramsItem with _$ProgramsItem, ViewerPlanTypeMixin implements BaseProgram {

  const factory ProgramsItem({
    @required String id,
    @required String tenantId,
    @required String channelId,
    @required String title,
    @required DateTime broadcastAt,
    @required int totalPlayTime,
    @visibleForTesting
    String viewerPlanType,
    @required
    @JsonKey(name: '__typename')
    @Assert('typename == "Program"')
        String typename,
  }) = _ProgramsItem;

  factory ProgramsItem.fromJson(Map<String, dynamic> json) =>
      _$ProgramsItemFromJson(json);
}

@freezed
abstract class SubscriptionPlan with CurrencyMixin
    implements _$SubscriptionPlan, BaseSubscriptionPlan {
  const factory SubscriptionPlan({
    @required String id,
    @required int amount,
    @required String currency,
    @required bool isPurchasable,
    @required
    @JsonKey(name: '__typename')
    @Assert('typename == "SubscriptionPlan"')
        String typename,
    PurchasedPlan viewerPurchasedPlan, // null => not purchased
  }) = _SubscriptionPlan;

  const SubscriptionPlan._();

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanFromJson(json);
}

@freezed
abstract class PurchasedPlan with _$PurchasedPlan implements BasePurchasedPlan {
  const factory PurchasedPlan({
    @required bool isActive,
    @required
    @JsonKey(name: '__typename')
    @Assert('typename == "PurchasedPlan"')
        String typename,
  }) = _PurchasedPlan;

  factory PurchasedPlan.fromJson(Map<String, dynamic> json) =>
      _$PurchasedPlanFromJson(json);
}
