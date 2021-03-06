require 'mkmf'

dir_config('curl')

if find_executable('curl-config')
  $CFLAGS << " #{`curl-config --cflags`.strip}"
  $LIBS << " #{`curl-config --libs`.strip}"
elsif !have_library('curl') or !have_header('curl/curl.h')
  fail <<-EOM
  Can't find libcurl or curl/curl.h

  Try passing --with-curl-dir or --with-curl-lib and --with-curl-include
  options to extconf.
  EOM
end

#install_rb("curb.rb", "$(RUBYLIBDIR)", '../lib')
#install_rb("curl.rb", "$(RUBYLIBDIR)", '../lib')
$INSTALLFILES = [["curb.rb", "$(RUBYLIBDIR)", "../ext"], ["curl.rb", "$(RUBYLIBDIR)", "../ext"]]

if try_compile('int main() { return 0; }','-Wall')
  $CFLAGS << ' -Wall'
end

create_makefile('curb_core')
