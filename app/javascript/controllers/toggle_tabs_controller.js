// ===========================================
// Toggle Tabs Controller
// Mit URL-Hash Support für Deep-Linking
// ===========================================

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tab", "panel"]
    static values = {
        active: { type: String, default: "" }
    }

    connect() {
        // Prüfe URL-Hash zuerst (z.B. /#bundesland)
        const hash = window.location.hash.replace("#", "")

        if (hash && this.hasPanel(hash)) {
            this.activeValue = hash
        } else if (!this.activeValue && this.tabTargets.length > 0) {
            // Fallback: ersten Tab aktivieren
            this.activeValue = this.tabTargets[0].dataset.tabId
        }

        this.showActivePanel()

        // Auf Hash-Änderungen reagieren (z.B. Browser Back/Forward)
        window.addEventListener("hashchange", this.handleHashChange.bind(this))
    }

    disconnect() {
        window.removeEventListener("hashchange", this.handleHashChange.bind(this))
    }

    handleHashChange() {
        const hash = window.location.hash.replace("#", "")
        if (hash && this.hasPanel(hash)) {
            this.activeValue = hash
        }
    }

    hasPanel(id) {
        return this.panelTargets.some(panel => panel.dataset.panelId === id)
    }

    switch(event) {
        event.preventDefault()
        const tabId = event.currentTarget.dataset.tabId

        if (tabId) {
            this.activeValue = tabId
            // URL-Hash aktualisieren (ohne Scroll)
            history.replaceState(null, null, `#${tabId}`)
        }
    }

    activeValueChanged() {
        this.updateTabs()
        this.showActivePanel()
    }

    updateTabs() {
        this.tabTargets.forEach(tab => {
            if (tab.dataset.tabId === this.activeValue) {
                tab.classList.add("active")
            } else {
                tab.classList.remove("active")
            }
        })
    }

    showActivePanel() {
        this.panelTargets.forEach(panel => {
            if (panel.dataset.panelId === this.activeValue) {
                panel.classList.remove("is-hidden")
                panel.hidden = false
            } else {
                panel.classList.add("is-hidden")
                panel.hidden = true
            }
        })
    }
}