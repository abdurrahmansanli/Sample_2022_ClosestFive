# closestfive

## Abstract

Covered basic iOS Development concepts as a reference.

## Content
- Sample Basic iOS Application - No 3rd party libraries
- Fetches 5 closest places from Foursquare API.
- Handles error cases like location data OR location permissions being unavailable.
- Saves received data and feeds user with offline data in case of no connection.
- Lets user pull to refresh to update app data according to new location on the go.

## Implemented Concepts:

### Networking:
- Codable (PlacesResponse)
- GET, POST (ApiClient)
- Http headers (ApiClient)
- Parameters (ApiClient)
- Authorization (ApiClient)

### Structure:
- MVVM (MainPageViewModel)
- Dependency Injection (MainPageViewModel)

### UI:
- UIKit Layouts from code (MainPageViewController)
- Table View (MainPageViewController)
- Custom View Components (ActionPromptView, RefreshControl)

### UX:
- Pull to refresh (MainPageViewController)

### Logic:
- Location Manager (LocationService)
- Closures (MainPageViewModel)
- Error handling (MainPageViewModel, ApiClient, LocationService)
- Higher order functions (MainPageViewModel)
- Encoding / Decoding (PlacesDatabaseManager)

### CoreData:
- Read data (PlacesDatabaseManager)
- Save data (PlacesDatabaseManager)
