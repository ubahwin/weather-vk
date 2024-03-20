# Приложение погоды

<div align="center">
    <img src="img/logo.png" alt="AppIcon" height="200">
</div>

![](https://img.shields.io/badge/iOS-16%2B-green?logo=apple)
![](https://img.shields.io/badge/Swift%205.9-FA7343?style=flat&logo=swift&logoColor=white)

Weather имеет расширяемую реактивную Redux-like архитектуру

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/1.png" style="width:200px;">
  <img src="img/2.png" style="width:200px;">
</div>

## Структура проекта

```
WeatherVK
│
├── AppDelegate   <- @main
│
├── Network
│   ├── DTO
│   │   └── ...   <- Response types and mapping
│   ├── APIClient
│   ├── APIRouter
│   └── ...
│
├── Repository
│   └── WebRepository
│       └── ...
│
├── View
│   └── ...
│
├── Model
│   └── ...
│
│
├── WeatherReducer
├── AppState      <- Single Source of Trust
├── Environment   <- Bind for SwiftUI
│
├── Docs          <- openapi.yaml
└── ...           <- Resources and utility
```

## Технологии и инструменты

- [UIKit]()
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Combine]()
- [Сетевой слой](https://github.com/sajjadsarkoobi/CombineNetworking---SwiftUI)
- [OpenWeather API](https://openweathermap.org)
- [CoreLocation]()
- [Postman](https://www.postman.com/)
- [SwiftLint](https://github.com/realm/SwiftLint)
