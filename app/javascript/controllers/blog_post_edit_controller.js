// app/assets/javascripts/controllers/blog_post_edit_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "titleField",
        "teaserField", "teaserCount",
        "contentField", "contentWordCount", "contentCharCount", "readingTime", "readingTimeField",
        "metaField", "metaCount"
    ]

    connect() {
        // Initialize counters on page load
        this.updateTeaserCount()
        this.updateContentWordCount()
        this.updateMetaCount()
    }

    updateTeaserCount() {
        if (this.hasTeaserFieldTarget && this.hasTeaserCountTarget) {
            const text = this.teaserFieldTarget.value || ''
            this.teaserCountTarget.textContent = text.length

            if (text.length > 400) {
                this.teaserCountTarget.style.color = '#ef4444'
            } else if (text.length > 350) {
                this.teaserCountTarget.style.color = '#f59e0b'
            } else {
                this.teaserCountTarget.style.color = '#10b981'
            }
        }
    }

    updateContentWordCount() {
        if (!this.hasContentFieldTarget) return

        const text = this.contentFieldTarget.value || ''
        const words = text.split(/\s+/).filter(word => word.length > 0)
        const wordCount = words.length
        const charCount = text.length
        const readingTimeMinutes = Math.ceil(wordCount / 200)

        // Zeichenanzahl
        if (this.hasContentCharCountTarget) {
            this.contentCharCountTarget.textContent = charCount.toLocaleString('de-DE')

            if (charCount > 20000) {
                this.contentCharCountTarget.style.color = 'var(--color-danger)'
            } else if (charCount > 10000) {
                this.contentCharCountTarget.style.color = 'var(--color-accent-dark)'
            } else {
                this.contentCharCountTarget.style.color = 'var(--color-text-muted)'
            }
        }

        // Wörteranzahl
        if (this.hasContentWordCountTarget) {
            this.contentWordCountTarget.textContent = wordCount

            if (wordCount >= 300) {
                this.contentWordCountTarget.style.color = '#10b981'
            } else if (wordCount >= 100) {
                this.contentWordCountTarget.style.color = '#f59e0b'
            } else {
                this.contentWordCountTarget.style.color = '#6b7280'
            }
        }

        // Lesezeit (Anzeige im Hint)
        if (this.hasReadingTimeTarget) {
            this.readingTimeTarget.textContent = wordCount === 0 ? '0' : readingTimeMinutes

            if (readingTimeMinutes >= 3) {
                this.readingTimeTarget.style.color = '#10b981'
            } else if (readingTimeMinutes >= 1) {
                this.readingTimeTarget.style.color = '#f59e0b'
            } else {
                this.readingTimeTarget.style.color = '#6b7280'
            }
        }

        // Lesezeit (Formularfeld)
        if (this.hasReadingTimeFieldTarget) {
            this.readingTimeFieldTarget.value = wordCount === 0 ? 0 : readingTimeMinutes
        }
    }

    updateMetaCount() {
        if (this.hasMetaFieldTarget && this.hasMetaCountTarget) {
            const text = this.metaFieldTarget.value || ''
            this.metaCountTarget.textContent = text.length

            if (text.length > 160) {
                this.metaCountTarget.style.color = '#ef4444'
            } else if (text.length >= 150) {
                this.metaCountTarget.style.color = '#10b981'
            } else if (text.length >= 120) {
                this.metaCountTarget.style.color = '#f59e0b'
            } else {
                this.metaCountTarget.style.color = '#6b7280'
            }
        }
    }

    // Auto-fill meta title from main title if empty
    updateMetaTitle() {
        if (this.hasTitleFieldTarget) {
            const metaTitleField = document.querySelector('#blog_post_meta_title')
            if (metaTitleField && !metaTitleField.value.trim()) {
                const titleValue = this.titleFieldTarget.value.trim()
                if (titleValue && titleValue.length <= 60) {
                    metaTitleField.value = titleValue
                }
            }
        }
    }

    // Validate form before submit
    validateForm(event) {
        const errors = []

        if (this.hasTitleFieldTarget && !this.titleFieldTarget.value.trim()) {
            errors.push('Titel ist erforderlich')
        }

        if (this.hasContentFieldTarget && !this.contentFieldTarget.value.trim()) {
            errors.push('Inhalt ist erforderlich')
        }

        if (this.hasMetaFieldTarget && this.metaFieldTarget.value.length > 160) {
            errors.push('Meta-Beschreibung ist zu lang (max. 160 Zeichen)')
        }

        if (errors.length > 0) {
            event.preventDefault()
            alert('Bitte korrigiere folgende Fehler:\n\n' + errors.join('\n'))
            return false
        }

        return true
    }
}