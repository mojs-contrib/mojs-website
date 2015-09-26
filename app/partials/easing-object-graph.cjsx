EasingGraph   = require './easing-graph'
EasingObject  = require './easing-object'
HeftyContent  = require './hefty-content'
Hammer        = require 'hammerjs'

React         = require 'react'
Tappable      = require 'react-tappable'
mojs          = require 'mo-js'

require '../css/partials/easing-object-graph.styl'

module.exports = React.createClass
  getInitialState:-> @_isShow = false; { isSquash: false, pop: 'object' }
  getDefaultProps:->
    path:     'M 0,100 L 100,0'
    duration: 2000
    delay:    1000

  _start:-> @_isTweensAdded and @_timeline.start(); @_isShow = true
  _stop:->  @_timeline.pause(); @_isShow = false
  _onAdd:-> @_isTweensAdded = true; (@_isShow or !@_isShow?) and @_start()

  _onHide:-> @setState isSquash: false

  _showObject:(e)-> @_toggleSquash(e); @setState pop: 'object'
  _showGraph:(e)->  @_toggleSquash(e); @setState pop: 'graph'
  _toggleSquash:(e)-> e?.stopPropagation(); @setState isSquash: !@state.isSquash

  _makeGraph:->
    if !@props.isGraphLess
      <Tappable onTap = @_showGraph >
        <EasingGraph
          easing    = {@_easing}
          timeline  = {@_timeline}
          label     = {@props.label}
          duration  = {@props.duration}
          delay     = {@props.delay}
          path      = {@props.path}
          onAdd     = {@_onAdd} >
        </EasingGraph>
      </Tappable>
    else @_onAdd?()

  render:->
    @_timeline ?= new mojs.Timeline repeat: 99999999

    @_easing ?= if mojs.h.isArray @props.path
      for path, i in @props.path
        mojs.easing.path @props.path[i], precompute: 2000, eps: .001
    else [ mojs.easing.path @props.path, precompute: 2000, eps: .001 ]

    className = if (@state.isSquash) then "is-squash is-pop-#{@state.pop}" else ''
    <HeftyContent
      className       = "easing-object-graph #{className} is-pop-#{@state.pop}"
      onShow          = { => @_start() } onHide={ => @_stop(); @_onHide() }
      isLaunchOnHover = { true } >

      <div className="easing-object-graph__inner">
        
        <Tappable onTap = @_showObject >
          <EasingObject
            timeline    = {@_timeline}
            easing      = {@_easing}
            duration    = {@props.duration}
            delay       = {@props.delay}
            onStart     = {@props.onStart}
            onUpdate    = {@props.onUpdate}
            background  = {@props.background}>
            {@props.children}
          </EasingObject>
        </Tappable>

        { @_makeGraph() }

      </div>
    </HeftyContent>
