import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toast"]

  connect() {
    setTimeout(() => {
      this.hideToast()
    }, 3000)
  }

  hideToast() {
    this.toastTarget.classList.add("opacity-0")

    setTimeout(() => {
      this.toastTarget.remove()
    }, 300)
  }
}
