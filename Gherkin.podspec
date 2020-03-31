
Pod::Spec.new do |spec|
  spec.name         = 'Gherkin'
  spec.version      = '0.6'
  spec.platform     = :ios
  spec.ios.deployment_target = '9.0'
  spec.swift_version  = '5.0'
  spec.summary      = 'Gherkin Syntax Sugar for iOS based on Quick.'
  spec.homepage     = 'https://github.com/mangofever/iOS-Gherkin'
  spec.framework    = 'XCTest'
  spec.license      = 'MIT'
  spec.author       = { "mangofeverr" => "mangofeverr@gmail.com" }
  spec.source       = { :git => "https://github.com/mangofever/iOS-Gherkin.git", :tag => "#{spec.version}" }
  spec.source_files = 'Gherkin/Gherkin.swift'
  spec.dependency 'Quick', '2.2.0'
end
