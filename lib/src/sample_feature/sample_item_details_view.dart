/**
 * Import the Flutter Material library for building Material Design UI
 */
import 'package:flutter/material.dart';

/**
 * SampleItemDetailsView class that extends StatelessWidget
 */
class SampleItemDetailsView extends StatelessWidget {
  /**
   * Constructor for the SampleItemDetailsView class
   */
  const SampleItemDetailsView({super.key});

  /**
   * Static constant for the route name of this view
   */
  static const routeName = '/sample_item';

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
       * AppBar with a title
       */
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      /**
       * Body of the Scaffold with a centered Text widget
       */
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}