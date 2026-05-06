class Env {
  static const supabaseUrl =
      String.fromEnvironment('SUPABASE_URL', defaultValue: 'http://localhost:54321');
  static const supabaseAnonKey =
      String.fromEnvironment('SUPABASE_ANON_KEY', defaultValue: 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH');
}