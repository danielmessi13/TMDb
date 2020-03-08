# TMDb app

- If you have an Android and want to test without having to download Flutter, the apk was placed in the project folder

## Getting Started

This project is a Flutter application, to build it you need [install flutter](https://flutter.dev/docs/get-started/install).

- Don't forget to put the flutter in the environment variables


## How to debug

Connect a cell phone to your computer or start an emulator and enter the command line below.

```
flutter run
```

If you want to generate the apk yourself, use:
```
flutter build apk
```
## Screenshots

![Screenshots]([https://github.com/danielmessi13/TMDb/blob/development/screenshots/Prints.jpg)

## Third-party libraries used

- **flutter_bloc:** It was used to organize / optimize the work with the states of the application, acting as an intermediary between the data source and my screens.

- **dio:** With it I can set my base options, adding my base url and my API key that will be used for every request in my application, making any API call easier.

-**cached_network_image:** Used to load movie images, in addition to not having to make a request every time you load the movie. It gives you an option to define a component while the image loads and if the image fails to load
