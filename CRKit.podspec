Pod::Spec.new do |s|
  s.name         = 'CRKit'
  s.summary      = '符合自己的项目需求的常用第三方库和控件整合'
  s.version      = '0.0.9'
  s.homepage     = 'https://github.com/cocoaroger/CRKit'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { 'roger wu' => 'cocoaroger@163.com' }
  s.social_media_url   = 'http://www.jianshu.com/users/0491c59e8017'
  s.requires_arc = true
  s.platform     = :ios, '7.1'
  s.source       = { :git => 'https://github.com/cocoaroger/CRKit.git', :tag => s.version.to_s }

  s.source_files  = 'CRKit/Common/CRKit.h'
  s.public_header_files = 'CRKit/Common/CRKit.h'

  s.subspec 'UIComponent' do |u|
    u.source_files = 'CRKit/Common/UIComponent/*.{h,m}'
    u.public_header_files = 'CRKit/Common/UIComponent/*.{h}'
  end

  s.subspec 'Category' do |c|
    c.source_files = 'CRKit/Common/Category/*.{h,m}'
    c.public_header_files = 'CRKit/Common/Category/*.{h}'
  end

  s.subspec 'Macro' do |m|
    m.source_files = 'CRKit/Common/Macro/*.{h,m}'
    m.public_header_files = 'CRKit/Common/Macro/*.{h}'
  end

  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'IQKeyboardManager', '~> 3.3.7'
  s.dependency 'MJExtension', '~> 3.0.11'
  s.dependency 'MJRefresh', '~> 3.1.9'
  s.dependency 'Masonry', '~> 1.0.1'
  s.dependency 'ReactiveCocoa', '~> 2.5'
  s.dependency 'SDWebImage', '~> 3.8.1'
  s.dependency 'YYKit', '~> 1.0.7'
end
