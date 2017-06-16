Pod::Spec.new do |s|
  s.name = 'TBVTableViewAdapter'
  s.version = '0.1.0'
  s.summary = 'TBVTableViewAdapter.'
  s.homepage = 'https://github.com/tobevoid/TBVTableViewAdapter'
  s.documentation_url = 'https://github.com/tobevoid/TBVTableViewAdapter'

  s.license =  { :type => 'MIT' }
  s.authors = 'tripleCC'
  s.source = {
    :git => 'https://github.com/tobevoid/TBVTableViewAdapter.git',
    :tag => s.version.to_s,
  }

  s.source_files = 'TBVTableViewAdapter/Classes/**/*'

  s.ios.deployment_target     = "8.0"

end
