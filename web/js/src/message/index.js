import React, { Component } from 'react'
import AnsiUp from 'ansi_up'

class Message extends Component {
  render() {
    const ansi_up = new AnsiUp()
    ansi_up.use_classes = true
    const html = ansi_up.ansi_to_html(this.props.message)

    return(<div className='tomorrow-night-eighties-ansi-theme' key={this.props.id} dangerouslySetInnerHTML={{__html: html}} />)
  }
}

export default Message
