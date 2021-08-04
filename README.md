
# PingViewWidget
PingViewWidget is a simple and customizable animated connecting button widget [PingViewWidget](https://github.com/Sorbh/PingViewWidget)

The source code is **100% Dart**.

[![pub package](https://img.shields.io/pub/v/kdgaugeview.svg?style=flat-square)](https://pub.dartlang.org/packages/PingViewWidget)  ![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg?style=flat-square)


# Motivation

I need some clean animated 3D view to show ping in my Flutter application.

# Getting started

## Installing
Add this to your package's pubspec.yaml file:

This library is posted in pub.dev

#### pubspec.yaml
```dart
dependencies:  
	ping_view_widget: ^1.0.0
```

# Usage

After Importing this library, you can directly use this view in your Widget tree

```dart
import 'package:ping_view_widget/ping_view_widget.dart';
```


```dart
PingViewWidget(
  ispInformationText: TextSpan(
    style: TextStyle(
      color: Colors.black,
      fontSize: 12,
    ),
    children: <TextSpan>[
      TextSpan(
        text: "LOREM SERVER\n",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextSpan(
          text: "São Paulo, Brasil",
          style: TextStyle(color: Colors.grey[600])),
    ],
  ),
  locationInformatinText: TextSpan(
    style: TextStyle(
        color: Colors.grey[600],
        fontSize: 10,
        fontWeight: FontWeight.w500),
    children: <TextSpan>[
      TextSpan(text: "IP Interno: 198.162.1.8\n"),
      TextSpan(text: "IP Externo: 198.162.1.7\n"),
      TextSpan(
        text: "Operadora: Jio",
      ),
    ],
  ),
  techInformationText: TextSpan(
    text: "LTE",
    style: TextStyle(color: Color(0xFF3ebdb8), fontSize: 11),
  ),
)
  ```

# Customization
  Depending on your view you may want to tweak the UI. For now you can these custom attributes

  | Property | Type | Description |
  |----------|------|-------------|
  | 'ispInformationText' | TextSpan | TextSpan Widget to add custom text on ISP server information |
  | 'children' | List | List of widget to show server name and address ping starts from |
  | 'locationInformatinText' | TextSpan | TextSpan Widget to add custom text on ping end location information |
  | 'techInformationText' | TextSpan | TextSpan Widget to add custom text on technology used for internet |




# Screenshots
![Simulator Screen Shot - iPhone 11 Pro - 2021-08-04 at 07 50 09](https://user-images.githubusercontent.com/14270768/128113120-913ab141-c216-4f46-b0b9-9eaa216107cd.png)  
![pingViewWidgetDemo](https://user-images.githubusercontent.com/14270768/128113123-22bdc507-a60a-4333-87fa-76057fb04eeb.gif)









# Author
  * **Saurabh K Sharma - [GIT](https://github.com/Sorbh)**
  
      I am very new to open source community. All suggestion and improvement are most welcomed. 
      

# Contributors
 @all-contributors bot!
 
 
## Contributing

1. Fork it (<https://github.com/sorbh/animated_round_button_flutter/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

