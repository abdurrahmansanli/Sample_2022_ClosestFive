# closestfive

## Abstract

Covered basic iOS Development concepts as a reference.

## Content
- Sample Basic iOS Application - No 3rd party libraries
- Fetches 5 closest places from Foursquare API.
- Handles error cases like location data OR location permissions being unavailable.
- Saves received data and feeds user with offline data in case of no connection.
- Lets user pull to refresh to update app data according to new location on the go.

## Usage:
`If you are running through a simulator; make sure to select a simulated location on Xcode.`

## Implemented Concepts:

### Networking:
- Codable (PlacesResponse)
- GET, POST (ApiClient)
- Http headers (ApiClient)
- Parameters (ApiClient)
- Authorization (ApiClient)

### Structure:
- MVVM (VenuesViewModel)
- Dependency Injection (VenuesViewModel)

### UI:
- UIKit Layouts from code (VenuesViewController)
- Table View (VenuesViewController)
- Custom View Components (ActionPromptView, RefreshControl)
- UISegmentedControl (MainPageViewController)
- Adding multiple views from a custom data array (MainPageViewController)

### UX:
- Pull to refresh (VenuesViewController)
- Routing to app settings (VenuesViewController)

### Logic:
- Location Manager (LocationService)
- Closures (VenuesViewModel)
- Error handling (VenuesViewModel, ApiClient, LocationService)
- Higher order functions (VenuesViewModel)
- Encoding / Decoding (PlacesDatabaseManager)

### CoreData:
- Read data (PlacesDatabaseManager)
- Save data (PlacesDatabaseManager)
