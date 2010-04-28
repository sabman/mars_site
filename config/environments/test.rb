config.cache_classes = true

config.whiny_nils = true

config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_loading            = true

config.action_controller.allow_forgery_protection    = false

config.action_mailer.delivery_method = :test

config.gem "rspec", :lib => false
config.gem "rspec-rails", :lib => false
config.gem "webrat", :lib => false
config.gem "cucumber", :lib => false
config.gem "cucumber-rails", :lib => false
config.gem "pickle", :lib => false 
config.gem "machinist"

#TEST_SCHEMA = "SBURQ"
