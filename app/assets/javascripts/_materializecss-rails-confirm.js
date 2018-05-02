$(function() {
  $.rails.allowAction = function(link) {
    if (!link.attr("data-confirm")) {
      return true;
    }

    $.rails.showConfirmDialog(link);
    return false;
  };

  $.rails.confirmed = function(link) {
    link.removeAttr("data-confirm");
    return link.trigger("click.rails");
  };

  return $.rails.showConfirmDialog = function(link) {
    var html, message;
    html = void 0;
    message = void 0;
    message = link.attr("data-confirm");
    back = "<div id=\"ModalConfirmBackground\" style=\"position: fixed; width: 100%; height: 100%; background: #00000040; z-index: 999; top: 0; left: 0;\"></div>"
    html = "<div id=\"ModalConfirm\" class=\"modal\" style=\"z-index: 1021; display: block; opacity: 1; transform: scaleX(1); top: 10%; width: 500px;\"> <div class=\"modal-content\"><h6>" + message + "</h6></div><div class=\"modal-footer\"><a class=\"modal-action modal-close waves-effect waves-red btn-flat btn_close_modal_confirm\">Annuler</a><a class=\"modal-action modal-close waves-effect waves-green btn-flat btn_confirm_modal_confirm\">OK</a></div></div>";
    $("body").append(html);
    $("body").append(back);
    $("#ModalConfirm").hide();
    $("#ModalConfirm").slideDown();
    $("#ModalConfirm").modal({
      complete: function() {
        return $("#ModalConfirm").remove();
      }
    });

    $(".btn_close_modal_confirm").on("click", function() {
      $("#ModalConfirmBackground").fadeOut(function() { $(this).remove(); });
      $("#ModalConfirm").slideUp(function() { $(this).remove(); });
    });

    return $("#ModalConfirm .btn_confirm_modal_confirm").on("click", function() {
      $("#ModalConfirmBackground").fadeOut(function() { $(this).remove(); });
      $("#ModalConfirm").slideUp(function() { $(this).remove(); });
      return $.rails.confirmed(link);
      
    });
  };
});