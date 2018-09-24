import React, { Component } from "react";
import AnsiUp from 'ansi_up'
import "./App.css";

import Prompt from './prompt'
import {connect} from 'react-redux'

class App extends Component {
  render() {
    console.log(this.props, this.props.state.commands)
    const ansi_up = new AnsiUp()

    return (
      <div id="container">
        <section id="main">
          <section id="messages-list">
            { this.props.state.commands.map((s) => <div key={s.id} dangerouslySetInnerHTML={{__html: ansi_up.ansi_to_html(s.message)}} />) }
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
