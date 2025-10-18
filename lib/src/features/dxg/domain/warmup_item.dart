// lib/src/features/dxg/domain/warmup_item.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:freezed_annotation/freezed_annotation.dart';

part 'warmup_item.freezed.dart';
part 'warmup_item.g.dart';

// -----------------------------------------------------------------------------
// --- WARMUP ITEM DATA MODEL --------------------------------------------------
// -----------------------------------------------------------------------------
// This model represents a single item from the warm-up/prep catalog, as
// defined in the DXG specification. It has a simpler structure than a full
// strength exercise.
// -----------------------------------------------------------------------------

@freezed
class WarmupItem with _$WarmupItem {
  const factory WarmupItem({
    required String id,
    required String type,
    required String region,
    required String pattern,
    required String modality,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'display_name') required String displayName,
  }) = _WarmupItem;

  factory WarmupItem.fromJson(Map<String, dynamic> json) =>
      _$WarmupItemFromJson(json);
}