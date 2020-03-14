# iOS-Gherkin

iOS-Gherkin is a library wrapping Quick (https://github.com/Quick/Quick)

With Quick:
```
class AdderSpec: QuickSpec {
  override func spec() {
    describe("Adder") {
      var adder: Adder!
      beforeEach {
          adder = WeirdAdder()
      }

      context("max value is 20") {
        beforeEach {
          adder.maxValue = 20
        }

        context("add 10") {
          beforeEach {
            adder.add(10)
          }

          context("add 6") {
            beforeEach {
              adder.add(6)
            }

            context("add 2") {
              beforeEach {
                adder.add(2)
              }

              context("add 1") {
                beforeEach {
                  adder.add(2)
                }
                
                context("add 3") {
                  beforeEach {
                    adder.add(3)
                  }
                  
                  it("result is 20") {
                    expect(adder.result).to(equal(20))
                  }
                }
              }
            }
          }
        }
      }
    }
  }
} // so many }}}}}}} 
```

With Gherkin:
```
class AdderSpec: GherkinSpec {
  override func spec() {
    Feature("add") {
      var adder: Adder!
      Background {
          adder = Adder()
      }

      Scenario("add over max value") {
        Given("max value is 20") {
          adder.maxValue = 20
        }
        
        When("add 10") {
          adder.add(10)
        }
        
        When("add 6") {
          adder.add(6)
        }
        
        When("add 2") {
          adder.add(2)
        }
        
        When("add 1") {
          adder.add(1)
        }
        
        When("add 3") {
          adder.add(3)
        }

        Then("result is 20") {
            expect(adder.result).to(equal(20))
        }
      }
    }
  }
}
```

## Benefits
1. less '}'s.
2. more specific context keywords (Given, When, Then).
3. no ```beforeEach``` needed.

Keywords are from Cucumber(https://cucumber.io/docs/gherkin/).

## Install
### Cocoapods
```
pod 'Gherkin'
```

This is a basic idea. So please give feedbacks to improve iOS-Gherkin. Thank you!
