# Weather Application

## Project Overview
 - A real time weather tracking app that provides data based on user current position 
- It has auto completion supported search functionality. User can search desired location and see its weather information.
- It has refresh button to update weather information for last used location
- It also provide current position button to check current location's weather information at any time.

## API
App fetch weather infomation from a free data provider(www.weatherapi.com). Used two API
1. Search API:- This API use single text to get an array of locations that with the text.
2. Current API:- This API use query(city name/zipcode/lat-lon) and fetch weather information acoording to the query.

## Project architecture
Code structured based on MVVM design pattern. Also maintained SOLID principles

- **Model :** WeatherModel contains all the model used for this single page app. it also has the API service class that responsible to fet weather infomation.
- **View :** LandingPage has a single page viewcontroller where all the view and sub views are implemented. It has a views folder that contains all the sub views.
- **ViewModel :** LandingPageViewModel is for the Landing Page's viewmodel. It contains all the business logic and variables. ViewModel fetch data from API service and provides to ViewController.

## Technology used
- **Swift** -> Full projects written in Swift.
- **ReactiveSwift** -> ReactiveSwift is FRP(Functional Reactive Programming) based framework. Similliar to RxSwift and Combine.
- **CoreLocation** -> CoreLocation is first party framework provided by Apple. This framework is used to get user current location.
- **Reachability.swift** -> Reachability.swift is used for checking network connection
