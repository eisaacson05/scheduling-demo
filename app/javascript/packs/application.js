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
    const modalText = document.getElementById("free-time-modal-text");

    // On free time click, display model
    $('.free-time-cell').on( 'click', (e) => {
            const displayText = e.target.dataset.displayText;
            modalText.innerText = displayText;
            modal.style.display = "block";
        }
    );

    // On exit button click, close modal
    $('.close').on( 'click', () => { modal.style.display = "none"; })

    // On click outside modal, close modal
    window.onclick = (e) => {
        if (e.target == modal)  e.style.display = "none"
    }
});