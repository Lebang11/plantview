/**
 * Import the Flutter Material library for building Material Design UI
 */
import 'package:flutter/material.dart';

/**
 * Import the SettingsService class for storing and retrieving user settings
 */
import 'settings_service.dart';

/**
 * A class that many Widgets can interact with to read user settings, update
 * user settings, or listen to user settings changes.
 * 
 * Controllers glue Data Services to Flutter Widgets. The SettingsController
 * uses the SettingsService to store and retrieve user settings.
 */
class SettingsController with ChangeNotifier {
  /**
   * Constructor for the SettingsController class
   * 
   * @param _settingsService The SettingsService instance to use for storing and retrieving user settings
   */
  SettingsController(this._settingsService);

  /**
   * The SettingsService instance to use for storing and retrieving user settings
   */
  final SettingsService _settingsService;

  /**
   * The user's preferred ThemeMode, initialized lazily
   */
  late ThemeMode _themeMode;

  /**
   * Allow Widgets to read the user's preferred ThemeMode
   */
  ThemeMode get themeMode => _themeMode;

  /**
   * Load the user's settings from the SettingsService. It may load from a
   * local database or the internet. The controller only knows it can load the
   * settings from the service.
   * 
   * @return A Future that completes when the settings have been loaded
   */
  Future<void> loadSettings() async {
    /**
     * Load the user's preferred ThemeMode from the SettingsService
     */
    _themeMode = await _settingsService.themeMode();

    /**
     * Important! Inform listeners a change has occurred.
     */
    notifyListeners();
  }

  /**
   * Update and persist the ThemeMode based on the user's selection.
   * 
   * @param newThemeMode The new ThemeMode selected by the user
   * @return A Future that completes when the ThemeMode has been updated and persisted
   */
  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    /**
     * Do not perform any work if new and old ThemeMode are identical
     */
    if (newThemeMode == _themeMode) return;

    /**
     * Otherwise, store the new ThemeMode in memory
     */
    _themeMode = newThemeMode;

    /**
     * Important! Inform listeners a change has occurred.
     */
    notifyListeners();

    /**
     * Persist the changes to a local database or the internet using the
     * SettingService.
     */
    await _settingsService.updateThemeMode(newThemeMode);
  }
}