// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("turbo:frame-missing", (event) => {
    const {detail: {response, visit}} = event;
    event.preventDefault();
    visit(response.url);
});

// app/javascript/application.js
import * as Lexxy from "lexxy"

Lexxy.configure({
    default: {
        attachments: false
    }
})
