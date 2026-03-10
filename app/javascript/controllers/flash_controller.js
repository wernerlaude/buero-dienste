// flash_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        setTimeout(() => {
            this.element.classList.add("flash--fade-out")
            setTimeout(() => this.element.remove(), 500)
        }, 4000)
    }
}