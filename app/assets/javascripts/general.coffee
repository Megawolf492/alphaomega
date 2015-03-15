$ ->
    $(".datetimepicker").datetimepicker
        formatTime: 'g:i A'
    $('.new_model').magnificPopup
        type:'inline'
        midClick: true
        showCloseBtn: false
        closeOnBgClick: true
    $('.select2').select2()
    ClientSideValidations.callbacks.element.fail = (element, message, callback, eventData) ->
        if(element.next("div").hasClass("error"))
            element.next("div.error").remove()
        element.attr("marginB", element.css("margin-bottom"))
        element.css({"border-color": "#FF6961", "margin": "0"})
        element.after("<div class='error' style='font-size: 12px; line-height: 16px; color: #FF6961'>#{message[0].toUpperCase()}#{message[1..-1]}</div>")
        false

    ClientSideValidations.callbacks.element.pass = (element, callback, eventData) ->
        if(element.next("div").hasClass("error"))
            marginB = element.attr("marginB")
        element.css({"border-color": "", "margin-bottom": marginB})
        element.next("div.error").remove()
