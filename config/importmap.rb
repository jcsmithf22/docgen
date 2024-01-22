# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-dropdown" # @2.1.0
pin "hotkeys-js" # @3.13.5
pin "stimulus-use" # @0.51.3
pin "stimulus-datepicker" # @1.0.6
