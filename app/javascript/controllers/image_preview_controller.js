import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
    static targets = ["input", "preview", "placeholder"]

    preview() {
        const file = this.inputTarget.files[0]
        if (!file) return

        // Dateigröße prüfen (max 5 MB)
        if (file.size > 5 * 1024 * 1024) {
            alert("Die Datei ist zu groß. Maximal 5 MB erlaubt.")
            this.inputTarget.value = ""
            return
        }

        const reader = new FileReader()
        reader.onload = (e) => {
            this.previewTarget.src = e.target.result
            this.previewTarget.classList.remove("hidden")
            if (this.hasPlaceholderTarget) {
                this.placeholderTarget.classList.add("hidden")
            }
        }
        reader.readAsDataURL(file)
    }
}