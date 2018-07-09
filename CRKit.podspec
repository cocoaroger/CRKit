Pod::Spec.new do |s|
  s.name         = 'CRKit'
  s.summary      = '常用工具及视图'
  s.version      = '0.1.6'
  s.homepage     = 'https://github.com/cocoaroger/CRKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'roger wu' => 'cocoaroger@163.com' }
  s.social_media_url   = 'http://www.jianshu.com/users/0491c59e8017'
  s.requires_arc = true
  s.platform     = :ios, '8.0'
  s.source       = { :git => 'https://github.com/cocoaroger/CRKit.git', :tag => s.version.to_s }

  s.source_files  = 'Classes/**/*.{h,m}'
  s.public_header_files = 'Classes/**/*.{h}'
end