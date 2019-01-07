#
# Be sure to run `pod lib lint SwiftTwitch.podspec' to ensure this is a
# valid spec before submitting.
#

Pod::Spec.new do |s|
  s.name             = 'SwiftTwitch'
  s.version          = '0.1.0'
  s.summary          = 'Wrapper for the New Twitch API written in Swift.'

  s.description      = <<-DESC
SwiftTwitch allows for accessing the Twitch API is a typed, safe, and readable way. To view a proper
usage document of SwiftTwitch, please view the GitHub README available here: https://github.com/chrisfromtemporaryid@gmail.com/SwiftTwitch.git
                       DESC

  s.homepage         = 'https://github.com/Chris-Perkins/SwiftTwitch'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chrisfromtemporaryid@gmail.com' => 'chrisfromtemporaryid@gmail.com' }
  s.source           = { :git => 'https://github.com/Chris-Perkins/SwiftTwitch.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/chrispperkins/'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftTwitch/Classes/**/*'	
  
  s.dependency 'Marshal', '~> 1.2.7'
  s.swift_version = '4.2'
end
