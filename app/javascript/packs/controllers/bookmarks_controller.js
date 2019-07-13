import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ["output"]

  bookmark(event) {
    event.preventDefault();
    fetch(`/api/v1/bookmarks/`, {
      method: "POST"
      })
      .then((response) => response.json())
      .then(function(response) {
        const flash = document.querySelector(`.flash-message`);
        flash.inner
      });
  }

  // needsLogin(event) {
  //   this.buttonTarget 
  // }
}
