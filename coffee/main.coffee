class Main
  constructor: ->
    @initAspect()
    @initSlider()
    @initEvents()
    @update()

  initAspect: ->
    frame = $('#main .frame')
    frame.css 'height', frame.width() * 9 / 16

  initSlider: ->
    self = @
    $('#slider').slider
      min: 0
      max: 20
      step: 0.1
      value: 7
      # orientation: "vertical"
      change: (e, ui) ->
        $('form .camera_h').val ui.value
        self.update()
      slide: (e, ui) ->
        $('form .camera_h').val ui.value
        self.update()

  initEvents: ->
    self = @
    $('form .floor_w').change ->
      val = Number($(this).val())
      if isNaN(val)
        val = 16
        $(this).val val
      $('#slider').slider
        max: val * 5
      $('form .floor_h').val val * 9 / 16
      self.update()

    $('form .floor_h').change ->
      val = Number($(this).val())
      if isNaN(val)
        val = 16
        $(this).val val
      $('form .floor_w').val val * 16/9
      self.update()

    $('form .wall_h').change ->
      val = Number($(this).val())
      if isNaN(val)
        val = 3
        $(this).val val
      # $('form .floor_').val val * 16/9
      self.update()

    $('form .camera_h').change ->
      val = Number($(this).val())
      if isNaN(val)
        val = 10
        $(this).val val
      # $('form .floor_').val val * 16/9
      # $('#slider').slider
      #   value: val
      self.update()

  update: ->
    floor_w = Number($('form .floor_w').val())
    wall_h = Number($('form .wall_h').val())
    camera_h = Number($('form .camera_h').val())

    # a = Math.atan2(floor_w, camera_h)
    # b = Math.atan2(floor_w, camera_h - wall_h)
    # rate = a / b

    rate_inner = (camera_h - wall_h) / camera_h

    # console.log rate_inner
    $('#main .floor').css('transform', "scale(#{rate_inner}, #{rate_inner})")

    rate_outer = floor_w / (camera_h - wall_h) * Math.tan(65/360.0)

    $('#main .wall').css('transform', "scale(#{rate_outer}, #{rate_outer})")

$ ->
  new Main