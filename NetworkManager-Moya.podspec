#
# Be sure to run `pod lib lint NetworkManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetworkManager-Moya'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift + Moya + Cache Network request cache encapsulation'
  s.homepage         = 'https://github.com/WeiRuJian/NetworkManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WeiRuJian' => '824041965@qq.com' }
  s.source           = { :git => 'https://github.com/WeiRuJian/NetworkManager.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.requires_arc          = true
  s.swift_version         = '5.0'
  s.default_subspec       = 'Core'
  
  s.subspec 'Core' do |ss|
      ss.source_files = 'NetworkManager/Classes/Core'
      ss.dependency 'Moya/RxSwift'
  end
  
  s.subspec 'Cache' do |ss|
    ss.source_files = 'NetworkManager/Classes/Cache'
    ss.dependency 'NetworkManager-Moya/Core'
  end

end
