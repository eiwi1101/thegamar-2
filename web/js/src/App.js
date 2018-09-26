import React, { Component } from "react";
import "./App.css";

import Prompt from './prompt'
import {connect} from 'react-redux'
import Message from './message'

class App extends Component {

  componentDidMount() {
    this.scrollToBottom();
  }

  componentDidUpdate() {
    this.scrollToBottom();
  }

  scrollToBottom() {
    this.messageEnd.scrollIntoView({ behavior: 'smooth' });
  }

  render() {
    console.log(this.props, this.props.state.commands)

    return (
      <div id="container" className={'tomorrow-night-eighties-ansi-theme'}>
        <section id="main">
          <section id="messages-list">
            { this.props.state.commands.map((s) => <Message {...s} />) }
            <span ref={(el) => { this.messageEnd = el }} />
          </section>
          <section id="new-message">
            <Prompt socket={this.props.socket} />
          </section>
        </section>
        <aside id="sidebar">Map / Bags / Etc</aside>
      </div>
    );
  }
}

const mapStateToProps = (state) => ({
  state
})

const mapDispatchToProps = (dispatch) => ({
  dispatch
})

export default connect(mapStateToProps, mapDispatchToProps)(App);
