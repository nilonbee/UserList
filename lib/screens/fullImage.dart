import 'package:flutter/material.dart';

import '../models/Users.dart';

class FullImage extends StatelessWidget {
  final User user;
  FullImage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Image.network(user.avatar),
    );
  }
}