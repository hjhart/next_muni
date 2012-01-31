Get the "database" set up

	cp buses.template.yml buses.yml

Get this puppy up and running

	source .rvmrc
	gem install bundler --pre
	bundle
	shotgun app.rb