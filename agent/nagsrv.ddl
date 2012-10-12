metadata    :name        => "nagsrv",
            :description => "Manipulate nagios servers using the ruby-nagios library",
            :author      => "crazed",
            :version     => "0.1",
            :license     => 'Apache 2.0',
            :url         => 'github.com/crazed/mcollective-nagsrv',
            :timeout     => 120

action "stats", :description => "return basic stats about services and hosts" do
  output :stats,
         :description => "Stats gathered from nagios",
         :display_as => "Stats"
end

