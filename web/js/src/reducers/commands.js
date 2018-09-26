const commands = (state = [], action) => {
  console.log(action)

  switch (action.type) {
    case 'PROMPT':
      return state.concat([
        action
      ])
    case 'INPUT':
      return state.concat([
        action
      ])
    case 'ERROR':
      return state.concat([
        action
      ])
    case 'CRITICAL':
      return state.concat([
        action
      ])
    default:
      return state
  }
}

export default commands
