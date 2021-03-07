import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["floatDirection", "colorIdentifier"]

  static values = {
    owner: Number
  }

  connect() {
    if (this.idForMeta !== false) {
      if (this.ownerValue === this.idForMeta) {
        this.floatDirectionTarget.classList.add('float-right')
        this.colorIdentifierTarget.classList.add('bg-gradient-to-br', 'from-gray-900', 'via-cyan-800', 'to-gray-500')
      } else {
        this.floatDirectionTarget.classList.add('float-left', 'flex-row-reverse')
        this.colorIdentifierTarget.classList.add('bg-gradient-to-br', 'from-gray-500', 'via-black', 'to-gray-900')
      }
    }
  }

  // private
  get idForMeta() {
    let metaElement = document.getElementsByTagName("meta")["current-person-id"]
    let id = metaElement.getAttribute("content")

    if (id !== null) {
      return parseInt(id)
    } else {
      return false
    }
  }
}

