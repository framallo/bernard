# https://stackoverflow.com/questions/24030907/spork-0-9-2-and-rspec-3-0-0-uninitialized-constant-rspeccorecommandline-n/24085168#24085168
# https://github.com/manafire/spork/commit/38c79dcedb246daacbadb9f18d09f50cc837de51#diff-937afaa19ccfee172d722a05112a7c6fL6
 
 class Spork::TestFramework::RSpec
   def run_tests(argv, stderr, stdout)
     if rspec1?
       ::Spec::Runner::CommandLine.run(
         ::Spec::Runner::OptionParser.parse(argv, stderr, stdout)
       )
    elsif rspec3?
      options = ::RSpec::Core::ConfigurationOptions.new(argv)
      ::RSpec::Core::Runner.new(options).run(stderr, stdout)
     else
       ::RSpec::Core::CommandLine.new(argv).run(stderr, stdout)
     end
   end
 
  def rspec3?
    return false if !defined?(::RSpec::Core::Version::STRING)
    ::RSpec::Core::Version::STRING =~ /^3\./
  end
end
