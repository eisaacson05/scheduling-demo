// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import $ from 'jquery';
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()


$(document).ready(function() {

    const modal = document.getElementById("free-time-modal");
    const modal_text = document.getElementById("free-time-modal-text");
    $('.free-time-cell').on( 'click', (e) => {
        const time_available = e.target.dataset.timeAvailable;
        modal_text.innerText = time_available;
        modal.style.display = "block";
        }
    );

    $('.close').on( 'click', () => {
        modal.style.display = "none";
    })

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
});



