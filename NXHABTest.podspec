

Pod::Spec.new do |s|

  s.name                 = 'NXHABTest'
  s.version              = '0.0.1'
  s.summary              = 'try pod'
  s.homepage             = 'https://github.com/niuxinghua'
  s.license              = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'niuxinghua' => '970626879@qq.com' }
  s.platform             = :ios, '7.0'
  s.source               = { :git => 'https://github.com/niuxinghua/UserCenter.git', :tag => s.version }
  s.resource = 'backIcon.bundle'

 s.source_files = 'wechatfile/**/*.{h,m,mm}'

  s.static_framework = true

  s.dependency 'WechatOpenSDK'

 s.vendored_frameworks = 'UserCenter.framework'

end
