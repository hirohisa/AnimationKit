Pod::Spec.new do |s|

  s.name         = "AnimationKit"
  s.version      = "0.0.2"
  s.summary      = "AnimationKit is a lightweight and easy animation framework."
  s.description  = <<-DESC
AnimationKit is a lightweight and easy animation framework. It provides you that implements a chain of operations with closure and duration like stream of Animation.
DESC

  s.homepage     = "https://github.com/hirohisa/AnimationKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "Hirohisa Kawasaki" => "hirohisa.kawasaki@gmail.com" }

  s.source       = { :git => "https://github.com/hirohisa/AnimationKit.git", :tag => s.version }

  s.source_files = "AnimationKit/*.swift"
  s.requires_arc = true
  s.ios.deployment_target = '8.0'

end
