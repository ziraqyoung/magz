import { Controller } from "stimulus";
import { scrollToElement } from "helpers/scroll_helper";

export default class extends Controller {
  connect() {
    scrollToElement(this.element);
  }
}
