import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  closeSidebar() {
    document.querySelector("#sidebar").classList.remove("translate-x-0")
    document.querySelector("#sidebar").classList.add("-translate-x-64")

    document.querySelector("#sidebar-bg").classList.add("hidden", "pointer-events-none")
  }
}
