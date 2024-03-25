# Приложение погоды <!-- omit in toc -->

<!-- markdownlint-disable MD033 -->

![iOS Version Shield](https://img.shields.io/badge/iOS-16%2B-green?logo=apple)
![Swift Version Shield](https://img.shields.io/badge/Swift%205.9-FA7343?style=flat&logo=swift&logoColor=white)

<div align="center">
    <img src="img/logo.png" alt="AppIcon" height="100" style="border-radius: 20px;">
</div>

## Содержание <!-- omit in toc -->

- [О проекте](#о-проекте)
- [Архитектура](#архитектура)
- [OpenAPI](#openapi)
- [Установка](#установка)
- [Структура проекта](#структура-проекта)
- [Стратегии разработки](#стратегии-разработки)
  - [SwiftLint](#swiftlint)
  - [Git Hooks](#git-hooks)
- [Старый дизайн](#старый-дизайн)
- [Технологии и инструменты](#технологии-и-инструменты)

## О проекте

Приложение имеет расширяемую _Redux-like_ архитектуру. Для обеспечения
реактивности различных делегатов, таких как из `CoreLocation`, `MapKit` и т.д.,
я использую `Combine`.

Уровень представления отделён от основной логики приложения, что позволяет
безболезненно подставлять различные реализации. В проекте мною реализованы два
почти одинаковых взаимозаменяемых представления: одно на `UIKit`, второе – на
`SwiftUI`.

В качестве референса использовал мини-приложение
[VK Погода](https://vk.com/weather). Старался следовать
[гайдлайнам VKUI](<https://www.figma.com/file/fGTRlPTuTu8UYAyoDD6XGY/VKUI-iOS-Library-(Community)?type=design&node-id=609-220&mode=design&t=NtFoQRNhPt4qspzt-0>),
реализовал дизайн-систему в своём приложении.

Реализован поиск городов с помощью `MKLocalSearch`. Определение геопозиции
пользователя и названия города по координатам с помощью `CLGeocoder`. Сетевой
слой написан с использованием `Combine`.

С бесплатной версии OpenWeather API данные о погоде приходят только за последние
5 дней с интервалом в 3 часа. Поэтому эти данные обрабатываются в
`ForecastFormatter`'е, который покрыт Unit-тестами. Составляется выборка с
конкретными днями недели и данными.

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/1.jpg" alt="Главное меню" style="width:200px;">
  <img src="img/2.jpg" alt="Поиск по городам" style="width:200px;">
  <img src="img/3.jpg" alt="Forecast" style="width:200px;">
  <img src="img/4.jpg" alt="Skeleton" style="width:200px;">
</div>

https://github.com/ubahwin/weather-vk/assets/98765309/9bc75ead-ca97-429b-a5b1-d4da6d40f18a

## Архитектура

![Архитектура приложения](./img/architecture.png)

Приложение поделено на слои-модули, общение между которыми происходит по
протоколам. `AppState` – single source of truth, он независим от других слоёв.
`Reducer` инкапсулирует бизнес-логику для представления. `Repository` – это
абстрактный шлюз для чтения/записи данных.

Подробнее об этом на моём сайте:
[https://ubahdev.ru/articles/clean-architecture-for-swiftui](https://ubahdev.ru/articles/clean-architecture-for-swiftui).

## OpenAPI

Была написана OpenAPI-спецификация на OpenWeather API в формате YAML:
[`docs/openapi.yaml`](docs/openapi.yaml). На основе этой спецификации работает
кодогенерация моделей ответов сервера с помощью инструмента
[OpenAPI Generator](https://openapi-generator.tech/) через самописный скрипт
[`gentypes.sh`](gentypes.sh).

## Установка

Необходимо вписать токен OpenWeather API в константу `token` в файле
[`Network/APIConstants.swift`](WeatherVK/Network/APIConstants.swift):

```swift
static let token: String = "<token>"
```

Архитектура также позволяет заменить `OpenWeatherWebRepository` на свой
компонент, реализующий `WebRepository`, например `StubWeatherWebRepository`.

## Структура проекта

<!-- markdownlint-disable MD040 -->

```
WeatherVK
├── AppDelegate     <- @main
├── Network
│   ├── DTO
│   │   └── ...     <- Response types and mapping
│   ├── APIClient
│   ├── APIRouter
│   └── ...
├── Repository
│   └── WebRepository
│       └── ...
├── View
│   └── ...
├── Model
│   └── ...
├── WeatherReducer
├── AppState        <- Single Source of Trust
├── Environment     <- Bind for SwiftUI
├── LocationManager <- Location detect
├── docs            <- openapi.yaml
└── ...             <- Resources and utility
```

<!-- markdownlint-enable MD040 -->

## Стратегии разработки

Разработка ведется на `dev`-ветке, переодически изменения вливаются в `main`. На
момент сдачи проекта актуальная версия на ветке `main`.

### SwiftLint

В Build Phases используется следующий Run Script, запускающий линтер
[SwiftLint](https://github.com/realm/SwiftLint) перед сборкой проекта:

```bash
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint >/dev/null; then
  swiftlint --strict --config ./.swiftlint.yml
else
  echo "error: SwiftLint does not exist"
  exit 1
fi
```

### Git Hooks

Для защиты токена был написан Git Hook pre-commit, который заменяет вхождения
токена в файле `Network/APIConstants.swift` на `<token>` перед выполнением
коммита.

Чтобы добавить этот Hook, выполните команды:

```bash
cd .git/hooks
ln -s ../../git_hooks/pre-commit
```

## Старый дизайн

Облака с информацией в главном меню можно двигать, также при тряске телефона они
немного меняют свою позицию, что делает приложение более живым — так я хотел
продемонстрировать свои навыки верстки. Стрелка показывает направление ветра,
даже если поменять ориентацию iPhone. Таблица сверстана на `UIKit` с
использованием `UITableView` без использования Storyboard. Главное меню – на
`SwiftUI`.

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <img src="img/10.jpg" alt="Главное меню" style="width:200px;">
  <img src="img/11.jpg" alt="Таблица прогноза погоды" style="width:200px;">
</div>

## Технологии и инструменты

- [UIKit](https://developer.apple.com/documentation/uikit)
- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Combine](https://developer.apple.com/documentation/combine)
- [Сетевой слой](https://danielbernal.co/writing-a-networking-library-with-combine-codable-and-swift-5/)
- [OpenWeather API](https://openweathermap.org)
- [CoreLocation](https://developer.apple.com/documentation/corelocation)
- [MapKit](https://developer.apple.com/documentation/mapkit/)
- [SwiftLint](https://github.com/realm/SwiftLint)
- [OpenAPI Generator](https://openapi-generator.tech/)
