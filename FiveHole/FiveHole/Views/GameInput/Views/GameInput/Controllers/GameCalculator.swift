//
//  gameCalculator.swift
//  FiveHole
//
//  Created by Stryker, Nathan P on 12/31/20.
//

import Foundation

class GameCalculator {
    static func calculateSavePercent(savesVar: Double, goalsVar: Double) -> Double {
        var savePercentVar = Double(savesVar/(savesVar + goalsVar))
        //var totalShotsVar = savesVar + goalsVar
        savePercentVar = savePercentVar * 100
        if savePercentVar.isNaN {
            savePercentVar = 100.0
        }
        //    calculateTotalShots(savesVar: savesVar, goalsVar: goalsVar)
        return savePercentVar
    }
    
    static func calculateTotalShots(savesVar: Double, goalsVar: Double) -> Double{
        let totalShotsVar = savesVar + goalsVar
        return totalShotsVar
    }
}
