<!--
                  
This source file is part of the SpeziLocation open source project

SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)

SPDX-License-Identifier: MIT
             
-->

# Spezi Location

## Overview

The Spezi Location Module allows you to access location data from within your [Stanford Spezi](https://github.com/StanfordSpezi) application via Apple's [CoreLocation](https://developer.apple.com/documentation/corelocation) framework.

## Setup

### 1. Add Spezi Location as a Dependency

You need to add the SpeziLocation Swift package to
[your app in Xcode](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app#) or
[Swift package](https://developer.apple.com/documentation/xcode/creating-a-standalone-swift-package-with-xcode#Add-a-dependency-on-another-Swift-package).

> [!IMPORTANT]  
> If your application is not yet configured to use Spezi, follow the [Spezi setup article](https://swiftpackageindex.com/stanfordspezi/spezi/documentation/spezi/initial-setup) to set up the core Spezi infrastructure.

### 2. Configure the SpeziLocation module in the [`SpeziAppDelegate`](https://swiftpackageindex.com/stanfordspezi/spezi/documentation/spezi/speziappdelegate).

```swift
import Spezi
import SpeziLocation

class ExampleDelegate: SpeziAppDelegate {
    override var configuration: Configuration {
        Configuration {
            SpeziLocation()
        }
    }
}
```

### 3. Configure your Xcode project for Location Access

Before requesting permissions for location access from your user, you will need to provide descriptions of how your app uses location services in your `Info.plist` file:

- Open your project settings in Xcode by selecting *PROJECT_NAME > TARGET_NAME > Info* tab.
- Under `Custom iOS Target Properties` (the `Info.plist` file), add one or more of the following keys depending on the level of location access you are requesting and add a description for your usage in the `Value` column which will be shown to the user when you request access:

| Property | Description |
|----------|-------------|
| `Privacy - Location When In Use Usage Description` | Access to location while the app is in use (in the foreground). |
| `Privacy - Location Always and When In Use Usage Description` | Access to location both when the app is in use and in the background. |


## Usage

### Request Permission to Access the User's Location When the App is in Use

Before you can access the user's location, you will need to request location access from the user. Please review the [Configuring your app for location services](https://developer.apple.com/documentation/corelocation/configuring-your-app-to-use-location-services) to understand how location access is handled on iOS.

The following example demonstrates how you can create a SwiftUI view with a button that requests permission to access the user's location when the app is in use via SpeziLocation's `requestWhenInUseAuthorization()` method asynchronously.

A [`CLAuthorizationStatus`](https://developer.apple.com/documentation/corelocation/clauthorizationstatus) level is returned which can be used to determine if the user has provided the requested permission.

```swift
import CoreLocation
import SpeziLocation
import SwiftUI


struct LocationPermissionsView: View {
    @Environment(SpeziLocation.self) private var speziLocation
    
    var body: some View {
        Button("Request Location Access") {
            Task {
                do {
                    let result = await speziLocation.requestWhenInUseAuthorization()
                    
                    if (result == .authorizedWhenInUse) {
                        print("App is authorized to access location when in use.")
                    }
                } catch {
                    print("An error occurred.")
                }
            }
        }
    }
}
```

### Request the User's Current Location

Once you have obtained the required access as shown above, you can request the user's current location asynchronously. In this example, we request the user's location and print it out.

```swift
do {
    let locations = try await speziLocation.getLatestLocations()
    let latestLocation = locations.last
    print("Latitude: \(latestLocation.coordinate.latitude, Longitude: \(latestLocation.coordinate.longitude)")
} catch {
    print("Location could not be determined.")
}
```

## License
This project is licensed under the MIT License. See [Licenses](https://github.com/vishnuravi/SpeziLocation/tree/main/LICENSES) for more information.


## Contributors
This project is developed as part of the Stanford Byers Center for Biodesign at Stanford University.
See [CONTRIBUTORS.md](https://github.com/vishnuravi/SpeziLocation/tree/main/CONTRIBUTORS.md) for a full list of all SpeziLocation contributors.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
