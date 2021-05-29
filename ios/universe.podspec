#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint universe.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'universe'
  s.version          = '0.0.1'
  s.summary          = 'Flutter Universe'
  s.description      = <<-DESC
  The easy & flexible way to use interactive maps in Flutter.
                       DESC
  s.homepage         = 'https://github.com/salkuadrat/universe'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Salman S' => 'salkuadrat@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
