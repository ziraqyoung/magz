import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["item", "link", "input"];
  static values = { lockOnSelection: Boolean };

  initialize() {
    if (this.hasLinkTarget) this.linkTarget.hidden = true;
  }

  connect() {
    this.summaryElement?.setAttribute("aria-haspopup", "menu");
    this.update();
  }

  disconnect() {
    this.close();
  }

  // Actions

  async update() {
    if (!this.element.open) {
      return;
    }

    if (this.hasLinkTarget) {
      this.linkTarget.click();
    }

    if (this.frameElement) {
      if (this.frameElement.disabled) {
        this.close();
        return;
      }

      await this.frameElement.loaded;
    }

    await Promise.all(this.frameElements.map((frame) => frame.loaded));

    this.summaryElement?.setAttribute("aria-expanded", this.element.open);
  }

  closeOnClickOutside({ target }) {
    if (this.element.contains(target)) return;
    if (this.forceMenuOpen) return;

    this.close();
  }

  closeOnFocusOutside({ target }) {
    if (!this.element.open) return;
    if (this.element.contains(target)) return;
    if (target.matches("main")) return;
    if (this.forceMenuOpen) return;

    this.close();
  }

  closeAndRestoreFocus() {
    this.close();
    this.summaryElement.focus();
  }

  toggleSummaryTabstop() {
    const summary = this.element.querySelector("summary");

    this.element.open
      ? summary?.setAttribute("tabindex", -1)
      : summary?.removeAttribute("tabindex");
  }

  displayMenu() {
    this.element.open = true;
  }

  close() {
    this.element.open = false;
  }

  // Private
  //


  getItemInDirection(direction) {
    const index = this.items.indexOf(document.activeElement) + direction;

    return wrapAroundAccess(this.items, index);
  }

  get forceMenuOpen() {
    return (
      this.lockOnSelectionValue &&
      (this.element.querySelector(":checked") ||
        this.element.contains(document.activeElement))
    );
  }

  get items() {
    return this.itemTargets.filter(isVisible);
  }

  get hasItems() {
    return this.itemTargets.some(isVisible);
  }

  get activeItem() {
    return this.itemTargets.find(isActive);
  }

  get initialItem() {
    return this.items[0];
  }

  get summaryElement() {
    return this.element.querySelector("summary");
  }

  get frameElement() {
    const id =
      this.hasLinkTarget && this.linkTarget.getAttribute("data-turbo-frame");
    return id && document.getElementById(id);
  }

  get frameElements() {
    return [
      ...this.element.querySelectorAll("turbo-frame[src]:not([disabled])"),
    ];
  }
}

function cancel(event) {
  event.stopPropagation();
  event.preventDefault();
}

function isInput(element) {
  return element.tagName == "INPUT";
}

function isActive(element) {
  return element == document.activeElement;
}

function isVisible(element) {
  return element.offsetParent != null;
}

