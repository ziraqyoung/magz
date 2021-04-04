import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['flash']

  remove(event) {
    event.preventDefault();
    this.flashTarget.remove()
  }
}
