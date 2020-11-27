# FlutterChatApp

## Description
A Map App made on FLutter along with Firestore/Firebase backend and Google Maps API.
A replica/clone of Uber: able to get directions to locations of users on the app.

## Features 
Detect the current location of the user

Use Geocoding for converting addresses to coordinates and vice versa

Add Markers to the Map View

Draw the route between two places using Polylines and Directions API

Live location is also available or manually specify location. 

## Installation 

Before using it, you will need to make a new project in the Google Cloud Platform, and enable the Google Maps API for that project. Also, don't forget to setup the Billing for that project on GCP, otherwise you will receive the error.

Make sure to read the pubsec yaml file and follow the instructions of the packages listed on pub.dev.

For the Android part, go to android/app/src/main/AndroidManifest.xml file and add your API key there.

For the iOS part, go to ios/Runner/AppDelegate.swift file and add your API key there.
Full configuration (already done in this project)


## Screenshots:

<img src="https://github.com/shehriyarmalik/flutterMaps/blob/main/screenshots/home.PNG" height="400" width="200">
<img src="https://github.com/shehriyarmalik/flutterMaps/blob/master/screenshots/map.png?raw=true" height="400" width="200">
<img src="https://github.com/shehriyarmalik/flutterMaps/blob/master/screenshots/options.png?raw=true" height="400" width="200">
