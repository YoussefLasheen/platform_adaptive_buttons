A flutter utility that allows you to easily adapt your material buttons to the iOS style.


## Getting started

Just create your button as you would normally do, and then append .adaptive() to it and thats it.

```dart
ElevatedButton(
    onPressed: () {},
    child: const Text('Tap me!'),
).adaptive(context);
```

it works with the following buttons:  
`ElevatedButton`, `TextButton`, `OutlinedButton`, and `FilledButton`.

