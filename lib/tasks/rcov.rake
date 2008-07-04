#require 'rcov/rcovtask'

#namespace 'rcov' do 
#  Rcov::RcovTask.new do |t| 
#    t.name = "all" 
#    t.libs << "test"
#    t.test_files = FileList['test/**/*test.rb']   
#    t.verbose = true 
#    t.rcov_opts = [
#      '-x', '^config/boot',
#      '-x', '^/Library',
#      '--rails', '--sort',  '--aggregate','coverage']     
#  end 
#end 
#
#task :coverage => "rcov:all"
