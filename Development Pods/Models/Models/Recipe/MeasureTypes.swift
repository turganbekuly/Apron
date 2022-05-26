//
//  MeasureTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.04.2022.
//

import Foundation

public enum MeasureTypes: String, CaseIterable, Codable {
    case emptyState = "--"
    case kilogram = "кг"
    case gram = "г"
    case liter = "л"
    case piece = "штук"
    case tablespoon = "ст.л"
    case teaspoon = "ч.л"
    case scoop = "мер.л"
    case milligram = "мг"
    case milliliter = "мл"
    case centimeter = "см"
    case glass = "стакан"
    case asNeeded = "по необходимости"
    case toTaste = "по вкусу"
    case bag = "мешка"
    case bar = "плитки"
    case block = "брусока"
    case bottle = "бутылки"
    case box = "коробки"
    case bulb = "шарика"
    case bunch = "гроздь"
    case clove = "зубчик"
    case cup = "кружка"
    case deciliter = "дец.л"
    case drop = "капель"
    case handful = "горсть"
    case head = "головки"
    case inch = "дюйм"
    case jar = "банки"
    case loaf = "буханки"
    case ounce = "унции"
    case package = "упаковки"
    case packet = "пакета"
    case pint = "пинты"
    case serving = "порции"
    case sheet = "листка"
    case slice = "кусочека"
    case splash = "брызги"
    case sprig = "веточки"
    case stalk = "стебель"
    case stick = "палки"
    case tub = "бочки"
    case tube = "тюбика"
}
