import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  openSidebar() {
    document.querySelector("#sidebar").classList.remove("-translate-x-full")
    document.querySelector("#sidebar").classList.add("translate-x-0")

    document.querySelector("#sidebar-bg").classList.remove("hidden", "pointer-events-none")
    // document.querySelector("#sidebar-bg").classList.add("opacity-100")
  }
}
