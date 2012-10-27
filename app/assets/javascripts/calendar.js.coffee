jQuery ->
  if $('body').hasClass('calendars_show')
    # Damit wir nicht mehrfach das neuladen aufrufen ... :D
    window.currentlyReloading = false
    

    # Normale click, etc handler ... Sollte selbsterklärend sein ;)
    $('.js-calendar-export').on 'click', ->
      alert('Hier würde nun dein Kalender exportiert ... :D')

    $(document).on 'mouseenter', '.calendar-line', ->
      $(this).css('background-color', $(this).data('hlcolor')).addClass('calendar-line-highlighted')

    $(document).on 'mouseleave', '.calendar-line', ->
      $(this).css('background-color', '#000').removeClass('calendar-line-highlighted')

    $('.js-kddk-preset').on 'click', CalendarPreset.switchPreset

    $('.js-like-tag-button').on 'click', ->
      CalendarTaggings.addTag('like')

    $('.js-like-tag-text').on 'keyup', (event) ->
      CalendarTaggings.addTag('like') if event.keyCode is 13 or event.which is 13
    
    $('.js-hate-tag-button').on 'click', ->
      CalendarTaggings.addTag('hate')

    $('.js-hate-tag-text').on 'keyup', (event) ->
      CalendarTaggings.addTag('hate') if event.keyCode is 13 or event.which is 13
    
    $('input[name=calendar_category]').on 'change', ->
      CalendarPreset.changeDiyPreset()

    $(document).on 'click', '.js-remove-tag', ->
      data = $(this).parent().data()
      $(this).parent().remove()
      CalendarTaggings.removeTag(data.list, data.tag)
    
    # Alle handler sind gesetzt ... Initialisieren wir die DIY-Kategorie
    # Dadurch wird ein Neuladen des Kalenders getriggert. So hat jemand der JS aus hat den gesamten Kalender,
    # und mit JS wird die Kategorie ersetzt ... Ich weiß nicht, ob man das so lassen kann oder sollte, da es ein komisches
    # neuladen ist
    CalendarPreset.selectCategoriesFromPreset('diy')

    # Selbstgebautes Infinite Scroll ... Ernsthaft, da is net viel dabei ... Ich weiß nicht, warum ich eine Lib verwenden sollte
    $(window).scroll ->
      if $(window).scrollTop() > $(document).height() - $(window).height() - 200 and  not window.currentlyReloading and not window.endOfTheWorld
        window.currentlyReloading = true
        Calendar.appendEntries()
        # TODO: Der kann noch ein wenig schöner gestyled werden
        $('.calendar-calendar').append('<div class="well js-append-indicator">Ich lade weitere Einträge, hab Geduld :-)</div>')


# Gesammelte Funktionen um den gesamten Kalender aufzurufen ... Object wird hier als Namespace mißbraucht ... Ich hoffe
# das Object verzeihts mir ... Aufrufen muss man eigentlich nur die ersten beiden Funktionen.
Calendar =
  # Lade die Einträge und hänge sie an die Liste UNTEN dran
  # calendarScrollFrom und calendarScrollTo werden von dem nachgeladenen Content gesetzt
  appendEntries: ->
    Calendar.getEntries calendarScrollFrom, calendarScrollTo, (data) ->
      $('.js-append-indicator').remove()
      $('.calendar-calendar').append(data)
      window.currentlyReloading = false

  # Hier werden die Einträge geladen und der Kalender wird komplett ersetzt
  # Das wird benutzt, wenn der Benutzer sein Preset verändert
  #
  # Die Zeiten sind der Anfang des Kalenders (heute oder explizites Anfangsdatum) bis zum letzten sichtbaren Tag
  replaceEntries: ->
    Calendar.getEntries beginningOfTime, calendarScrollFrom, (data) ->
      $('.calendar-calendar').html(data)
  
  # Interne Funktion für den AJAX Call ;)
  getEntries: (from, to, callback) ->
    $.ajax
      type: 'GET'
      url: '/calendar/entries'
      data:
        from: from
        to: to
        categories: CalendarPreset.getCategories().join()
      success: (data) ->
        callback(data)

# Methods that are used for the taggings in the calendar
# Values for list are:
#    like -> liked/loved tags
#    hate -> hated tags
#
CalendarTaggings =
  # Adds the tag from the input to the list and saves it on the server
  addTag: (list) ->
    tag = $(".js-#{list}-tag-text").val()
    $(".js-#{list}-taglist").append "<li data-tag=\"#{tag}\" data-list=\"#{list}\">#{tag} <i class=\"icon-remove remove-tag js-remove-tag\"></li>"
    $(".js-#{list}-tag-text").val('')

    $.ajax
       type: 'POST'
       url: "/user/#{list}"
       data:
         tags: [tag]
       success: (data) ->
         if data.status is 'error'
           # TODO: Eventuell ein schöneres Alert
           alert "Da ging wat schief: #{data.message}"
    
    # Reload the calendar with the new data
    Calendar.getEntries(Calendar.replaceEntries)

  removeTag: (list, tag) ->
    $.ajax
       type: 'DELETE'
       url: "/user/#{list}/#{tag}"
       success: (data) ->
         if data.status is 'error'
           # TODO: Eventuell ein schöneres Alert
           alert "Da ging wat schief: #{data.message}"

    # Reload the calendar with the new data
    Calendar.replaceEntries()


CalendarPreset =
  getCategories: ->
    categories = $('input[name=calendar_category]:checked').map (idx, el) ->
      $(el).val()
    categories.get()

  changeDiyPreset: ->
    categories = $('input[name=calendar_category]:checked').map (idx, el) ->
      $(el).val()
    
    # TODO: Eventuell abfangen, ob der User überhaupt eingeloggt ist (JS Variable
    # oder so) und nur dann abschicken, spart uns ein paar 401er im Log ... If somebody
    # cares: Patch is welcome :)
    $.ajax
     type: 'POST'
     url: "/calendar/presets"
     data:
       category_ids: categories.get().join(',')
    
    # Reload the calendar with the new data
    Calendar.replaceEntries()

  switchPreset: ->
    presetId = $(this).data('preset')

    # Reset active tab
    $('.js-kddk-preset').removeClass('active')
    $(this).addClass('active')

    CalendarPreset.selectCategoriesFromPreset(presetId)

  selectCategoriesFromPreset: (presetId) ->
    $all_checkboxes = $('input[name=calendar_category]')

    if presetId
      presetId = presetId.toString()
    else
      presetId = 'diy'

    $all_checkboxes.attr 'disabled', (presetId != 'diy')

    if presetId == 'diy' and calendarPresets[presetId].length == 0
      $all_checkboxes.attr('checked', true)
    else
      $all_checkboxes.attr('checked', false)

      $.each calendarPresets[presetId], (id, categoryId)->
        $('input[name=calendar_category][value=' + categoryId + ']').attr('checked', true)

    # Reload the calendar with the new data
    Calendar.replaceEntries()

