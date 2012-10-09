class MCollective::Application::Nagsrv<MCollective::Application
  description 'Nagios manipulation using the ruby-nagios library'
  usage 'nagsrv [stats]'

  def post_option_parser(configuration)
    if ARGV.size == 1
      configuration[:command] = ARGV.shift
    end
  end

  def validate_configuration(configuration)
    raise "Command should be stats" unless configuration[:command] =~ /^stats$/
  end

  def main
    nagsrv = rpcclient('nagsrv')
    nagsrv.send(configuration[:command]).each do |node|
      if node[:data][:stats] && node[:data][:stats][:aggregate]
        printf("%-40s %s\n", node[:sender], node[:statusmsg])
        node[:data][:stats][:aggregate].each do |stat, value|
          puts "\t\t#{stat} => #{value}"
        end
      end
    end
  end
end
