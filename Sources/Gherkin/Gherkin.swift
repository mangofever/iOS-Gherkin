//
//  Gherkin.swift
//  Gherkin
//
//  Created by mangofever on 21/02/2020.
//  Copyright © 2020 mangofever. All rights reserved.
//

import Foundation
import Quick

enum KeyworkType {
    case feature
    case scenario
    case given
    case when
    case then
}

struct Keyword {
    let type: KeyworkType
    let description: String
    let closure: (() -> Void)?
}

public class KeywordHolder {
    var keywords = [Keyword]()
    
    var featureDescription: String = ""
    var eachScenario: (() -> Void)?
    
    func append(type: KeyworkType, description: String, closure: (() -> Void)?) {
        keywords.append(Keyword(type: type, description: description, closure: closure))
    }
    
    func flush() {
        if !keywords.isEmpty {
            let keyword = keywords.removeFirst()
            switch keyword.type {
            case .feature:
                featureDescription = keyword.description
                flush()
            case .scenario:
                quickDescribe("Feature \(featureDescription)", closure: keyword.closure) {
                    quickDescribe("Scenario \(keyword.description)", closure: {
                        self.eachScenario?()
                        keyword.closure?()
                    }) {
                        flush()
                    }
                }
            case .given:
                quickDescribe("Given \(keyword.description)", closure: keyword.closure) {
                    flush()
                }
            case .when:
                quickDescribe("When \(keyword.description)", closure: keyword.closure) {
                    flush()
                }
            case .then:
                it("Then \(keyword.description)") {
                    keyword.closure?()
                }
                
                flush()
            }
        }
    }
    
    private func quickDescribe(_ description: String, closure: (() -> Void)?, next: () -> Void) {
        describe(description) {
            beforeEach {
                closure?()
            }
            
            next()
        }
    }
    
    private func quickContext(_ description: String, closure: (() -> Void)?, next: () -> Void) {
        describe(description) {
            beforeEach {
                closure?()
            }
            
            next()
        }
    }
}

open class GherkinSpec: QuickSpec {
    var currentHolder: KeywordHolder?
    
    public func Feature(_ description: String, closure: () -> Void) {
        currentHolder = KeywordHolder()
        currentHolder?.append(type: .feature, description: description, closure: nil)
        closure()
    }
    
    public func Scenario(_ description: String, closure: () -> Void) {
        currentHolder?.append(type: .scenario, description: description, closure: nil)
        closure()
        currentHolder?.flush()
    }
    
    public func Background(closure: @escaping () -> Void) {
        currentHolder?.eachScenario = closure
    }
    
    public func Given(_ description: String, closure: @escaping () -> Void) {
        currentHolder?.append(type: .given, description: description, closure: closure)
    }
    
    public func When(_ description: String, closure: @escaping () -> Void) {
        currentHolder?.append(type: .when, description: description, closure: closure)
    }
    
    public func Then(_ description: String, closure: @escaping () -> Void) {
        currentHolder?.append(type: .then, description: description, closure: closure)
    }
}
