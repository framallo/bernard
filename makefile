# This is the deployment recipe
# You require to install runit on the server.
# First you need to declare on which port the application will run
#
# echo 3000 > port
#
# Then you can setup a new runit service with
# 
# 	make setup_service
#
# Also you need to install the git hooks, so you can push and update this repo
# 
# 	make setup_git_hook
#
# Every time you push it will run 
#
# 	make deploy
#
# Later you can test the application
#
# 	make service_run
#
# Last you can restart the application
#
# 	make restart
#
SHELL=/usr/local/rvm/bin/rvm-shell

## service
service_name = $(shell basename $(realpath .) )
app_dir      = $(realpath .)
service_dir  = $(HOME)/service/$(service_name)
run          = $(service_dir)/run
log_dir      = $(service_dir)/log
log          = $(log_dir)/run
port         = $(shell cat port)

setup_run:
	mkdir -p $(service_dir)
	echo  "#!/bin/bash"                                    > $(run)
	echo "cd $(app_dir)"                                  >> $(run)
	echo "export HOME=$$(HOME)"                           >> $(run)
	echo "exec chpst -u $(shell whoami) make service_run" >> $(run)
	chmod +x $(run)

setup_log:
	mkdir -p $(log_dir)
	echo  "#!/bin/bash" > $(log)
	echo  "exec chpst -u $(shell whoami) svlogd -tt $(app_dir)/log/" >> $(log)
	chmod +x $(log)

setup_service: setup_run setup_log
	@echo ""
	@echo "    You created a new runit service that will keep the application runinnig after a reboot"
	@echo "    also it will create a log on log folder"
	@echo "    just, one last step: run as sudo"
	@echo "    cp -r  $(service_dir) /etc/service/"
	@echo "    chown $(shell whoami) /etc/service/$(service_name)/supervise/ "
	@echo "    chown $(shell whoami) /etc/service/$(service_name)/supervise/ok "
	@echo "    chown $(shell whoami) /etc/service/$(service_name)/supervise/control "
	@echo "    chown $(shell whoami) /etc/service/$(service_name)/supervise/status"
	@echo ""

service_run:

## git hook
hook           = .git/hooks/post-receive

setup_git_hook:
	echo 'unset GIT_DIR'
	echo 'cd .. && GIT_DIR=$$(pwd) && make git_hook deploy' > $(hook)
	chmod +x $(hook)

git_hook:
	env -i git reset --hard  
	env -i git submodule init
	env -i git submodule update

## rails
export RAILS_ENV  = $(shell git branch | grep '*' | awk '{print $$(2)}' )

bundle_install:
	bundle install --without=development --without=test --deployment

migrate:
	bundle exec rake db:migrate

precompile:
	bundle exec rake assets:clean assets:precompile

all: deploy

deploy: bundle_install migrate precompile restart

# application specific

service_run:
	mkdir -p tmp/pids tmp/logs
	exec bundle exec puma -e $(RAILS_ENV) -b unix://$(app_dir)/tmp/puma.sock

restart:
	sv restart $(service_name)


