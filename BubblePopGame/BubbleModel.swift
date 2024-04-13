//
//  BubbleModel.swift
//  BubblePopGame
//
//  Created by Sidak Singh Aulakh on 12/4/2024.
//

import Foundation

struct Bubble: Identifiable, Equatable {
    let id = UUID()
    let position: CGPoint
//    let color: Color
//    let scoreValue: Int
    var colorWeightValue = ColorWeightValue(color: .brown, score: 0, probability: 0) //a default value that should never occur.
    let creationTime: Date
    let colorList: [ColorWeightValue] = [
        ColorWeightValue(color: .red,score: 1,probability: 40),
        ColorWeightValue(color: .pink,score: 2,probability: 30),
        ColorWeightValue(color: .green,score: 5,probability: 15),
        ColorWeightValue(color: .blue,score: 8,probability: 10),
        ColorWeightValue(color: .black,score: 10,probability: 5)
    ]
    

    //init to assign weighted values to the bubble when creating a bubble object
    init(position: CGPoint, creationTime: Date) {
        self.position = position
//        self.colorWeightValue = colorWeightValue
        self.creationTime = creationTime
        self.colorWeightValue = weightedColor(input: colorList)
    }
    
    //logic to generate a weighted random color.
    func weightedColor(input: [ColorWeightValue]) -> ColorWeightValue {

        let total = UInt32(input.map { $0.probability }.reduce(0, +))
        let rand = Int(arc4random_uniform(total))

        var sum = 0
        for eachInput in input {
            sum += eachInput.probability
            if rand < sum {
                return eachInput
            }
        }
        fatalError("This should never be reached")
    }
 
}
