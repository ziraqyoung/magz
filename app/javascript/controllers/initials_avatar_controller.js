import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["avatar", "initials"];

  static values = {
    name: String,
  };

  connect() {
    this.avatarTarget.setAttribute( "style", `background-color: ${this.colors[this.colorIndex]}`);
    this.initialsTarget.innerText = this.initials
  }

  // private
  get avatarElement() {
    return this.avatarTarget;
  }

  get initials() {
    return this.nameValue
        .split(" ")[0]
        .charAt(0)
        .toUpperCase() +
      this.nameValue
        .split(" ")[1]
        .charAt(0)
        .toUpperCase()
  }

  get colorIndex() {
    var charIndex = this.initials.charCodeAt(0) - 65;
    return charIndex % 19;
  }

  get colors() {
    return [
      "#1abc9c",
      "#2ecc71",
      "#3498db",
      "#9b59b6",
      "#34495e",
      "#16a085",
      "#27ae60",
      "#2980b9",
      "#8e44ad",
      "#2c3e50",
      "#f1c40f",
      "#e67e22",
      "#e74c3c",
      "#95a5a6",
      "#f39c12",
      "#d35400",
      "#c0392b",
      "#bdc3c7",
      "#7f8c8d",
    ];
  }
}
