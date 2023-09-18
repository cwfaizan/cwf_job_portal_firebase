import 'package:flutter/material.dart';

AppBar customAppBar(final String title, {List<Widget>? actions}) => AppBar(
      title: Text(title),
      actions: actions,
    );
