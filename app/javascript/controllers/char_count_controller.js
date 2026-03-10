import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-count"
export default class extends Controller {
    static targets = ["counter"]
    static values = {
        max: { type: Number, default: 2000 }
    }

    connect() {
        this.editor = this.element.querySelector("lexxy-editor")

        if (this.editor) {
            this.editor.addEventListener("lexxy:change", this.update.bind(this))
        }

        this.update()
    }

    disconnect() {
        if (this.editor) {
            this.editor.removeEventListener("lexxy:change", this.update.bind(this))
        }
    }

    update() {
        const content = this.editor?.querySelector("[contenteditable]")
        if (!content) return

        const text = content.textContent || ""
        const count = text.length

        if (this.hasCounterTarget) {
            this.counterTarget.textContent = `${count} / ${this.maxValue} Zeichen`

            if (count > this.maxValue) {
                this.counterTarget.style.color = "var(--color-danger)"
            } else if (count > this.maxValue * 0.8) {
                this.counterTarget.style.color = "var(--color-accent-dark)"
            } else {
                this.counterTarget.style.color = "var(--color-text-muted)"
            }
        }
    }
}