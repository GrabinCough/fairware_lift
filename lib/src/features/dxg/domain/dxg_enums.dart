// lib/src/features/dxg/domain/dxg_enums.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

// No longer need freezed_annotation here as the incorrect annotation is removed.

// -----------------------------------------------------------------------------
// --- ENUM DEFINITIONS FOR DXG ------------------------------------------------
// -----------------------------------------------------------------------------
// These enums represent the bounded lists of discriminators that define a
// canonical exercise. Using enums provides type safety and prevents typos.
//
// --- FIX ---
// The `@JsonEnum` annotations have been removed. The default behavior of
// `json_serializable` correctly maps the enum value names (e.g., `push`) to
// the strings in the JSON file.
// -----------------------------------------------------------------------------

/// The fundamental type of movement.
enum MovementPattern {
  push,
  pull,
  squat,
  hinge,
  lunge,
  carry,
  rotate,
  // ignore: constant_identifier_names
  anti_rotate,
  gait,
  isolation,
}

/// The type of equipment used for the exercise.
enum Equipment {
  barbell,
  dumbbell,
  machine,
  cable,
  band,
  bodyweight,
  kettlebell,
  landmine,
  trx,
  plate,
  smith,
  trapbar,
  // This is a special value from the synonyms map.
  // ignore: constant_identifier_names
  farmer_handles,
  // Added from ez_bar in allowed lists, not in main enum list in spec.
  // ignore: constant_identifier_names
  ez_bar,
}

/// The angle or line of pull/press for the movement.
enum Angle {
  // Press & Fly
  flat,
  incline,
  decline,
  overhead,
  // Row & Cable
  // ignore: constant_identifier_names
  low_to_high,
  // ignore: constant_identifier_names
  high_to_low,
  horizontal,
  vertical,
  // ignore: constant_identifier_names
  chest_supported,
  // ignore: constant_identifier_names
  seated_cable,
  // Squat variants
  back,
  front,
  goblet,
  hack,
  zercher,
  // Hinge variants
  conventional,
  sumo,
  romanian,
  // ignore: constant_identifier_names
  stiff_leg,
  // ignore: constant_identifier_names
  rack_pull,
  // Lunge variants
  forward,
  reverse,
  walking,
  // ignore: constant_identifier_names
  split_squat,
  // ignore: constant_identifier_names
  bulgarian_split,
  // Carry variants
  farmer,
  suitcase,
  // ignore: constant_identifier_names
  front_rack,
  // Rotation variants
  // ignore: constant_identifier_names
  anti_rotation,
  rotation,
  chop,
  lift,
  // Calf variants
  standing,
  seated,
  donkey,
  // Curl variants (re-using existing enums)
  // standing, seated,
  // ignore: constant_identifier_names
  incline_bench,

  // --- NEW: Shoulder Raise Variants ---
  lateral,
  // ignore: constant_identifier_names
  front_raise,
  // ignore: constant_identifier_names
  rear_delt_raise,
}

/// Whether the movement is performed with one or two limbs.
enum Unilateral {
  bilateral,
  unilateral,
}

/// The user's body orientation during the exercise.
enum BodyOrientation {
  standing,
  seated,
  supine,
  prone,
  // ignore: constant_identifier_names
  half_kneel,
  // ignore: constant_identifier_names
  tall_kneel,
  // ignore: constant_identifier_names
  side_lying,
  // ignore: constant_identifier_names
  chest_supported,
  // ignore: constant_identifier_names
  back_supported,
  // ignore: constant_identifier_names
  hip_hinge_setup,
  // From pullup family
  hanging,
  // From pulldown family
  kneeling,
}

/// The handle or attachment used, primarily for cables.
enum Attachment {
  none,
  rope,
  // ignore: constant_identifier_names
  straight_bar,
  // ignore: constant_identifier_names
  ez_bar,
  // ignore: constant_identifier_names
  v_bar,
  // ignore: constant_identifier_names
  d_handle,
  // ignore: constant_identifier_names
  lat_bar,
  // ignore: constant_identifier_names
  single_d_handle,
}

/// The user's grip on the equipment.
enum Grip {
  neutral,
  supinated,
  pronated,
  mixed,
  hook,
}