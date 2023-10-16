import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition";

let profileMenuStatus = false
// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ["mobileMenuButton", "user", "profileMenu", "mobileMenu", "hamburgerIcon", "closeIcon"]
  connect() {
  }
  toggleProfileMenu(){
    profileMenuStatus = !profileMenuStatus
    if (profileMenuStatus) {
      enter(this.profileMenuTarget);
    } else {
      leave(this.profileMenuTarget);
    }
  }
}
