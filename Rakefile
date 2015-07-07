require 'xcjobs'

def destinations
  [ 'name=iPhone 4s,OS=8.3', 'name=iPhone 5s,OS=8.3', 'name=iPhone 6,OS=8.3' ]
end

XCJobs::Build.new do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'CollectionUtils'
  t.configuration = 'Release'
  t.build_dir = 'build'
  t.formatter = 'xcpretty -c'
  t.add_build_setting('CODE_SIGN_IDENTITY', '')
  t.add_build_setting('CODE_SIGNING_REQUIRED', 'NO')
  t.add_build_setting('GCC_SYMBOLS_PRIVATE_EXTERN', 'NO')
end

XCJobs::Test.new do |t|
  t.workspace = 'CollectionUtils'
  t.scheme = 'libCollectionUtils'
  t.configuration = 'Release'
  t.build_dir = 'build'
  destinations.each do |destination|
    t.add_destination(destination)
  end
  t.coverage = true
  t.formatter = 'xcpretty -c'
end

XCJobs::Coverage::Coveralls.new() do |t|
  t.add_extension('.m')
end
