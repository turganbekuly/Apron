//
//  MeasureTypes.swift
//  Apron
//
//  Created by Akarys Turganbekuly on 21.04.2022.
//

import Foundation

public enum MeasureTypes: CaseIterable, Decodable {
    case emptyState
    case asNeeded
    case kilogram
    case liter
    case gram
    case inch
    case drop
    case milligram
    case milliliter
    case ounce
    case package
    case packet
    case pint
    case fluidOunce
    case gallon
    case tablespoon
    case teaspoon
    case toTaste
    case handful
    case head
    case jar
    case loaf
    case pound
    case bag
    case bar
    case block
    case bottle
    case box
    case bulb
    case bunch
    case can
    case carton
    case centimeter
    case clove
    case cup
    case deciliter
    case dollop
    case quart
    case rack
    case rib
    case scoop
    case serving
    case sheet
    case slice
    case splash
    case sprig
    case stalk
    case stick
    case tot
    case tray
    case tub
    case tube

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
            return "баночка"
        case .carton:
            return "коробка"
        case .centimeter:
            return "см"
        case .clove:
            return "зубчик"
        case .cup:
            return "кружка"
        case .deciliter:
            return "дцл"
        case .dollop:
            return "ложка"
        case .drop:
            return "капля"
        case .fluidOunce:
            return "жидкая унция"
        case .gallon:
            return "галлон"
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
            return "буханка"
        case .milligram:
            return "мг"
        case .milliliter:
            return "мл"
        case .ounce:
            return "унция"
        case .package:
            return "упаковка"
        case .packet:
            return "пакет"
        case .pint:
            return "пинта"
        case .pound:
            return "фт"
        case .quart:
            return "1/4 галлона"
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
            return "ст.ложка"
        case .teaspoon:
            return "ч.ложка"
        case .toTaste:
            return "на вкус"
        case .tot:
            return "рюмочка"
        case .tray:
            return "поддон"
        case .tub:
            return "бочка"
        case .tube:
            return "тюбик"
        }
    }
}
