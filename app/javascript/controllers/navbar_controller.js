import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    this.menuTarget.classList.toggle("navbar__nav--open")
  }

  // Menü schließen bei Klick außerhalb
  close(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.remove("navbar__nav--open")
    }
  }

  connect() {
    this.closeHandler = this.close.bind(this)
    document.addEventListener("click", this.closeHandler)
  }

  disconnect() {
    document.removeEventListener("click", this.closeHandler)
  }
}