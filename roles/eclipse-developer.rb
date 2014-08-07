name "eclipse-developer"
description "Role for Eclipse Developers"

run_list(
        "recipe[java]",
        "recipe[git]",
        "recipe[eclipse]",
        "recipe[maven]",
        "recipe[get-gitrepos]"
)

default_attributes(

		"eclipse" =>
        {
			"plugins" =>
            [
             { "http://download.eclipse.org/technology/m2e/releases" => "org.eclipse.m2e.feature.feature.group" },
             { "http://repository.tesla.io:8081/nexus/content/sites/m2e.extras/m2eclipse-egit/0.14.0/N/0.14.0.201406241643" => "org.sonatype.m2e.egit.feature.feature.group" }
            ]
		}
)

override_attributes(
                    
        "java" =>
        {
            "install_flavor" => "oracle",
            "jdk_version" => "7",
            "oracle" => { "accept_oracle_download_terms" => true }
        },

        "eclipse" =>
        {
            "version" => "luna",
            "arch" => "x86_64"
        }
)
