import React, { Component } from 'react'
import AnsiUp from 'ansi_up'

class Message extends Component {
  render() {
    const Ansi = ({children, style}) => {
      if(!children) return null;

      const ansi_up = new AnsiUp()
      ansi_up.use_classes = true
      const html = ansi_up.ansi_to_html(children)
      return (<div style={style} dangerouslySetInnerHTML={{__html: html}} /> )
    }

    const renderHash = (hash) => {
      return (
        <table valign="top" className='message-hash' style={{width: 'auto', marginTop: '1rem'}}>
          {Object.keys(hash).map((k) => (
            <tr className='message-hash-row' key={k}>
              <td valign="top" style={{paddingLeft: '1rem'}}>{k}</td>
              <td valign="top" style={{paddingLeft: '1rem'}}>
                <Ansi style={{display: 'inline-block'}}>{hash[k]}</Ansi>
              </td>
            </tr>
          ))}
        </table>
      )
    }

    const renderTable = (table) => {
      if(!table.map) return renderHash(table)

      return (
        <table valign="top" className='message-table' style={{width: 'auto', marginTop: '1rem'}}>
          {table.map((row, i) => (
            <tr key={i}>
              {row.map((col, j) => (
                <td key={j} valign="top" style={{paddingLeft: '1rem'}}><Ansi style={{display: 'inline'}}>{col}</Ansi></td>
              ))}
            </tr>
          ))}
        </table>
      )
    }

    switch(this.props.type) {
      case "INPUT":
        return (<div className='input-command ansi-blue-fg' style={{marginTop: '1rem'}}>&gt;&nbsp;{this.props.command}</div>)
      case "ERROR":
        return (<div className='input-error ansi-red-fg'>{this.props.message}</div>)
      case "CRITICAL":
        return (<div className='input-critical ansi-bright-red-fg'>ERROR: {this.props.message}</div>)
      default:
        break;
    }

    const {
      title,
      message,
      hash,
      table
    } = this.props

    let additional = this.props.additional || []

    if(!additional.map) additional = [additional]

    return (<div className='input-message' key={this.props.id}>
      <Ansi className='title'>{title}</Ansi>
      <Ansi className='message'>{message}</Ansi>
      { additional.map((a) => <Ansi>{a}</Ansi>) }
      { hash && renderHash(hash) }
      { table && renderTable(table) }
    </div>)
  }
}

export default Message
