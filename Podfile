source 'https://github.com/CocoaPods/Specs.git'
# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!


target 'GLClub' do
  pod 'SWXMLHash', '~> 3.0.0'
  pod 'Alamofire', '~> 4.0'
  pod 'AlamofireImage', '~> 3.1'
  pod 'Fabric'
  pod 'Crashlytics'
  
end

target 'GLClubTests' do
  pod 'SWXMLHash', '~> 3.0.0'
  pod 'Alamofire', '~> 4.0'
  pod 'AlamofireImage', '~> 3.1'
  pod 'Fabric'
  pod 'Crashlytics'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
