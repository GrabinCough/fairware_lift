 // lib/src/features/prompt_studio/presentation/sheets/data_whisperer_sheet.dart

// -----------------------------------------------------------------------------
// --- IMPORTS -----------------------------------------------------------------
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:fairware_lift/src/core/theme/app_theme.dart';

// -----------------------------------------------------------------------------
// --- DATA WHISPERER SHEET WIDGET ---------------------------------------------
// -----------------------------------------------------------------------------

/// A bottom sheet for the "Data Whisperer" prompt builder.
///
/// This widget will contain the form for generating data analysis prompts.
/// This is the initial scaffold.
class DataWhispererSheet extends StatelessWidget {
  const DataWhispererSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Ask Your Data Anything 📈'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Data Whisperer Form Goes Here',
          style: AppTheme.typography.title,
        ),
      ),
    );
  }
}