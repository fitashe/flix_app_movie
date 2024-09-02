
# FlixApp
FlixApp is a movie application built with Flutter that provides users with information about movies, including discover movies, top-rated movies, and now-playing movies. The app also features detailed pages, synopses, and a search function. It uses the TMDB (The Movie Database) API for fetching movie data and employs the Provider package for state management.

## Features
- Discover Movies: Browse a list of popular movies.
- Top-Rated Movies: View the highest-rated movies according to TMDB.
- Now Playing: See which movies are currently playing in theaters.
- Movie Details: Access detailed information about a selected movie, including the synopsis, release date, and rating.
- Search Functionality: Search for movies by title.
  
## Screenshots
- Description: The home screen displays a list of movies categorized by popular, top-rated, and now-playing.
 ![image](https://github.com/user-attachments/assets/8f516b09-b8af-4a85-9fa2-e7728cfc754e)




- Description: The movie details screen shows in-depth information about the selected movie.

  ![image](https://github.com/user-attachments/assets/26f701f6-1dd6-4d88-a079-e3603ea74555)

## Installation
- Clone the repository:
```
git clone https://github.com/username/flixapp.git
```
- Navigate to the project directory:
```
cd flix_app_movie
```
- Install dependencies:
```
flutter pub get
```
- Run the application:
```
flutter run
```

## API Integration
FlixApp uses the TMDB API to fetch movie data. To use the API, you'll need to obtain an API key from TMDB.
1. Sign up for an account at TMDB and generate an API key.
2. Create a .env file in the root directory of your project and add your API key:
```
TMDB_API_KEY=your_api_key_here
```
3. The API key will be used in the application to make requests to TMDB's endpoints.
   
## State Management
FlixApp uses the Provider package for state management. This allows the app to manage state efficiently and update UI components in response to state changes.
1. Provider Setup: Providers are set up in the main file, wrapping the MaterialApp to ensure state is accessible throughout the app.
2. Usage: Providers are used to fetch data from the TMDB API and manage the state of the movie lists and search results.
