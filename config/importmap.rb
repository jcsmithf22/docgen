# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "flowbite", to: "https://cdnjs.cloudflare.com/ajax/libs/flowbite/2.2.1/flowbite.turbo.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "stimulus-dropdown" # @2.1.0
pin "hotkeys-js" # @3.13.5
pin "stimulus-use" # @0.51.3
