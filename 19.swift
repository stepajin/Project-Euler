// You are given the following information, but you may prefer to do some research for yourself.

//  1 Jan 1900 was a Monday.
//  Thirty days has September,
//  April, June and November.
//  All the rest have thirty-one,
//  Saving February alone,
//  Which has twenty-eight, rain or shine.
//  And on leap years, twenty-nine.
//  A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

// How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

enum DayOfWeek: Int {
    case monday = 1, tuesday, wednesday, thursday, friday, saturday, sunday
}

struct Date {
    let day: Int, month: Int, year: Int
}

func isLeapYear(_ year: Int) -> Bool {
    year % 4 == 0 && (year % 400 == 0 || year % 100 != 0)
}

func dayOfYear(date: Date) -> Int {
    let daysInFebruary = isLeapYear(date.year) ? 29 : 28
    let daysInMonth = [31, daysInFebruary, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    return daysInMonth[0..<date.month-1].reduce(0, +) + date.day
} 

func numberOfDaysBetween(_ day1: Date, _ day2: Date) -> Int {
    (day1.year..<day2.year).map { isLeapYear($0) ? 366 : 365 }.reduce(0, +) + dayOfYear(date: day2) - 1
}

func dayOfWeek(_ date: Date) -> DayOfWeek {
    DayOfWeek(rawValue: (numberOfDaysBetween(Date(day: 1, month: 1, year: 1900), date) % 7) + 1)!
}

let result = (1901...2000).reduce(0) { count, year in
    count + (1...12).filter { dayOfWeek(Date(day: 1, month: $0, year: year)) == .sunday }.count
}
print(result)