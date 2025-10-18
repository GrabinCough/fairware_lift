// lib/src/features/dxg/application/warmup_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fairware_lift/src/features/dxg/domain/warmup_item.dart';

// -----------------------------------------------------------------------------
// --- WARMUP SERVICE ----------------------------------------------------------
// -----------------------------------------------------------------------------
// This service is responsible for loading the catalog of warm-up items from
// the seed JSON file.
// -----------------------------------------------------------------------------

class WarmupService {
  /// Loads and parses the `warmup_items.seed.json` file from assets.
  Future<List<WarmupItem>> loadWarmupItems() async {
    final jsonString =
        await rootBundle.loadString('assets/dxg/warmup_items.seed.json');
    final jsonResponse = json.decode(jsonString) as Map<String, dynamic>;
    final itemsList = jsonResponse['warmup_items'] as List;
    return itemsList
        .map((itemJson) =>
            WarmupItem.fromJson(itemJson as Map<String, dynamic>))
        .toList();
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDER ----------------------------------------------------------------
// -----------------------------------------------------------------------------

/// A provider for the WarmupService itself.
final warmupServiceProvider = Provider<WarmupService>((ref) {
  return WarmupService();
});

/// A FutureProvider that loads the list of warm-up items and makes it available
/// to the UI. The list is loaded once and then cached.
final warmupItemsProvider = FutureProvider<List<WarmupItem>>((ref) {
  return ref.watch(warmupServiceProvider).loadWarmupItems();
});