# Flutter
-keep class io.flutter.** { *; }

# Keep Kotlin metadata
-keep class kotlin.Metadata { *; }

# Keep your app classes
-keep class dev.pages.workout_analyzer.** { *; }

# Flutter Play Store Split / Deferred Components
# These classes are referenced by the Flutter engine but may not be present
# if the app doesn't use deferred components.
-dontwarn com.google.android.play.core.**
