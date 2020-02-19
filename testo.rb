require 'pry-byebug'

Dir.chdir("/Users/michael/projects/firefox-ios/")
cmds = IO.read("/Users/michael/ios-firefox-build").split("\n").select do |line|
  line.include?("fuse-ld=")
end

cmds.each do |cmd|
  out = cmd.match(/ -o (\S+)/)[1]
  expected_ld = "/Library/Developer/CommandLineTools/usr/bin/ld"
  actual_ld = "/Users/michael/Library/Developer/Xcode/DerivedData/ld64-dzjqukslgnudkbewsvkxtjueagwq/Build/Products/Release/ld"
  system(cmd)
  temp = "/tmp/temp_ld_file"
  `cp #{out} #{temp}`
  system(cmd.gsub(expected_ld, actual_ld)) #/-fuse-ld=(\S+)/, )
  if IO.read(out) == IO.read(temp)
    puts "pass"
  else
    puts "fail: #{File.basename(out)}"
    binding.pry
    ""
  end
end
