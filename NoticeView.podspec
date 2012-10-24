#
# Be sure to run `pod spec lint NoticeView.podspec' to ensure this is a
# valid spec.
#
# Remove all comments before submitting the spec. Optional attributes are commented.
#
# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
#
Pod::Spec.new do |s|
  s.name         = "NoticeView"
  s.version      = "1.0"
  s.summary      = "A notice component for iOS."
  s.description  = <<-DESC
		A fork of tciuro/NoticeView with simplified API, reduced class count and changed look and feel.
		This displays an animated notice at the top of the specified view with a message and icon which
		can be manually, programmatically, or automatically dismissed.
    DESC
  s.homepage     = "https://github.com/levigroker/NoticeView"
  s.license      = 'MIT'
  s.author       = { "Levi Brown" => "levigroker@gmail.com" }
  s.source       = { :git => "https://github.com/levigroker/NoticeView.git" :tag => '0.1'}
  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.source_files = 'NoticeView/WBNoticeView/**/*.{h,m}'
  s.resources = "NoticeView/WBNoticeView/*.bundle"
  s.frameworks = 'Foundation', 'UIKit', 'CoreGraphics', 'QuartzCore'
  s.requires_arc = true
end
