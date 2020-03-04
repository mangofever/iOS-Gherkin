//
//  GherkinTests.swift
//  GherkinTests
//
//  Created by mangofever on 21/02/2020.
//  Copyright © 2020 mangofever. All rights reserved.
//

import Nimble
@testable import Gherkin

protocol StartingNumberGenerator {
    var startingNumber: Int { get }
}

class WeirdAdder {
    var startingNumberGenerator: StartingNumberGenerator?
    
    var result: Int?
    
    func add(_ number: Int) {
        if let start = startingNumberGenerator?.startingNumber {
            if start == 0 {
                result = 0
            } else {
                result = start + number
            }
        }
    }
    
    func extraAdd(_ number: Int) {
        if let start = startingNumberGenerator?.startingNumber {
            result = start + number + 1
        }
    }
}

class StartingNumberGeneratorStub: StartingNumberGenerator {
    var startingNumber: Int = 0
    
    func willReturn(_ number: Int) {
        startingNumber = number
    }
}

class WeirdAdderSpec: GherkinSpec {
    override func spec() {
        Feature("add") {
            var adder: WeirdAdder!
            var generator: StartingNumberGeneratorStub!
            Background {
                adder = WeirdAdder()
                generator = StartingNumberGeneratorStub()
                adder.startingNumberGenerator = generator
            }
            
            Scenario("basic add") {
                Given("start with 10") {
                    generator.willReturn(10)
                }
                
                var numberToAdd: Int!
                Given("6 to add") {
                    numberToAdd = 6
                }
                
                When("add") {
                    adder.add(numberToAdd)
                }
                
                Then("result is not nil") {
                    expect(adder.result).notTo(beNil())
                }
                
                Then("result is 16") {
                    expect(adder.result).to(equal(16))
                }
            }
            
            Scenario("add to start number 0") {
                Given("start with 0") {
                    generator.willReturn(0)
                }
                
                var numberToAdd: Int!
                Given("9 to add") {
                    numberToAdd = 9
                }
                
                When("add") {
                    adder.add(numberToAdd)
                }
                
                Then("result is 0") {
                    expect(adder.result).to(equal(0))
                }
            }
            
            Scenario("initial result") {
                
                Then("result is nil") {
                    expect(adder.result).to(beNil())
                }
            }
        }
        
        Feature("extra add") {
            var adder: WeirdAdder!
            var generator: StartingNumberGeneratorStub!
            Background {
                adder = WeirdAdder()
                generator = StartingNumberGeneratorStub()
                adder.startingNumberGenerator = generator
            }
            
            Scenario("extra add") {
                Given("start with 15") {
                    generator.willReturn(15)
                }
                
                var numberToAdd: Int!
                Given("9 to add") {
                    numberToAdd = 9
                }
                
                When("add") {
                    adder.extraAdd(numberToAdd)
                }
                
                Then("result is not nil") {
                    expect(adder.result).notTo(beNil())
                }
                
                Then("result is 16") {
                    expect(adder.result).to(equal(25))
                }
            }
        }
    }
}
