# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Share any additional folders to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.define "sl-tycho" do |cci|
    #See http://docs.vagrantup.com/v2/vagrantfile/index.html
    cci.vm.box                        = "ju2wheels/SL_UBUNTU_LATEST_64"
    cci.vm.hostname                   = "sl-tycho"

    cci.vm.usable_port_range          = 2200..3050

    #See http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html
    cci.ssh.forward_agent             = true
    cci.ssh.forward_x11               = false
    cci.ssh.private_key_path          = [ File.expand_path("~/.vagrant.d/insecure_private_key") ]

    #cci.ssh.username                  = "vagrant"

    #See http://docs.vagrantup.com/v2/networking/index.html
    cci.vm.network :forwarded_port, guest: 3030, guest_ip: nil, host: 3030, host_ip: nil, protocol: "tcp", auto_correct: true

    #See http://docs.vagrantup.com/v2/synced-folders/basic_usage.html

    cci.vm.provider :softlayer do |sl, cci_override|
      #Override the default setting only if using this provider
      cci_override.vm.box       = "ju2wheels/SL_UBUNTU_LATEST_64"
      cci_override.ssh.username = "root"

      sl.api_key                   = ENV["SL_API_KEY"]
      sl.datacenter                = 'dal05'
      #sl.dedicated                 = false
      #sl.disk_capacity             = { 0 => 25 }
      sl.domain                    = ENV["SL_DOMAIN"]
      #sl.endpoint_url              = SoftLayer::API_PUBLIC_ENDPOINT
      #sl.force_private_ip          = false
      sl.hostname                  = cci.vm.hostname
      #sl.hourly_billing            = true
      sl.local_disk                = true
      #sl.manage_dns                = false
      #sl.max_memory                = 1024
      #sl.network_speed             = 10
      #sl.post_install              = nil #URL for post install script
      #sl.private_only              = false
      sl.ssh_keys                  = [ "SL-root-pk" ]
      #sl.start_cpus                = 1
      #sl.user_data                 = nil
      sl.username                  = ENV["SL_API_USERNAME"] || ENV['USER'] || ENV['USERNAME']   
      #sl.vlan_private              = nil
      #sl.vlan_public               = nil

   end if Vagrant.has_plugin?("SoftLayer")
  end

  config.omnibus.chef_version = :latest

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding
  # some recipes and/or roles.
  #
  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "./cookbooks"
    chef.roles_path = "./roles"
    chef.environments_path = "./environments"
    chef.add_recipe "apt"
    chef.add_recipe "add-vagrantuser"
    chef.add_recipe "ubuntu-tightvnc"
    chef.add_recipe "ubuntu-xfce4"
    chef.add_recipe "chef-chrome"
    chef.add_recipe "xrdp"
    chef.add_role "eclipse-developer"
    
    # apt update needs to occur first not just eventually    
    chef.json = { "apt" => {"compile_time_update" => true} }
  end
end
