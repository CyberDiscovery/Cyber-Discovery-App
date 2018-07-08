# Cyber Discovery App

Source code for the cyber discovry app.  You should be able to build it from source on either platform however we have a prebuilt [apk or ipa](https://github.com/CyberDiscovery/Cyber-Discovery-App/releases/tag/0.3) for android and iOS respectively.

## Features

* The app has countdowns to all forthcoming events in the cyber discovery calender.
* The app has a schedule for certain activities duraning a events showing when they start, finish and how much of the activity that has happened. 
* The app has a soundboard with some of our favorite clips from vc and agent j.
* The app has the latest articles from the [Cyber Discovery Medium](https://medium.com/cyber-discovery) embeded for easy access.

## Compilation Instructions

### Android
* Make sure you have flutter installed and if you run `flutter doctor` you have no issues.
* Download the source from the releases page. 
* Navigate to the root of the flutter project
* Run `flutter build apk`
* If you navigate to the build directory then app then apk then release you should find your apk file if everything went to plan. 
### IOS
* Make sure you have flutter and xcode installed. Running the `flutter doctor` command will highlight any problems. 
* In `lib/main.dart`, and ensure that you have changed the values such as API keys, app IDs, and Sender IDs to the correct values
* Again, in `lib/main.dart`, change the `name` value to `Cyber_Discovery`.
* Now, in the root of the project, run `flutter build ios`
* After the build is finished, open the `Runner.xcworkspake` file in `ios/Runner.xcworkspace`
* Build an IPA or any other type of build as you would normally

## Screen Shots

![screenshot of countdown](https://cdn.discordapp.com/attachments/409860647170342919/457574918700400661/device-2018-06-16-165902.png)
![screenshot of soundboard](https://cdn.discordapp.com/attachments/409860647170342919/457575256534548481/device-2018-06-16-170038.png)
![screenshot of blog](https://cdn.discordapp.com/attachments/411573884597436416/458663730075664424/device-2018-06-19-170456.png)
![screenshot of nav bar](https://cdn.discordapp.com/attachments/411573884597436416/458663746483519493/device-2018-06-19-170531.png)
