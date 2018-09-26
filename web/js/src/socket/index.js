import * as types from '../constants/ActionTypes'
import { addError, addCritical, addPrompt } from '../actions'

const setupSocket = (dispatch, username) => {
  const socket = new WebSocket(`ws://${window.location.hostname}:8989`)

  socket.onopen = () => {
    socket.send(JSON.stringify({
      type: 'COMMAND',
      command: "look"
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
        dispatch(addPrompt(data.data))
        break
      case 'SERVER':
        console.log("SERVER:", data)
        break;
      default:
        console.error(`Unhandled: ${JSON.stringify(data)}`)
        break
    }
  }

  return socket
}

export default setupSocket
