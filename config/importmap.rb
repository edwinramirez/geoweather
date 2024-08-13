# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.5
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.5
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.2.0
