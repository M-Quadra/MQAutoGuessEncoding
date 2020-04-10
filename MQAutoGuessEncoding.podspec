Pod::Spec.new do |spec|
  spec.name         = "MQAutoGuessEncoding"
  spec.version      = "0.0.1"
  spec.summary      = "字符集编码检测"
  spec.ios.deployment_target = '9.0'

  spec.homepage     = "https://github.com/M-Quadra/MQAutoGuessEncoding"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author             = { "root@virtual.com" => "root@virtual.com" }
  spec.source       = { :git => "https://github.com/M-Quadra/MQAutoGuessEncoding.git", :tag => spec.version.to_s }

  spec.source_files  = 'Demo/MQAutoGuessEncoding/Data+MQAutoGuessEncoding.swift', 'Demo/MQAutoGuessEncoding/Uint4xUint4/Uint4xuint4.swift', 'Demo/MQAutoGuessEncoding/Uint4xUint4/**/*.{mlmodel}'
  spec.resources = ['Demo/MQAutoGuessEncoding/Uint4xUint4/**/*.{mlmodel}']
  
  spec.frameworks = 'UIKit', 'Foundation'
end