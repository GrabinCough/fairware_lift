 // lib/src/features/user_profile/application/user_profile_service.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fairware_lift/src/features/user_profile/domain/user_profile.dart';

// -----------------------------------------------------------------------------
// --- USER PROFILE SERVICE ----------------------------------------------------
// -----------------------------------------------------------------------------

const String _userProfileKey = 'user_profile_data';

/// A service responsible for persisting and retrieving the user's profile
/// data using SharedPreferences.
class UserProfileService {
  final SharedPreferences _prefs;

  UserProfileService(this._prefs);

  /// Loads the user profile from local storage.
  Future<UserProfile?> loadProfile() async {
    final jsonString = _prefs.getString(_userProfileKey);
    if (jsonString != null) {
      return UserProfile.fromJson(json.decode(jsonString));
    }
    return null;
  }

  /// Saves the user profile to local storage.
  Future<void> saveProfile(UserProfile profile) async {
    final jsonString = json.encode(profile.toJson());
    await _prefs.setString(_userProfileKey, jsonString);
  }
}

// -----------------------------------------------------------------------------
// --- PROVIDERS ---------------------------------------------------------------
// -----------------------------------------------------------------------------

/// Provider for the SharedPreferences instance.
final _sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) => SharedPreferences.getInstance());

/// Provider for the UserProfileService.
final userProfileServiceProvider = Provider<UserProfileService>((ref) {
  final prefs = ref.watch(_sharedPreferencesProvider).value;
  if (prefs == null) {
    // This should not happen in a real scenario after the app has loaded.
    throw Exception('SharedPreferences not initialized');
  }
  return UserProfileService(prefs);
});

/// An AsyncNotifier that manages the state of the UserProfile.
class UserProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  Future<UserProfile?> build() async {
    return ref.watch(userProfileServiceProvider).loadProfile();
  }

  /// Saves the profile and updates the state.
  Future<void> save(UserProfile profile) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(userProfileServiceProvider).saveProfile(profile);
      return profile;
    });
  }
}

/// The main provider for accessing the user's profile data from the UI.
final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile?>(
  UserProfileNotifier.new,
);