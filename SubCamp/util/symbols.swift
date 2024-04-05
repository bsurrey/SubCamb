//
//  symbols.swift
//  SubCamp
//
//  Created by Benjamin Surrey on 03.04.24.
//

import Foundation
import SymbolPicker

func getSymbolGroup() -> SymbolGroup {
    let symbols = SymbolGroup("Symbols", symbols: [
         "plus","minus", "heart", "cross.case", "pill", "cross", "cross.vial", "heart.text.square", "bag", "cart", "creditcard", "banknote", "giftcard", "basket", "play", "play.rectangle", "sparkles",
        "cloud", "flame", "dog", "cat", "fish", "pawprint", "leaf", "camera.macro", "tree", "carrot", "dumbbell", "gym.bag", "figure.outdoor.cycle", "figure.walk", "figure.run", "house", "eyes.inverse", "mustache", "face.smiling.inverse", "car", "fan", "fuelpump", "ev.charger", "key", "powercord", "parkingsign.circle", "tram", "bus", "lightrail", "bicycle", "scooter", "airplane", "network", "bolt.horizontal", "antenna.radiowaves.left.and.right", "gamecontroller", "printer", "display", "laptopcomputer", "tv", "phone",
         "chart.bar",
         "chart.pie",
         "chart.xyaxis.line",
         "chart.bar.doc.horizontal",
         "chart.bar.xaxis.ascending",
         "chart.line.uptrend.xyaxis",
         "chart.line.downtrend.xyaxis",
    ])
    
    return symbols;
}
