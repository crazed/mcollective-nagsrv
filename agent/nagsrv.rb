require 'nagios/status'

module Nagios
  class Status
    def find_services_with_state(state)
      services = []
      searchquery = [ search_term('current_state', state.to_s) ]

      action = '${host}:${service}'
      find_with_properties(searchquery).each do |service|
        service_description = service['service_description']
        host_name = service['host_name']
        services << parse_command_template(action, host_name, service_description, service_description)
      end

      services.uniq.sort
    end
  end
end

module MCollective
  module Agent
    class Nagsrv<RPC::Agent
      action
      metadata  :name        => 'Nagsrv Agent',
                :description => 'An agent that will manipulate nagios using the ruby-nagios library',
                :author      => 'crazed',
                :version     => '0.1',
                :timeout     => 120

      def nagios
        return @nagios if @nagios
        @nagios = Nagios::Status.new
        @nagios.parsestatus(nagios_status_log)
        @nagios
      end

      def nagios_status_log
        config.pluginconf['nagsrv.status_log'] || '/var/log/nagios/status.log'
      end

      def critical_services
        nagios.find_services_with_state(2)
      end

      def warning_services
        nagios.find_services_with_state(1)
      end

      def ok_services
        nagios.find_services_with_state(0)
      end

      action 'stats' do
        services = {
          :ok       => ok_services,
          :warning  => warning_services,
          :critical => critical_services,
        }
        aggregate = {
          :services_ok       => services[:ok].size,
          :services_warning  => services[:warning].size,
          :services_critical => services[:critical].size,
        }
        reply[:stats] = {
          :services  => services,
          :aggregate => aggregate,
        }
      end

    end
  end
end
