import 'package:flutter/material.dart';

class UserPicker extends StatefulWidget {
  const UserPicker({Key? key}) : super(key: key);

  @override
  State<UserPicker> createState() => _UserPickerState();
}

class _UserPickerState extends State<UserPicker> {
  //todo set form SP
  String currentUser = 'testUser 1';

  //todo fetch users from sharedPreferences/fqlite database
  final List<String> usersInCache = ['testUser 1', 'testUser 2', 'testUser 3'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: currentUser,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: Theme.of(context).textTheme.bodyMedium,
          underline: Container(
            height: 2,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onChanged: (data) {
            setState(() {
              if (data != null) {
                currentUser = data;
              }
            });
          },
          items: usersInCache.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        Text("Selected item = $currentUser"),
      ],
    );
  }
}