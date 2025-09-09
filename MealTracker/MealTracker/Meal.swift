//
//  Meal.swift
//  MealTracker
//
//  Created by Tanish on 08/09/25.
//

import Foundation


struct Meal{
    
    let name: String
    let food: [Food]
    
}


var meals: [Meal] {
    let breakfast = Meal(name: "BreakFast", food: breakfast)
    let lunch = Meal(name: "Lunch", food: lunch)
    let dinner = Meal(name: "Dinner", food: dinner)
    return [breakfast, lunch, dinner]
    
}
