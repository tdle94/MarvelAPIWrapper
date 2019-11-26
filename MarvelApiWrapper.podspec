#
# Be sure to run `pod lib lint MarvelApiWrapper.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MarvelApiWrapper'
  s.version          = '0.1.0'
  s.summary          = 'A wrapper class around Marvel API that will make your life easier for requesting characters, comics, event, stories and much more from Marvel Studio'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Is making an API request to Marvel too tedious for you. From having to provide parameters to your GET request with a long url. This wrapper will filter out optional parameter for you and make your GET request experience better'

  s.swift_version    = '4.0'
  s.homepage         = 'https://github.com/tdle94/MarvelApiWrapper'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tdle94' => 'tuyendle92' }
  s.source           = { :git => 'https://github.com/tdle94/MarvelApiWrapper.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MarvelApiWrapper/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MarvelApiWrapper' => ['MarvelApiWrapper/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
