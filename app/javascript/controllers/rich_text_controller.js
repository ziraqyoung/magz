import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["togglerWrapper"]

  initialize() {
    this.togglerWrapperTarget.classList.remove("hidden");
  }

  toggleEditor(event) {
    event.preventDefault()
    this.element.classList.toggle("trix-wrapper")
  }

}
