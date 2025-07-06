import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "loading"
  ]

  displayLoading() {
    this.loadingTarget.classList.remove("hidden")
  }

  hiddenLoading() {
    this.loadingTarget.classList.add("hidden")
  }
}
