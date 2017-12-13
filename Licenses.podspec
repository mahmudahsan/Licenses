Pod::Spec.new do |s|
  s.name         = "Licenses"
  s.version      = "2.0"
  s.summary      = "To showcase 3rd party libraries and their licenses"
  s.description  = <<-DESC
      Quick way to showcase 3rd party libraries and their licenses those are used to develop app.
                   DESC

  s.homepage     = "https://github.com/mahmudahsan/Licenses"
  s.screenshots  = "https://github.com/mahmudahsan/Licenses/raw/master/preview.gif"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Mahmud Ahsan" => "mahmud@thinkdiff.net" }
  s.social_media_url   = "http://twitter.com/mahmudahsan"
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/mahmudahsan/Licenses.git", :tag => s.version.to_s }
  s.source_files = "Licenses/Sources/**/*.{swift}"
  s.resources    = ['Licenses/Sources/**/*.{storyboard}']
  s.frameworks   = "Foundation"
end
