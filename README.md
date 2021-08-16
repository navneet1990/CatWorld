# CatWorld
User can search any cat breed, and grid list will be display with typing. User can also tap the item and see the details about the case

[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-12.5.1-blue.svg)](https://developer.apple.com/xcode)

This project is developed  in Swift without any third party framework. The app displays cats from server based upon keyword entered on search bar, and user can scroll the grid list and tap the icon to see detail page.
Below are the screens:


<img height="480" src="https://github.com/navneet1990/CatWorld/blob/main/CatWorld/Resources/DemoScreeenshot/SearchPage.png" alt="CatWorld">    <img height="480" src="https://github.com/navneet1990/CatWorld/blob/main/CatWorld/Resources/DemoScreeenshot/DetailPage.png" alt="CatWorld">

## Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Approaches](#approaches)
- [Limitations](#limitations)
- [Known issues](#known)

## Features

- [x] Structure based upon MVVM architecture and Protocol oriented programming.
- [x] 100% developed in Swift and Universal device(iPhone/iPad) support.
    - [x] Use autolayouts 
    - [x] Landscape and Potrait orientation support.
- [x] UI and Unit testing. 55.1%  test coverage
    - [x] Testing using mocking and dependency injection.
- [x] API hosted on [CatAPI](https://thecatapi.com/) server.

## Requirements

- iOS 13+
- Xcode 12+
- Swift 5.0
- An app that allows the user to search for breeds of cats (or dogs), present the results and allows
them to find out more about a specific cat (or dog).

## Approaches:
-  Developed using **MVVM** architecture, to keep all business logic in **ViewModels** and UI in **Views(ViewControllers, Views)**. It also holds decodable models of Breeds.
- Network Manager, will manage network calls, which is returns breeds in form of Breed model.
- **Bindable** generic class is used for data binding
- Breed Model used class instead of structure because reference object will be used to store everything at one place instead of multiple value type models. Reference types are easy to manage and update when data is updated lazyily and user can pass references.
- ImageModel is also class type.
- ImageCache is a singleton class, that downloads and cache the image. It will also clear cache manually in case memory warning received.
- Search logic is in **CWSearchViewModel**, it will start search and display results on entering any keyword. And response will be displayed on grid layout.
- **BreedCellViewModel** is owned by BreedCell, **it will download the image model data to get the url and then download the image.  It will update the class type breed model object, and hold the image and avoid downloading again.**
- **Not data is prefetched like Image and image URLs, to avoid unnecessary calls.** This data will only be fetched when cell will load and reuse it. 
- **CWDetailViewModel** is owned by CWDetailViewController. Here we are passing breed object and by default pubic cache object is initialized. It will be helpful when we write Unit test case to fetch image.
- **Endpoint** structure is used for creating endpoints.
- Some other extensions are used to make things smooth.
- Error handling are done by try and catch exception.
- App supports Unit testing and most the tested cases are writted and covered where business logic is added.

## Limitations:
- No offline support.
- No support for dogs API
- No UI testing support. Just added one method and one of the approach we can also use for UI testing mock data
** These above limitation are due to time bound.**


## Known Issues:
App does not have any major issues, but still small improvements can be added to optimize the solution and performance. These are:
- UIImage object in view models could be replaced by NSData to keep ViewModels indenepend of UIKit framework, but since it a custom MVVM, most of the codebases and architecture solution accepts it.
- Support for Offline handling using core data.
- Storing images url in first API call, this will avoid unnecessary extra call to get the URL. But its backened error.
- Errors can be handled better.

**These above limitationd and issues are improvments, which could be addressed easily if required. This code is just an examply of MVVM pattern and how fast we can load the data and also support Unit testing.**






