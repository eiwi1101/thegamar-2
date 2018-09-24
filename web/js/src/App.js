import React, { Component } from "react";
import "./App.css";

import Prompt from './prompt'
import {connect} from 'react-redux'
import Message from './message'

class App extends Component {
  render() {
    console.log(this.props, this.props.state.commands)

    return (
      <div id="container">
        <section id="main">
          <section id="messages-list">
            { this.props.state.commands.map((s) => <Message {...s} />) }
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
