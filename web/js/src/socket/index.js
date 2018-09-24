import * as types from '../constants/ActionTypes'
import { addError, addCritical, addPrompt } from '../actions'

const setupSocket = (dispatch, username) => {
  const socket = new WebSocket(`ws://${window.location.hostname}:8989`)

  socket.onopen = () => {
    socket.send(JSON.stringify({
      type: types.ADD_USER,
      name: username
    }))
  }

  socket.onmessage = (event) => {
    const data = JSON.parse(event.data)
    console.log({data})
    switch (data.type) {
      case types.ERROR:
        dispatch(addError(data.message))
        break
      case types.CRITICAL:
        dispatch(addCritical(data.message))
        break
      case types.PROMPT:
        dispatch(addPrompt(data.message))
        break
      default:
        dispatch(addError(`Unhandled: ${JSON.stringify(data)}`))
        break
    }
  }

  return socket
}

export default setupSocket
