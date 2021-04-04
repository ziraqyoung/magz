import { Controller } from 'stimulus';
import { tabbable } from "tabbable"

export default class extends Controller {
  static targets = [ "dialog", "link" ]

  initialize() {
    this.ensureLabel()
    this.dialogElement.setAttribute("role", "dialog")
    this.dialogElement.setAttribute("aria-modal", "true")
    this.dialogElement.setAttribute("aria-hidden", true)
    this.linkTargets.forEach(target => target.hidden = true)
  }

  connect() {
    console.log('running')
  }

  // Actions

  async toggleDialog() {
    if (this.element.open) {
      await this.loadFrames()
      this.showModal()
    } else {
      this.close()
    }
  }

  close() {
    this.element.open = false
    this.dialogElement.setAttribute("aria-hidden", true)
  }

  closeOnEscape(event) {
    if (event.key == "Escape") {
      event.stopPropagation()

      this.close()
      this.summaryElement?.focus()
    }
  }

  closeOnClickOutside({ target }) {
    if (this.element.contains(target)) return

    this.close()
  }

  // Private

  showModal() {
    this.element.open = true
    this.dialogElement.removeAttribute("aria-hidden")
    if (!this.dialogElement.contains(document.activeElement)) {
      const [ firstFocusableElement ] = tabbable(this.dialogElement)

      firstFocusableElement?.focus()
    }
  }

  loadFrames() {
    this.linkTargets.forEach(target => target.click())

    return Promise.all(this.frameElements.map(frame => frame.loaded))
  }

  ensureLabel() {
    if (this.dialogElement.hasAttribute("aria-label") || this.dialogElement.hasAttribute("aria-labelledby")) return

    const linkTexts = this.linkTargets.map(target => target.textContent)

    this.dialogElement.setAttribute("aria-label", linkTexts.join(" "))
  }

  get summaryElement() {
    return this.element.querySelector("summary:not([hidden])")
  }

  get dialogElement() {
    return this.hasDialogTarget ? this.dialogTarget : this.element
  }

  get frameElements() {
    return [ ...this.element.querySelectorAll("turbo-frame[src]:not([disabled])") ]
  }
}
