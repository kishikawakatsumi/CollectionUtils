require 'xcjobs'

def destinations
  [ 'name=iPhone 4s,OS=8.1', 'name=iPhone 5s,OS=8.1', 'name=iPhone 6,OS=8.1' ]
end

XCJobs::Build.new('build:iphonesimulator') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-iOS'
  t.sdk = 'iphonesimulator'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
end

XCJobs::Build.new('build:iphoneos') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-iOS'
  t.sdk = 'iphoneos'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
end

XCJobs::Build.new('build:watchsimulator') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-watchOS'
  t.sdk = 'watchsimulator'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
end

XCJobs::Build.new('build:watchos') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-watchOS'
  t.sdk = 'watchos'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
end

XCJobs::Build.new('build:macosx') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-Mac'
  t.sdk = 'macosx'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
end

XCJobs::Test.new('test:ios') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-iOS'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.coverage = true
  destinations.each do |destination|
    t.add_destination(destination)
  end
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
  t.add_build_setting('GCC_SYMBOLS_PRIVATE_EXTERN', 'NO')
end

XCJobs::Test.new('test:osx') do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils-Mac'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.coverage = true
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
  t.add_build_setting('GCC_SYMBOLS_PRIVATE_EXTERN', 'NO')
end

XCJobs::Coverage::Coveralls.new() do |t|
  t.repo_token = 'FmNhcD5DH1DAEv0BK4FNSfV0rYCAEYFF8'
  t.add_extension('.m')
end
