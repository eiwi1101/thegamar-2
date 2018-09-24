const commands = (state = [], action) => {
  console.log(action)

  switch (action.type) {
    case 'PROMPT':
      return state.concat([
        {
          type: 'PROMPT',
          id: action.id,
          message: action.message,
          metadata: action.metadata
        }
      ])
    case 'INPUT':
      return state.concat([
        {
          type: 'INPUT',
          id: action.id,
          command: action.command
        }
      ])
    case 'ERROR':
      return state.concat([
        {
          type: 'ERROR',
          id: action.id,
          message: action.message
        }
      ])
    case 'CRITICAL':
      return state.concat([
        {
          type: 'CRITICAL',
          id: action.id,
          message: action.message
        }
      ])
    default:
      return state
  }
}

export default commands
