metadata    :name        => "nagsrv",
            :description => "Manipulate nagios servers using the ruby-nagios library",
            :author      => "crazed",
            :version     => "0.1",
            :license     => 'Apache 2.0',
            :url         => 'github.com/crazed/mcollective-nagsrv',
            :timeout     => 120

[ "enable-notify", "disable-notify", "acknowledge", "unacknowledge" ].each do |act|
  action act, :description => "Run an external command in nagios to #{act} a service" do

    user_optional = true

    if act == "acknowledge"
      user_optional = false
      input :ackreason,
          :prompt      => "reason for acknowledging",
          :description => "the reason for an acknowledgement",
          :type        => :string,
          :validation  => '^.+$',
          :optional    => false,
    end

    input :user,
        :prompt      => "user performing the action",
        :description => "user performing the action",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => user_optional,

    input :acknowledged,
        :prompt      => "limit to acknowledged services",
        :description => "list only services that have been acknowledged",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,

    input :action,
        :prompt      => "template for ruby-nagios",
        :description => "template that can contain ${host}, ${tstamp}, and ${service}",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,

    input :forhost,
        :prompt      => "limit to matching hosts",
        :description => "a regex or full hostname that limits results",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,

    input :listhosts,
        :prompt      => "show hostnames",
        :description => "show hostnames as the result rather than services (default)",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,

    input :listservices,
        :prompt      => "show service descriptions",
        :description => "show services descriptions rather than host names",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,

    input :notifyenable,
        :prompt      => "notification enabled",
        :description => "limit results to services with notifications enabled",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,

    input :withservice,
        :prompt      => "limit to matching services",
        :description => "a regex to match against service descriptions",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => true,
  end
end

action "info", :description => "return basic info about services" do
  output :info,
         :description => "Info gathered from nagios",
         :display_as => "Info"
end
