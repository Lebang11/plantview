/**
 * Import the Flutter Material library for building Material Design UI
 */
import 'package:flutter/material.dart';

/**
 * Import the SettingsView class for navigating to the settings page
 */
import '../settings/settings_view.dart';

/**
 * Import the SampleItem class for representing a sample item
 */
import 'sample_item.dart';

/**
 * Import the SampleItemDetailsView class for navigating to the item details page
 */
import 'sample_item_details_view.dart';

/**
 * SampleItemListView class that extends StatelessWidget
 */
class SampleItemListView extends StatelessWidget {
  /**
   * Constructor for the SampleItemListView class
   */
  const SampleItemListView({
    super.key,
    /**
     * Optional list of SampleItems, defaulting to a list of 3 items
     */
    this.items = const [SampleItem(1), SampleItem(2), SampleItem(3)],
  });

  /**
   * Static constant for the route name of this view
   */
  static const routeName = '/';

  /**
   * List of SampleItems to display
   */
  final List<SampleItem> items;

  /**
   * Override the build method to build the UI for this view
   */
  @override
  Widget build(BuildContext context) {
    /**
     * Return a Scaffold widget with an AppBar and a body
     */
    return Scaffold(
      /**
       * AppBar with a title and an actions list
       */
      appBar: AppBar(
        title: const Text('Sample Items'),
        actions: [
          /**
           * IconButton to navigate to the settings page
           */
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              /**
               * Navigate to the settings page using restorable push named
               */
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      /**
       * Body of the Scaffold with a ListView.builder
       */
      body: ListView.builder(
        /**
         * Providing a restorationId allows the ListView to restore the scroll position
         * when a user leaves and returns to the app after it has been killed while
         * running in the background
         */
        restorationId: 'sampleItemListView',
        /**
         * Number of items in the list
         */
        itemCount: items.length,
        /**
         * Item builder function to create a ListTile for each item
         */
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
            title: Text('SampleItem ${item.id}'),
            leading: const CircleAvatar(
              /**
               * Display the Flutter Logo image asset
               */
              foregroundImage: AssetImage('assets/images/flutter_logo.png'),
            ),
            onTap: () {
              /**
               * Navigate to the item details page using restorable push named
               */
              Navigator.restorablePushNamed(
                context,
                SampleItemDetailsView.routeName,
              );
            },
          );
        },
      ),
    );
  }
}