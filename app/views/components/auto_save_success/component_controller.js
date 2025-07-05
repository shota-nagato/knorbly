import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.hideMessage()
    }, 3000)
  }

  hideMessage() {
    this.element.classList.add("opacity-0", "transition-opacity", "duration-300")

    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
