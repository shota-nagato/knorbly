import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { patch } from "@rails/request.js"

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      handle: "[data-sortable-handle]",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) {
      this.sortable.destroy()
    }
  }

  async onEnd(event) {
    const { item, newIndex } = event
    const url = item.dataset.sortableUrl

    if (!url) return

    const position = newIndex + 1

    await patch(url, {
      body: JSON.stringify({ folder: { position } }),
      contentType: "application/json"
    })
  }
}

