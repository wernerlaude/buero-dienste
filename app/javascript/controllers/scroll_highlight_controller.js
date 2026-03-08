import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroll-highlight"
// Auf dem page-Wrapper einbinden: <div class="page" data-controller="scroll-highlight">
export default class extends Controller {
    connect() {
        this.handleClick = this.onClick.bind(this)
        this.element.addEventListener("click", this.handleClick)
    }

    disconnect() {
        this.element.removeEventListener("click", this.handleClick)
    }

    onClick(event) {
        const link = event.target.closest('a[href^="#"]')
        if (!link) return

        const id = link.getAttribute("href").replace("#", "")
        if (!id) return

        const card = document.getElementById(id)
        if (!card) return

        event.preventDefault()

        // Alle aktiven Cards deaktivieren
        document.querySelectorAll(".partner-card--active")
            .forEach(c => c.classList.remove("partner-card--active"))

        // Card highlighten
        card.classList.add("partner-card--active")
        card.scrollIntoView({ behavior: "smooth", block: "center" })

        // Highlight nach 3 Sekunden entfernen
        setTimeout(() => {
            card.classList.remove("partner-card--active")
        }, 8000)
    }
}