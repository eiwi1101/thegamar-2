const commands = (state = [], action) => {
  switch (action.type) {
    case 'COMMAND_RECEIVED':
      return state.concat([
        {
          command: action.command
        }
      ])
    default:
      return state
  }
}

export default commands
