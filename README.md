# Favorites

Application to display GitHub users, with the ability to add to your favorites \
The application works with the weather API.

## Required functionality
On the start page of the app there should be two tabs Home, Favorites Home:
- Map users to LazyVStack list form https://api.github.com/users
- Each user should have a save button in Favorites, all saved in Favorites should be written to the local SQLite database
- If the user is already in Favorites show the remove button from Favorites
- When tap to one user show his repositories from https://api.github.com/users/ {login }/repos
Favorites:
- Display all Favorites of users that are saved in the database

## Stack
- Swift
- SwiftUI
- Combine
- MVVM
- URLSession
- Codable
- SQLite
- Third-party API

## Usage
### Ease to use and intuitive
<img src="https://github.com/DmytroHorodyskyi/WeatherBrick/blob/dev/ScreenGif.gif" width="200" >
