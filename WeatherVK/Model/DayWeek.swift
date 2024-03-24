enum DayWeek: Int {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var titleVKUI: String {
        switch self {
        case .sunday: "воскресенье"
        case .monday: "понедельник"
        case .tuesday: "вторник"
        case .wednesday: "среда"
        case .thursday: "четверг"
        case .friday: "пятница"
        case .saturday: "суббота"
        }
    }

    var title: String {
        switch self {
        case .sunday: "Sunday"
        case .monday: "Monday"
        case .tuesday: "Tuesday"
        case .wednesday: "Wednesday"
        case .thursday: "Thursday"
        case .friday: "Friday"
        case .saturday: "Saturday"
        }
    }
}

extension DayWeek {
    var isWeekend: Bool {
        self == .saturday || self == .sunday
    }
}
