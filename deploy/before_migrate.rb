Chef::Log.info "bundling gems: #{latest_release}"
chef_run("cd #{latest_release} && sudo -u #{user} gem bundle")

Chef::Log.info "updating crontab: #{latest_release}"
chef_run("cd #{latest_release} && sudo -u #{user} ./bin/whenever --update-crontab hectic")
