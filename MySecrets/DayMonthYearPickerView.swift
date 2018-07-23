//
//  DayMonthYearPickerView.swift
//  MySecrets
//
//  Created by Ben Dodson on 15/04/2015.
//  Modified by Jiayang Miao on 24/10/2016 to support Swift 3
//  Modified by User on 7/21/18.
//  Copyright © 2018 Piligrim. All rights reserved.
//

import UIKit

class DayMonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {

    var days: [Int]!
    var months: [String]!
    var years: [Int]!
    var date = Date() {
        didSet {
            setPicker()
        }
    }

    var day: Int = 0 {
        didSet {
            selectRow(days.index(of: day)!, inComponent: 0, animated: true)
        }
    }

    var month: Int = 0 {
        didSet {
            selectRow(month-1, inComponent: 1, animated: false)
        }
    }
    
    var year: Int = 0 {
        didSet {
            selectRow(years.index(of: year)!, inComponent: 2, animated: true)
        }
    }
    
    var onDateSelected: ((_ day: Int, _ month: Int, _ year: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
    
    func commonSetup() {
        // population years
        var years: [Int] = []
        var currentYear = 0
        var currentDay = 0
        if years.count == 0 {
            var year = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: NSDate() as Date)
            currentYear = year
            year -= 119
            for _ in 1...120 {
                years.append(year)
                year += 1
            }
        }
        self.years = years
        
        // population months with localized names
        var months: [String] = []
        var month = 0
        for _ in 1...12 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months

        // population days
        var days: [Int] = []
        var day = 1
        for _ in 1...31 {
            days.append(day)
            day += 1
        }
        currentDay = 1
        self.days = days

        self.delegate = self
        self.dataSource = self

        self.selectRow(currentDay, inComponent: 0, animated: false)
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: NSDate() as Date)
        self.selectRow(currentMonth - 1, inComponent: 1, animated: false)
        self.selectRow(years.index(of: currentYear)!, inComponent: 2, animated: false)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.date(from: "\(currentYear)/\(currentMonth)/\(currentDay)")!
    }
    
    func setPicker() {
        let currentDay = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.day, from: date)
        let currentYear = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.year, from: date)
        let currentMonth = NSCalendar(identifier: NSCalendar.Identifier.gregorian)!.component(.month, from: date)
        
        if let currentDay = days.index(of: currentDay) {
            selectRow(currentDay, inComponent: 0, animated: false)
        }
        selectRow(currentMonth - 1, inComponent: 1, animated: false)
        if let currentYearIndex = years.index(of: currentYear) {
            selectRow(currentYearIndex, inComponent: 2, animated: false)
        }

        //check number days of the month
        let calendar = Calendar.current
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        if numDays != days.count {
            var daysTemp: [Int] = []
            var dayCounter = 1
            for _ in 1...numDays {
                daysTemp.append(dayCounter)
                dayCounter += 1
            }
            self.days = daysTemp
        }
    }
    
    // Mark: UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(days[row])"
        case 1:
            return months[row]
        case 2:
            return "\(years[row])"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return days.count
        case 1:
            return months.count
        case 2:
            return years.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = self.selectedRow(inComponent: 1)+1
        let year = years[self.selectedRow(inComponent: 2)]
        var day = self.selectedRow(inComponent: 0)+1

        //check number days of the month
        let dateComponents = DateComponents(year: year, month: month)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        if numDays != days.count {
            var daysTemp: [Int] = []
            var dayCounter = 1
            for _ in 1...numDays {
                daysTemp.append(dayCounter)
                dayCounter += 1
            }
            self.days = daysTemp
            self.reloadComponent(0)
            day = min(numDays, day)
            selectRow(day, inComponent: 0, animated: false)
        }
        
        //let day = self.selectedRow(inComponent: 0)+1
        if let block = onDateSelected {
            block(day, month, year)
        }
        
        self.day = day
        self.month = month
        self.year = year
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        self.date = formatter.date(from: "\(year)/\(month)/\(day)")!
        
    }
    
}
