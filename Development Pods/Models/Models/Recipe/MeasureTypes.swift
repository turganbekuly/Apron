//
//  MeasureTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.04.2022.
//

import Foundation

public enum MeasureTypes: String, CaseIterable, Codable {
    case emptyState = "--"
    case asNeeded = "по мере необходимости"
    case bag = "мешок"
    case bar = "плитка"
    case block = "брусок"
    case bottle = "бутылка"
    case box = "коробка"
    case bulb = "шарик"
    case bunch = "гроздь"
    case can = "жестяная банка"
    case carton = "картонная коробка"
    case centimeter = "сантиметр"
    case clove = "зубчик"
    case cup = "кружка"
    case deciliter = "децилитр"
    case dollop = "ложка"
    case drop = "капля"
    case fluidOunce = "жидкая унция"
    case gallon = "галлон"
    case gram = "грамм"
    case handful = "горсть"
    case head = "головка"
    case inch = "дюйм"
    case jar = "банка"
    case kilogram = "килограмм"
    case liter = "литр"
    case loaf = "буханка"
    case milligram = "миллиграмм"
    case milliliter = "миллилитр"
    case ounce = "унция"
    case package = "упаковка"
    case packet = "пакет"
    case pint = "пинта"
    case pound = "фунт"
    case quart = "четверть галлона"
    case rack = "полка"
    case rib = "ребро"
    case scoop = "мерная ложка"
    case serving = "порции"
    case sheet = "листка"
    case slice = "кусочек"
    case splash = "брызги"
    case sprig = "веточка"
    case stalk = "стебель"
    case stick = "палка"
    case tablespoon = "столовая ложка"
    case teaspoon = "чайная ложка"
    case toTaste = "на вкус"
    case tot = "маленькая рюмка"
    case tray = "поддон"
    case tub = "бочка"
    case tube = "тюбик"

    public var title: String {
        switch self {
        case .emptyState:
            return "--"
        case .asNeeded:
            return "по мере необходимости"
        case .bag:
            return "мешок"
        case .bar:
            return "плитка"
        case .block:
            return "брусок"
        case .bottle:
            return "бутылка"
        case .box:
            return "коробка"
        case .bulb:
            return "шарик"
        case .bunch:
            return "гроздь"
        case .can:
            return "жестяная банка"
        case .carton:
            return "коробка"
        case .centimeter:
            return "сантиметр"
        case .clove:
            return "зубчик"
        case .cup:
            return "кружка"
        case .deciliter:
            return "децилитр"
        case .dollop:
            return "ложка"
        case .drop:
            return "капля"
        case .fluidOunce:
            return "жидкая унция"
        case .gallon:
            return "галлон"
        case .gram:
            return "грамм"
        case .handful:
            return "горсть"
        case .head:
            return "головка"
        case .inch:
            return "дюйм"
        case .jar:
            return "банка"
        case .kilogram:
            return "килограмм"
        case .liter:
            return "литр"
        case .loaf:
            return "буханка"
        case .milligram:
            return "миллиграмм"
        case .milliliter:
            return "миллилитр"
        case .ounce:
            return "унция"
        case .package:
            return "упаковка"
        case .packet:
            return "пакет"
        case .pint:
            return "пинта"
        case .pound:
            return "фунт"
        case .quart:
            return "четверть галлона"
        case .rack:
            return "полка"
        case .rib:
            return "ребро"
        case .scoop:
            return "мерная ложка"
        case .serving:
            return "порции"
        case .sheet:
            return "листка"
        case .slice:
            return "кусочек"
        case .splash:
            return "брызги"
        case .sprig:
            return "веточка"
        case .stalk:
            return "стебель"
        case .stick:
            return "палка"
        case .tablespoon:
            return "столовая ложка"
        case .teaspoon:
            return "чайная ложка"
        case .toTaste:
            return "на вкус"
        case .tot:
            return "маленькая рюмка"
        case .tray:
            return "поддон"
        case .tub:
            return "бочка"
        case .tube:
            return "тюбик"
        }
    }

    public var units: String {
        switch self {
        case .emptyState:
            return ""
        case .asNeeded:
            return "по.нужд"
        case .bag:
            return "мешок"
        case .bar:
            return "пл"
        case .block:
            return "брус"
        case .bottle:
            return "бут"
        case .box:
            return "кор"
        case .bulb:
            return "шар"
        case .bunch:
            return "грзд"
        case .can:
            return "бн"
        case .carton:
            return "крбк"
        case .centimeter:
            return "см"
        case .clove:
            return "зуб"
        case .cup:
            return "кржк"
        case .deciliter:
            return "дцл"
        case .dollop:
            return "лжк"
        case .drop:
            return "кп"
        case .fluidOunce:
            return "fl.oz"
        case .gallon:
            return "gal"
        case .gram:
            return "гр"
        case .handful:
            return "горсть"
        case .head:
            return "головка"
        case .inch:
            return "дюйм"
        case .jar:
            return "банка"
        case .kilogram:
            return "кг"
        case .liter:
            return "л"
        case .loaf:
            return "бух"
        case .milligram:
            return "мг"
        case .milliliter:
            return "мл"
        case .ounce:
            return "унц"
        case .package:
            return "упак"
        case .packet:
            return "пакет"
        case .pint:
            return "пинта"
        case .pound:
            return "ft"
        case .quart:
            return "чет.гал"
        case .rack:
            return "полка"
        case .rib:
            return "ребро"
        case .scoop:
            return "мер.лож"
        case .serving:
            return "порц"
        case .sheet:
            return "лист"
        case .slice:
            return "кус"
        case .splash:
            return "брыз"
        case .sprig:
            return "вет"
        case .stalk:
            return "стеб"
        case .stick:
            return "палка"
        case .tablespoon:
            return "ст.л"
        case .teaspoon:
            return "ч.л"
        case .toTaste:
            return "на.вк"
        case .tot:
            return "рюм"
        case .tray:
            return "пдн"
        case .tub:
            return "боч"
        case .tube:
            return "тюб"
        }
    }
}
