import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';

import './index.css';
import App from './App';
import registerServiceWorker from './registerServiceWorker';
import game from './reducers'
import setupSocket from './socket'

const store = createStore(game);

const socket = setupSocket(store.dispatch, store.getState);

ReactDOM.render(
  <Provider store={store}>
    <App socket={socket} />
  </Provider>,
  document.getElementById('root')
);

registerServiceWorker();
