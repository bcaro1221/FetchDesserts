# FetchDesserts
Basic app to display a dessert feed and show each dessert's recipe

## Project Overview

This repository contains my solution to the Fetch iOS Coding Challenge. The goal of the challenge was to create a native iOS app that allows users to browse recipes using the MealDB API, focusing on the Dessert category.

## Features

- Fetches the list of meals in the Dessert category from the MealDB API.
- Displays the list of meals alphabetically sorted.
- Allows users to view detailed information about a selected meal, including name, instructions, and ingredients/measurements.

## Implementation Details

- Developed using Swift, SwiftUI, and Xcode.
- Utilizing MVVM architecture
- [NukeUI](https://github.com/kean/Nuke/) v12.1.6 leveraged for AsyncImage loading
- iOS 15 minimum
- Developed using the MealDB API endpoints:
  - List of Meals: `https://themealdb.com/api/json/v1/1/filter.php?c=Dessert`
  - Meal Details: `https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID`
 

## Demo

https://github.com/bcaro1221/FetchDesserts/assets/44105448/bd4bbadc-7f72-41d9-91a3-0b8ff43d2811

