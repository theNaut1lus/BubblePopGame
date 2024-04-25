//
//  ColorWeightValueModel.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 12/4/2024.
//

import Foundation
import SwiftUI

struct ColorWeightValue: Identifiable ,Equatable {
    let id = UUID()
    var color: Color
    let score: Double
    let probability: Int
}
