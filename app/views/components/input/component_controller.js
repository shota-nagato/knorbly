import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  submit(event) {
    event.preventDefault();
    this.formTarget.requestSubmit();
  }

  search(event) {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.submit(event)
    }, 500)
  }
}
