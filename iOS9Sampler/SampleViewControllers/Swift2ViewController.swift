//
// Swift2.swift
//  iOS9Sampler
//
//  Created by Grant Kemp on 10/10/15.
//  Copyright © 2015 Grant Kemp. All rights reserved.
//

import UIKit

// Included Swift 2 bits in here so its a complete refeerence for all the things that are interesting for developers

class Swift2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("You now use 'print' instead of 'println' to show console messages. To see other Swift 2 items - check the source code")
        
    }
    
    
    //MARK: Guard Syntax
    
    //New Guard Syntax for non optionals for Swift 2.0
    func newWayToGuardNonOptionals(numberOfSeatsInCar: Int) -> String {
        
        guard numberOfSeatsInCar > 0 else  {
            return "you can't have a car without seats.. sure its not a drone?"
        }
        // you can do stuff safely with numberOfSeatsInCar knowing that it has seats
        return "We have more than zero seats in car"
    }
}

// old Syntax for  earlier versions of Swift

func oldWayTouseNonOptionals(numberOfSeatsInCar: Int) -> String {
    if numberOfSeatsInCar > 0 {
        // you can do stuff safely with numberOfSeatsInCar knowing that it has seats
        return "We have more than zero seats in car"
    }
    else {
        return "you can't have a car without seats.. sure its not a drone?"
    }
}


//New Guard Syntax for optionals for Swift 2.0
func newWayToGuardOptionls(numberOfRocketBoostersOnCar: Int?) -> String{
    guard let numBoosters = numberOfRocketBoostersOnCar else {
        //no rocket boosters on car
        return "Its just a normal car no rocket boosters Keep Drivng"
    }
    //Guard statement passes so the car has rocket boosters.
    return "Lets fire the \(numBoosters) Boosters"
    //Protip: you can use the guarded variable below unlike in the old "if let" syntax
    
    
}

//Old "If Let" Syntax for  optionals for Earlier Swift Versions

func oldWayToGuardOptionls(numberOfRocketBoostersOnCar: Int?) -> String{
    if let unwrappedBoosterCount = numberOfRocketBoostersOnCar {
        //yes there are boosters on the car
        return "Let's fire the  \(unwrappedBoosterCount) Boosters"
    }
    else {
        //no rocket boosters on car
        return "Its just a normal car no rocket boosters Keep Drivng"
    }
    //Protip: you can't use the "unwrapped" variable below unlike in the new "guard" syntax
}

