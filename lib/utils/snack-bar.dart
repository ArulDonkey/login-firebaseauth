// ignore_for_file: file_names

import 'package:flutter/material.dart';

void openSnackbar(context, snackMessage, color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      action: SnackBarAction(
        label: "Ok",
        textColor: Colors.grey[700],
        onPressed: () {},
      ),
      content: Text(
        snackMessage,
        style: const TextStyle(
          fontSize: 14,
        ),
      ),
    ),
  );
}
