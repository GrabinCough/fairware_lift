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
    // --- NEW ---
    // A list of parameters that can be configured for this warm-up.
    @Default([]) List<WarmupParameter> parameters,
  }) = _WarmupItem;

  factory WarmupItem.fromJson(Map<String, dynamic> json) =>
      _$WarmupItemFromJson(json);
}

/// Represents a configurable parameter for a warm-up item, like "Grip".
@freezed
class WarmupParameter with _$WarmupParameter {
  const factory WarmupParameter({
    required String name,
    required List<String> options,
  }) = _WarmupParameter;

  factory WarmupParameter.fromJson(Map<String, dynamic> json) =>
      _$WarmupParameterFromJson(json);
}