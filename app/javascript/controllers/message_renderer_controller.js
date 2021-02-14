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
        this.colorIdentifierTarget.classList.add('bg-fuchsia-800')
      } else {
        this.floatDirectionTarget.classList.add('float-left', 'flex-row-reverse')
        this.colorIdentifierTarget.classList.add('bg-gray-800')
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

