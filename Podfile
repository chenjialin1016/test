#source 'https://github.com/CocoaPods/Specs.git'
#source 'https://github.com/Alamofire/Alamofire.git'
platform :ios, '9.0'
use_frameworks!

def testing_pods
    pod 'Quick', '~>1.0.0'
    pod 'Nimble', '~>5.0.0'
    pod 'Alamofire', '~> 4.0.1'
end

def test_pods
end

target 'test' do
    test_pods
end

target 'testTests' do
    testing_pods
end

#target 'testUITests' do
#  testing_pods
#end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.2'
        end
    end
end
