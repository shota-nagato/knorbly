import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["slideOver", "element"]
  static values = { add: String, remove: String, animate: Boolean }

  connect() {
    console.log("connect")
    this.slideOverTarget.classList.add("translate-x-full")
    setTimeout(() => {
      this.slideOverTarget.classList.remove("translate-x-full");
      this.slideOverTarget.classList.add(
        "transform",
        "transition",
        "ease-in-out",
        "duration-300",
        "sm:duration-700",
        "translate-x-0"
      );
    }, 100);
  }

  slideOut(e) {
    this.remove(e)
    this.slideOverTarget.classList.remove("translate-x-0");
    this.slideOverTarget.classList.add(
      "transform",
      "transition",
      "ease-in-out",
      "duration-300",
      "sm:duration-700",
      "translate-x-full"
    )
  }

  remove(e) {
    e.preventDefault();
    if (this.hasAnimateValue && this.animateValue) {
      this.elementTargets.forEach((element) => {
        if (this.hasRemoveValue) {
          this.removeValue.split(" ").forEach((klass) => {
            element.classList.remove(klass)
          });
        } else {
          element.classList.remove("animate-fade-in")
        }
        if (this.hasAddValue) {
          this.addValue.split(" ").forEach((klass) => {
            element.classList.add(klass);
          });
        } else {
          element.classList.add("animate-fade-out")
        }
      });
    }
    this.elementTargets.forEach((element) => {
      setTimeout(() => element.remove(), 500)
    });
  }
}
