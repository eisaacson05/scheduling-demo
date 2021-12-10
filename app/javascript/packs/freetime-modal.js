import $ from "jquery";

$(document).ready(function() {

    // On free time click, display model
    $('.free-time-cell').on( 'click', (e) => {
        const displayText = e.target.dataset.displayText;
        $("#modal-text").text( displayText );
        $("#modal").css( "display", "block" )
    });

    // On exit button click, close modal
    $('.close').on( 'click', () => {
        $("#modal").css( "display", "none" )
    })

    // On click outside modal, close modal
    $(window).on( 'click', (e) => {
        if (e.target == $("#free-time-modal"))
            $("#modal").css( "display", "none" )
    })
});