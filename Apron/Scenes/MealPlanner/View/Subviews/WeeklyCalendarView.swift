//
//  WeeklyCalendarView.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 15.01.2023.
//

import UIKit
import APRUIKit
import Extensions
import SwiftDate

protocol WeeklyCalendarViewProtocol: AnyObject {
    func weekDayRangeChanged(start: Date, end: Date)
}

final class WeeklyCalendarView: View {
    // MARK: - Private properties

    private var todaysDate = Date()

    // MARK: - Public properties

    weak var delegate: WeeklyCalendarViewProtocol?

    // MARK: - Views factory

    private lazy var previousWeekButton: UIButton = {
        $0.setImage(ApronAssets.mealPlannerLeftArrow.image, for: .normal)
        $0.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var nextWeekButton: UIButton = {
        $0.setImage(ApronAssets.mealPlannerRightArrow.image, for: .normal)
        $0.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return $0
    }(UIButton())

    private lazy var currentWeekDateRange: UILabel = {
        $0.font = TypographyFonts.semibold16
        $0.textColor = ApronAssets.primaryTextMain.color
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private lazy var separatorView = SeparatorView()

    // MARK: - Setup Views

    override func layoutSubviews() {
        super.layoutSubviews()
        setupWeekView()
    }

    override func setupViews() {
        super.setupViews()
        addSubviews(previousWeekButton, nextWeekButton, currentWeekDateRange, separatorView)
    }

    override func setupConstraints() {
        super.setupConstraints()

        separatorView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        previousWeekButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(24)
        }

        nextWeekButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }

        currentWeekDateRange.snp.makeConstraints {
            $0.centerY.equalTo(previousWeekButton.snp.centerY)
            $0.leading.equalTo(previousWeekButton.snp.trailing).offset(8)
            $0.trailing.equalTo(nextWeekButton.snp.leading).offset(-8)
        }
    }

    // MARK: - User actions

    @objc
    private func previousButtonTapped() {
        todaysDate = CalendarHelper().addDays(date: todaysDate, days: -7)
        setupWeekView()
    }

    @objc
    private func nextButtonTapped() {
        todaysDate = CalendarHelper().addDays(date: todaysDate, days: 7)
        setupWeekView()
    }

    // MARK: - Private methods

    private func getTodaysDate() -> Date {
        let today = Date()
        return today.localDate()
    }

    private func setupWeekView() {
        let current = CalendarHelper().mondayForDate(date: todaysDate)
        let currentMonthString = CalendarHelper().monthString(date: current)
        let currentDayInt = CalendarHelper().dayOfMonth(date: current)
        let nextMonday = CalendarHelper().addDays(date: current, days: 6)
        let nextMondayMonthString = CalendarHelper().monthString(date: nextMonday)
        let nextMondayInt = CalendarHelper().dayOfMonth(date: nextMonday)
        currentWeekDateRange.text = "\(currentDayInt ?? 1) \(currentMonthString) - \(nextMondayInt ?? 1) \(nextMondayMonthString)"
        delegate?.weekDayRangeChanged(start: current, end: nextMonday)
    }
}

extension Date {
    func localDate() -> Date {
        let nowUTC = Date()
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: nowUTC))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: nowUTC) else {return Date()}

        return localDate
    }
}
