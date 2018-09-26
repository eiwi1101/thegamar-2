import React, { Component } from 'react'
import {addInput} from '../actions'
import {connect} from 'react-redux'

class Prompt extends Component {

  constructor(props) {
    super(props)

    this.state = {
      command: ''
    }

    this.handleInputChange = this.handleInputChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleInputChange(e) {
    e.preventDefault()
    this.setState({command: e.target.value})
  }

  handleSubmit(e) {
    e.preventDefault()
    const command = this.state.command
    this.props.onInput(command)
    this.props.socket.send(JSON.stringify({type: 'COMMAND', command: command}))
    this.setState({command: ''})
  }

  render() {
    return(<div id='prompt'>
      <form onSubmit={this.handleSubmit}>
        <input type={'text'} name={'command'} onChange={this.handleInputChange} value={this.state.command} autoComplete={'off'} />
        <input type={'submit'} value={'>'} />
      </form>
    </div>)
  }
}

const mapStateToProps = (state) => {
  return {
    state
  }
}

const mapDispatchToProps = (dispatch) => {
  return {
    onInput: (input) => {
      dispatch(addInput(input))
    }
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(Prompt)
