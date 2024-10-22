import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_notifications/notification_controller.dart';
import 'package:local_notifications/screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notification',
        channelDescription: 'Basic Notifications Channel',
      )
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic Group',
      ),
    ],
  );
  bool isAllowerdToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowerdToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  runApp(const MainApp());
}

List<String> options = ['Care', 'More', 'Godzilla', 'Megatron'];

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _input1Controller = TextEditingController();
  final TextEditingController _input2Controller = TextEditingController();

  String _currentOption = options[0];
  String _dropdownValue = options.first;

  void _pushNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 2,
        channelKey: 'basic_channel',
        title: _input1Controller.text,
        body: _input2Controller.text,
        backgroundColor: Colors.purple.shade200,
        color: Colors.purple,
        roundedBigPicture: true,
        bigPicture: 'https://icddecadence.com/img/3rd/band-logo.png',
        largeIcon: 'https://icddecadence.com/img/3rd/band-logo.png',
        notificationLayout: NotificationLayout.BigPicture,
        wakeUpScreen: true,
      ),
    );

    Fluttertoast.showToast(
      msg: 'Enviando Notificação',
      backgroundColor: Colors.blue.shade100,
      textColor: Colors.black,
    );
  }

  @override
  void initState() {
    super.initState();
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _input1Controller.dispose();
    _input2Controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _input1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this input';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _input2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill this input';
                    }
                    return null;
                  },
                ),
                Column(
                  children: List.generate(options.length, (index) {
                    final option = options[index];
                    return ListTile(
                      title: Text(option),
                      leading: Radio(
                        value: option,
                        groupValue: _currentOption,
                        onChanged: (value) {
                          setState(() {
                            _currentOption = value.toString();
                          });
                        },
                      ),
                    );
                  }),
                ),
                DropdownButton(
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: _dropdownValue,
                  onChanged: (value) {
                    setState(() {
                      _dropdownValue = value.toString();
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _pushNotification();
                    }
                  },
                  child: const Text('Enviar Notificação'),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 1,
                channelKey: 'basic_channel',
                title: 'Hello, World!',
                body: 'Local Notifications Working',
              ),
            );
          },
          child: const Icon(Icons.notification_add),
        ),
      ),
      navigatorKey: navigatorKey,
      routes: {
        '/screen': (context) => const Screen(),
      },
    );
  }
}
